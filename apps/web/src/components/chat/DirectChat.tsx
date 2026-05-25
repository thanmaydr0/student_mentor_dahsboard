import { useState, useEffect, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { supabase } from '../../lib/supabase'
import { X, Send, Phone, PhoneOff, Mic, MicOff, Video, VideoOff } from 'lucide-react'
import toast from 'react-hot-toast'
import { cn } from '../../lib/utils'

interface DirectChatProps {
  isOpen: boolean
  onClose: () => void
  currentUserId: string
  peerId: string
  peerRole: string // e.g. "Mentor", "Parent"
}

interface Message {
  id: string
  sender_id: string
  receiver_id: string
  content_type: 'text' | 'audio'
  content_url_or_text: string
  created_at: string
}

export default function DirectChat({ isOpen, onClose, currentUserId, peerId, peerRole }: DirectChatProps) {
  const [messages, setMessages] = useState<Message[]>([])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(true)
  const messagesEndRef = useRef<HTMLDivElement>(null)

  // WebRTC State
  const [callState, setCallState] = useState<'idle' | 'calling' | 'receiving' | 'in-call'>(() => {
    // @ts-ignore
    return typeof window !== 'undefined' && window.incomingCallOffer ? 'receiving' : 'idle'
  })
  const [isVideoCall, setIsVideoCall] = useState<boolean>(() => {
    // @ts-ignore
    return typeof window !== 'undefined' && window.incomingCallIsVideo ? true : false
  })
  const [isMuted, setIsMuted] = useState(false)
  const [isVideoOff, setIsVideoOff] = useState(false)
  const [hasRemoteVideo, setHasRemoteVideo] = useState(false)
  
  const peerConnectionRef = useRef<RTCPeerConnection | null>(null)
  const iceCandidateQueueRef = useRef<any[]>([])
  const localIceCandidatesRef = useRef<any[]>([])
  const localStreamRef = useRef<MediaStream | null>(null)
  
  // Media element refs
  const remoteAudioRef = useRef<HTMLAudioElement>(null)
  const localVideoRef = useRef<HTMLVideoElement>(null)
  const remoteVideoRef = useRef<HTMLVideoElement>(null)
  const channelRef = useRef<any>(null)

  // Track active chat globally to prevent duplicate modals
  useEffect(() => {
    if (isOpen) {
      // @ts-ignore
      window.activeChatPeerId = peerId
    }
    return () => {
      // @ts-ignore
      window.activeChatPeerId = null
    }
  }, [isOpen, peerId])

  // 1. Fetch Chat History & Subscribe
  useEffect(() => {
    if (!isOpen) return

    const fetchMessages = async () => {
      const { data, error } = await supabase
        .from('direct_messages')
        .select('*')
        .or(`and(sender_id.eq.${currentUserId},receiver_id.eq.${peerId}),and(sender_id.eq.${peerId},receiver_id.eq.${currentUserId})`)
        .order('created_at', { ascending: true })

      if (!error && data) setMessages(data)
      setLoading(false)
    }

    fetchMessages()

    const channel = supabase.channel(`direct_messages_${currentUserId}_${peerId}`)
      .on('postgres_changes', {
        event: 'INSERT',
        schema: 'public',
        table: 'direct_messages',
        filter: `receiver_id=eq.${currentUserId}`,
      }, (payload) => {
        if (payload.new.sender_id === peerId) {
          setMessages(prev => [...prev, payload.new as Message])
        }
      })
      .subscribe()

    return () => {
      supabase.removeChannel(channel)
    }
  }, [isOpen, currentUserId, peerId])

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  // 2. WebRTC Signaling via Supabase Broadcast
  useEffect(() => {
    if (!isOpen) return

    const roomId = [currentUserId, peerId].sort().join('-')
    
    channelRef.current = supabase.channel(`webrtc-${roomId}`, {
      config: { broadcast: { self: false } }
    })

    channelRef.current.on('broadcast', { event: 'webrtc-signal' }, async ({ payload }: any) => {
      if (payload.targetId !== currentUserId) return

      if (payload.type === 'call-offer') {
        setCallState('receiving')
        setIsVideoCall(payload.isVideo || false)
        iceCandidateQueueRef.current = []
        // @ts-ignore
        window.incomingCallOffer = payload.sdp
        // @ts-ignore
        window.incomingCallIceCandidates = []
      } else if (payload.type === 'call-answer') {
        if (peerConnectionRef.current) {
          setCallState('in-call')
          await peerConnectionRef.current.setRemoteDescription(new RTCSessionDescription(payload.sdp))
          
          // CRITICAL: Re-transmit ALL of our ICE candidates to the receiver.
          // They may have missed candidates sent before their DirectChat component mounted.
          for (const candidate of localIceCandidatesRef.current) {
            sendSignal('ice-candidate', { candidate })
          }

          // Process any queued ICE candidates from the receiver
          for (const candidate of iceCandidateQueueRef.current) {
            try {
              await peerConnectionRef.current?.addIceCandidate(new RTCIceCandidate(candidate))
            } catch (e) {
              console.warn('[WebRTC] Error adding queued ICE candidate:', e)
            }
          }
          iceCandidateQueueRef.current = []
        }
      } else if (payload.type === 'ice-candidate') {
        if (peerConnectionRef.current && peerConnectionRef.current.remoteDescription) {
          try {
            await peerConnectionRef.current.addIceCandidate(new RTCIceCandidate(payload.candidate))
          } catch (e) {
            console.warn('[WebRTC] Error adding ICE candidate:', e)
          }
        } else {
          // Buffer for later — PeerConnection not ready yet
          iceCandidateQueueRef.current.push(payload.candidate)
        }
      } else if (payload.type === 'call-end') {
        cleanupCall(false) // Don't echo call-end back
        toast("Call ended by " + peerRole)
      }
    }).subscribe()

    return () => {
      cleanupCall(true) // Notify peer if we had an active call
      if (channelRef.current) supabase.removeChannel(channelRef.current)
    }
  }, [isOpen, currentUserId, peerId, peerRole])

  const sendSignal = (type: string, data: any) => {
    channelRef.current?.send({
      type: 'broadcast',
      event: 'webrtc-signal',
      payload: { type, targetId: peerId, ...data }
    })
  }

  // ═══════════════════════════════════════════════════════════════
  // 3. TURN Credential Fetching (Metered.ca free tier — 500GB/mo)
  // ═══════════════════════════════════════════════════════════════
  const fetchIceServers = async (): Promise<RTCIceServer[]> => {
    const apiKey = import.meta.env.VITE_METERED_API_KEY

    // Always include redundant public STUN servers for fastest candidate gathering
    const stunServers: RTCIceServer[] = [
      { urls: 'stun:stun.l.google.com:19302' },
      { urls: 'stun:stun1.l.google.com:19302' },
      { urls: 'stun:stun2.l.google.com:19302' },
      { urls: 'stun:stun3.l.google.com:19302' },
      { urls: 'stun:stun4.l.google.com:19302' },
      { urls: 'stun:global.stun.twilio.com:3478' },
    ]

    if (!apiKey) {
      console.warn('[WebRTC] ⚠️ No VITE_METERED_API_KEY configured — TURN relay unavailable. Cross-network calls WILL FAIL for most Indian ISPs.')
      return stunServers
    }

    try {
      const appName = import.meta.env.VITE_METERED_APP_NAME || 'edupredict'
      const res = await fetch(
        `https://${appName}.metered.live/api/v1/turn/credentials?apiKey=${apiKey}`
      )
      if (!res.ok) throw new Error(`Metered API returned ${res.status}`)
      const turnServers: RTCIceServer[] = await res.json()
      console.log('[WebRTC] ✅ TURN credentials fetched:', turnServers.length, 'relay servers')
      return [...stunServers, ...turnServers]
    } catch (err) {
      console.error('[WebRTC] ❌ TURN credential fetch failed:', err)
      return stunServers
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // 4. PeerConnection Initialization with Full Monitoring
  // ═══════════════════════════════════════════════════════════════
  const initPeerConnection = async (withVideo: boolean) => {
    const iceServers = await fetchIceServers()
    console.log('[WebRTC] Initializing with', iceServers.length, 'ICE servers')

    const pc = new RTCPeerConnection({
      iceServers,
      iceCandidatePoolSize: 10, // Pre-allocate candidates for faster connection
    })
    peerConnectionRef.current = pc

    // ── ICE Candidate Gathering ─────────────────────────────────
    pc.onicecandidate = (event) => {
      if (event.candidate) {
        const json = event.candidate.toJSON()
        localIceCandidatesRef.current.push(json)
        sendSignal('ice-candidate', { candidate: json })
      }
    }

    // ── Connection State Monitoring with Auto-Recovery ──────────
    pc.oniceconnectionstatechange = () => {
      const state = pc.iceConnectionState
      console.log('[WebRTC] ICE state →', state)

      switch (state) {
        case 'checking':
          toast('Establishing connection...', { icon: '🔄', id: 'webrtc-status', duration: 5000 })
          break
        case 'connected':
        case 'completed':
          toast.success('Call connected!', { id: 'webrtc-status' })
          break
        case 'disconnected':
          toast('Connection interrupted, recovering...', { icon: '⚠️', id: 'webrtc-status' })
          // Wait 3s then attempt ICE restart if still disconnected
          setTimeout(() => {
            if (peerConnectionRef.current?.iceConnectionState === 'disconnected') {
              console.log('[WebRTC] Auto ICE restart...')
              peerConnectionRef.current.restartIce()
            }
          }, 3000)
          break
        case 'failed':
          toast.error('Connection failed. Retrying...', { id: 'webrtc-status' })
          try {
            pc.restartIce()
          } catch {
            toast.error('Could not recover. Please hang up and try again.', { id: 'webrtc-status' })
          }
          break
      }
    }

    // ── Remote Track Handler (Audio + Video) ────────────────────
    pc.ontrack = (event) => {
      console.log('[WebRTC] Remote track received:', event.track.kind, '| readyState:', event.track.readyState)
      
      // Prefer event.streams[0]; fallback to manual MediaStream (Safari/iOS compat)
      const stream = event.streams?.[0] || new MediaStream([event.track])

      if (event.track.kind === 'audio' && remoteAudioRef.current) {
        remoteAudioRef.current.srcObject = stream
        // Explicit play() to bypass autoplay policy — user already gestured by clicking Call/Accept
        remoteAudioRef.current.play().catch(e =>
          console.warn('[WebRTC] Audio autoplay blocked:', e)
        )
      }

      if (event.track.kind === 'video' && remoteVideoRef.current) {
        remoteVideoRef.current.srcObject = stream
        remoteVideoRef.current.play().catch(e =>
          console.warn('[WebRTC] Video autoplay blocked:', e)
        )
        setHasRemoteVideo(true)
      }
    }

    // ── Acquire Local Media ─────────────────────────────────────
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
        },
        video: withVideo
          ? { width: { ideal: 1280, max: 1920 }, height: { ideal: 720, max: 1080 }, facingMode: 'user' }
          : false,
      })
      localStreamRef.current = stream

      if (withVideo && localVideoRef.current) {
        localVideoRef.current.srcObject = stream
      }

      stream.getTracks().forEach(track => pc.addTrack(track, stream))
    } catch (err) {
      toast.error(withVideo ? 'Camera or Microphone access denied.' : 'Microphone access denied.')
      throw err
    }

    return pc
  }

  // ═══════════════════════════════════════════════════════════════
  // 5. Call Lifecycle Methods
  // ═══════════════════════════════════════════════════════════════
  const startCall = async (withVideo: boolean) => {
    setIsVideoCall(withVideo)
    setCallState('calling')
    localIceCandidatesRef.current = []
    iceCandidateQueueRef.current = []

    try {
      const pc = await initPeerConnection(withVideo)
      const offer = await pc.createOffer()
      await pc.setLocalDescription(offer)

      const sdpJson = pc.localDescription!.toJSON()
      sendSignal('call-offer', { sdp: sdpJson, isVideo: withVideo })

      // Also broadcast on global channel for when receiver doesn't have this chat open
      const globalChannel = supabase.channel(`webrtc-global-${peerId}`)
      globalChannel.subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await globalChannel.send({
            type: 'broadcast',
            event: 'webrtc-signal',
            payload: {
              type: 'call-offer',
              callerId: currentUserId,
              callerRole: 'Caller',
              isVideo: withVideo,
              sdp: sdpJson,
            }
          })
          setTimeout(() => supabase.removeChannel(globalChannel), 2000)
        }
      })
    } catch (e) {
      console.error('[WebRTC] startCall error:', e)
      cleanupCall(false)
    }
  }

  const acceptCall = async () => {
    setCallState('in-call')
    localIceCandidatesRef.current = []

    try {
      const pc = await initPeerConnection(isVideoCall)
      // @ts-ignore
      const offer = window.incomingCallOffer
      if (!offer) {
        toast.error('Call offer expired. Ask them to call again.')
        cleanupCall(false)
        return
      }

      await pc.setRemoteDescription(new RTCSessionDescription(offer))

      // Process ALL queued ICE candidates — from both room channel buffer and global buffer
      // @ts-ignore
      const globalCandidates: any[] = window.incomingCallIceCandidates || []
      const allQueued = [...globalCandidates, ...iceCandidateQueueRef.current]
      console.log('[WebRTC] Processing', allQueued.length, 'queued ICE candidates on accept')

      for (const candidate of allQueued) {
        try {
          await pc.addIceCandidate(new RTCIceCandidate(candidate))
        } catch (e) {
          console.warn('[WebRTC] Error adding queued candidate:', e)
        }
      }
      iceCandidateQueueRef.current = []
      // @ts-ignore
      window.incomingCallIceCandidates = []

      const answer = await pc.createAnswer()
      await pc.setLocalDescription(answer)
      sendSignal('call-answer', { sdp: pc.localDescription!.toJSON() })
    } catch (e) {
      console.error('[WebRTC] acceptCall error:', e)
      toast.error('Failed to accept call.')
      cleanupCall(true)
    }
  }

  const cleanupCall = (sendEnd = true) => {
    // Notify peer only if we have an active PeerConnection
    if (sendEnd && peerConnectionRef.current) {
      try { sendSignal('call-end', {}) } catch {}
    }

    // Stop all local media tracks
    localStreamRef.current?.getTracks().forEach(track => track.stop())
    localStreamRef.current = null

    // Tear down PeerConnection and remove all listeners
    if (peerConnectionRef.current) {
      peerConnectionRef.current.onicecandidate = null
      peerConnectionRef.current.oniceconnectionstatechange = null
      peerConnectionRef.current.ontrack = null
      peerConnectionRef.current.close()
      peerConnectionRef.current = null
    }

    // Clear media elements
    if (remoteAudioRef.current) remoteAudioRef.current.srcObject = null
    if (remoteVideoRef.current) remoteVideoRef.current.srcObject = null
    if (localVideoRef.current) localVideoRef.current.srcObject = null

    // Clear global state
    // @ts-ignore
    window.incomingCallOffer = null
    // @ts-ignore
    window.incomingCallIceCandidates = []

    setCallState('idle')
    setIsVideoCall(false)
    setIsMuted(false)
    setIsVideoOff(false)
    setHasRemoteVideo(false)
    iceCandidateQueueRef.current = []
    localIceCandidatesRef.current = []
  }

  const toggleMute = () => {
    if (localStreamRef.current) {
      const audioTrack = localStreamRef.current.getAudioTracks()[0]
      if (audioTrack) {
        audioTrack.enabled = !audioTrack.enabled
        setIsMuted(!audioTrack.enabled)
      }
    }
  }

  const toggleVideoFeed = () => {
    if (localStreamRef.current) {
      const videoTrack = localStreamRef.current.getVideoTracks()[0]
      if (videoTrack) {
        videoTrack.enabled = !videoTrack.enabled
        setIsVideoOff(!videoTrack.enabled)
      }
    }
  }

  const sendMessage = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!input.trim()) return

    const newMsg = {
      sender_id: currentUserId,
      receiver_id: peerId,
      content_type: 'text' as const,
      content_url_or_text: input.trim(),
    }

    setInput('')
    // Optimistic UI update
    setMessages(prev => [...prev, { ...newMsg, id: Date.now().toString(), created_at: new Date().toISOString() }])

    const { error } = await supabase.from('direct_messages').insert(newMsg)
    if (error) toast.error("Failed to send message.")
  }

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
      <motion.div 
        initial={{ opacity: 0, scale: 0.95 }} 
        animate={{ opacity: 1, scale: 1 }} 
        className={cn(
          "bg-white dark:bg-slate-900 w-full rounded-2xl shadow-2xl overflow-hidden flex flex-col md:flex-row h-[600px] border border-slate-200 dark:border-slate-800 transition-all duration-300",
          callState !== 'idle' && isVideoCall ? "max-w-4xl" : "max-w-lg"
        )}
      >
        
        {/* Chat Section */}
        <div className="flex flex-col flex-1 min-w-0">
          {/* Header */}
          <div className="px-5 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-slate-50 dark:bg-slate-800/50 shrink-0">
            <div>
              <h3 className="font-bold text-slate-900 dark:text-white">Chat with {peerRole}</h3>
              <p className="text-xs text-slate-500">Secure Direct Messaging</p>
            </div>
            <div className="flex items-center gap-2">
              {callState === 'idle' && (
                <>
                  <button onClick={() => startCall(false)} className="p-2 bg-slate-100 text-slate-600 hover:bg-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700 rounded-full transition" title="Start Voice Call">
                    <Phone size={18} />
                  </button>
                  <button onClick={() => startCall(true)} className="p-2 bg-brand-100 text-brand-700 hover:bg-brand-200 dark:bg-brand-900/30 dark:text-brand-400 dark:hover:bg-brand-900/50 rounded-full transition" title="Start Video Call">
                    <Video size={18} />
                  </button>
                </>
              )}
              <button onClick={onClose} className="p-2 ml-2 text-slate-400 hover:bg-red-100 hover:text-red-500 dark:hover:bg-red-500/20 rounded-full transition">
                <X size={18} />
              </button>
            </div>
          </div>

          {/* Active Call Status Bar (Audio Only or Controls) */}
          <AnimatePresence>
            {callState !== 'idle' && (
              <motion.div initial={{ height: 0 }} animate={{ height: 'auto' }} exit={{ height: 0 }} className="bg-slate-900 text-white overflow-hidden shrink-0 z-10 shadow-md">
                <div className="p-3 flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className={cn("w-3 h-3 rounded-full animate-pulse", callState === 'in-call' ? 'bg-green-500' : 'bg-amber-500')} />
                    <span className="font-medium text-sm">
                      {callState === 'calling' ? 'Calling...' : callState === 'receiving' ? (isVideoCall ? 'Incoming Video Call...' : 'Incoming Call...') : 'In Call'}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    {callState === 'receiving' && !isVideoCall && (
                      <button onClick={acceptCall} className="px-4 py-1.5 bg-green-500 hover:bg-green-600 rounded-full text-sm font-bold transition">Accept</button>
                    )}
                    {callState === 'in-call' && (
                      <>
                        <button onClick={toggleMute} className={cn("p-2 rounded-full transition", isMuted ? "bg-red-500/20 text-red-500" : "bg-slate-700 hover:bg-slate-600")}>
                          {isMuted ? <MicOff size={16} /> : <Mic size={16} />}
                        </button>
                        {isVideoCall && (
                          <button onClick={toggleVideoFeed} className={cn("p-2 rounded-full transition", isVideoOff ? "bg-red-500/20 text-red-500" : "bg-slate-700 hover:bg-slate-600")}>
                            {isVideoOff ? <VideoOff size={16} /> : <Video size={16} />}
                          </button>
                        )}
                      </>
                    )}
                    <button onClick={() => cleanupCall(true)} className="p-2 bg-red-500 hover:bg-red-600 text-white rounded-full transition" title="End Call">
                      <PhoneOff size={16} />
                    </button>
                  </div>
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          {/* Hidden Audio Tag for remote voice stream */}
          <audio ref={remoteAudioRef} autoPlay playsInline />

          {/* Messages List */}
          <div className="flex-1 overflow-y-auto p-4 space-y-4 bg-slate-50/50 dark:bg-slate-900/50 relative">
            {loading ? (
              <p className="text-center text-slate-400 text-sm mt-10">Loading messages...</p>
            ) : messages.length === 0 ? (
              <p className="text-center text-slate-400 text-sm mt-10">No messages yet. Start the conversation!</p>
            ) : (
              messages.map(msg => {
                const isMe = msg.sender_id === currentUserId
                return (
                  <div key={msg.id} className={cn("flex", isMe ? "justify-end" : "justify-start")}>
                    <div className={cn("max-w-[85%] rounded-2xl px-4 py-2 text-sm shadow-sm", isMe ? "bg-brand-600 text-white rounded-br-none" : "bg-white dark:bg-slate-800 border border-slate-100 dark:border-slate-700 text-slate-800 dark:text-slate-200 rounded-bl-none")}>
                      {msg.content_type === 'audio' ? (
                        <audio controls src={msg.content_url_or_text} className="h-8 max-w-full" />
                      ) : (
                        <p className="whitespace-pre-wrap leading-relaxed">{msg.content_url_or_text}</p>
                      )}
                    </div>
                  </div>
                )
              })
            )}
            <div ref={messagesEndRef} />
          </div>

          {/* Input Area */}
          <div className="p-4 bg-white dark:bg-slate-900 border-t border-slate-100 dark:border-slate-800 shrink-0">
            <form onSubmit={sendMessage} className="flex gap-2">
              <input 
                type="text" 
                value={input} 
                onChange={e => setInput(e.target.value)}
                placeholder="Type a message..."
                className="flex-1 rounded-xl bg-slate-100 dark:bg-slate-800 border-transparent focus:bg-white focus:ring-2 focus:ring-brand-500 px-4 py-2 text-sm dark:text-white"
              />
              <button type="submit" disabled={!input.trim()} className="p-2.5 bg-brand-600 text-white rounded-xl hover:bg-brand-700 disabled:opacity-50 transition">
                <Send size={18} />
              </button>
            </form>
          </div>
        </div>

        {/* Video Call Section (Expands on the right side if isVideoCall) */}
        {callState !== 'idle' && isVideoCall && (
          <div className="w-full md:w-[400px] lg:w-[500px] bg-slate-950 relative flex flex-col items-center justify-center border-l border-slate-800 shrink-0 overflow-hidden">
            
            {/* Remote Video (Main) */}
            <video 
              ref={remoteVideoRef} 
              autoPlay 
              playsInline 
              className={cn("w-full h-full object-cover transition-opacity duration-500", callState === 'in-call' ? 'opacity-100' : 'opacity-0')}
            />
            
            {/* Local Video (Picture-in-Picture) */}
            <div className="absolute bottom-4 right-4 w-28 h-40 md:w-32 md:h-48 bg-slate-800 rounded-xl overflow-hidden border-2 border-white/20 shadow-2xl z-20">
              <video 
                ref={localVideoRef} 
                autoPlay 
                playsInline 
                muted 
                className="w-full h-full object-cover transform scale-x-[-1]" 
              />
              {isVideoOff && (
                <div className="absolute inset-0 bg-slate-900/80 backdrop-blur-sm flex items-center justify-center text-white/50">
                  <VideoOff size={24} />
                </div>
              )}
            </div>

            {/* Call Overlay UI for Incoming/Calling states */}
            {(callState === 'calling' || callState === 'receiving') && (
              <div className="absolute inset-0 flex flex-col items-center justify-center bg-slate-900/90 backdrop-blur-md z-10 text-white p-6 text-center">
                <div className="w-20 h-20 rounded-full bg-brand-500/20 flex items-center justify-center mb-6 relative">
                  <div className="absolute inset-0 rounded-full bg-brand-500/20 animate-ping" />
                  <div className="w-14 h-14 rounded-full bg-brand-500 flex items-center justify-center relative z-10">
                    <Video size={28} />
                  </div>
                </div>
                <h3 className="font-semibold text-xl mb-2">{callState === 'calling' ? 'Calling...' : 'Incoming Video Call'}</h3>
                <p className="text-slate-400 text-sm mb-8">
                  {callState === 'calling' ? `Waiting for ${peerRole} to accept...` : `${peerRole} is requesting a video call.`}
                </p>
                
                {callState === 'receiving' && (
                  <button onClick={acceptCall} className="px-8 py-3 bg-green-500 hover:bg-green-600 rounded-full font-bold shadow-lg shadow-green-500/20 transition transform hover:scale-105 active:scale-95 flex items-center gap-2">
                    <Video size={18} />
                    Accept Video Call
                  </button>
                )}
              </div>
            )}
            
            {/* Overlay if remote camera is off but call is active */}
            {callState === 'in-call' && !hasRemoteVideo && (
              <div className="absolute inset-0 flex flex-col items-center justify-center bg-slate-900 text-slate-500 z-10">
                <VideoOff size={48} className="mb-4 opacity-50" />
                <p>Waiting for video feed...</p>
              </div>
            )}
          </div>
        )}

      </motion.div>
    </div>
  )
}
