import { useState, useEffect, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { supabase } from '../../lib/supabase'
import { X, Send, Phone, PhoneOff, Mic, MicOff } from 'lucide-react'
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
  const [callState, setCallState] = useState<'idle' | 'calling' | 'receiving' | 'in-call'>('idle')
  const [isMuted, setIsMuted] = useState(false)
  const peerConnectionRef = useRef<RTCPeerConnection | null>(null)
  const localStreamRef = useRef<MediaStream | null>(null)
  const remoteAudioRef = useRef<HTMLAudioElement>(null)
  const channelRef = useRef<any>(null)

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

    // Create a unique room for these two users (order IDs to ensure they join the same room)
    const roomId = [currentUserId, peerId].sort().join('-')
    
    channelRef.current = supabase.channel(`webrtc-${roomId}`, {
      config: { broadcast: { self: false } }
    })

    channelRef.current.on('broadcast', { event: 'webrtc-signal' }, async ({ payload }: any) => {
      if (payload.targetId !== currentUserId) return

      if (payload.type === 'call-offer') {
        setCallState('receiving')
        // Store offer to accept later
        window.incomingCallOffer = payload.sdp
      } else if (payload.type === 'call-answer') {
        if (peerConnectionRef.current) {
          await peerConnectionRef.current.setRemoteDescription(new RTCSessionDescription(payload.sdp))
        }
      } else if (payload.type === 'ice-candidate') {
        if (peerConnectionRef.current) {
          await peerConnectionRef.current.addIceCandidate(new RTCIceCandidate(payload.candidate))
        }
      } else if (payload.type === 'call-end') {
        cleanupCall()
        toast("Call ended by " + peerRole)
      }
    }).subscribe()

    return () => {
      cleanupCall()
      supabase.removeChannel(channelRef.current)
    }
  }, [isOpen, currentUserId, peerId, peerRole])

  const sendSignal = (type: string, data: any) => {
    channelRef.current?.send({
      type: 'broadcast',
      event: 'webrtc-signal',
      payload: { type, targetId: peerId, ...data }
    })
  }

  // 3. WebRTC Methods
  const initPeerConnection = async () => {
    const pc = new RTCPeerConnection({ iceServers: [{ urls: 'stun:stun.l.google.com:19302' }] })
    peerConnectionRef.current = pc

    pc.onicecandidate = (event) => {
      if (event.candidate) sendSignal('ice-candidate', { candidate: event.candidate })
    }

    pc.ontrack = (event) => {
      if (remoteAudioRef.current) {
        remoteAudioRef.current.srcObject = event.streams[0]
      }
    }

    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false })
      localStreamRef.current = stream
      stream.getTracks().forEach(track => pc.addTrack(track, stream))
    } catch (err) {
      toast.error("Microphone access denied.")
      throw err
    }
    return pc
  }

  const startCall = async () => {
    setCallState('calling')
    try {
      const pc = await initPeerConnection()
      const offer = await pc.createOffer()
      await pc.setLocalDescription(offer)
      sendSignal('call-offer', { sdp: offer })
    } catch (e) {
      cleanupCall()
    }
  }

  const acceptCall = async () => {
    setCallState('in-call')
    try {
      const pc = await initPeerConnection()
      const offer = window.incomingCallOffer
      if (offer) {
        await pc.setRemoteDescription(new RTCSessionDescription(offer))
        const answer = await pc.createAnswer()
        await pc.setLocalDescription(answer)
        sendSignal('call-answer', { sdp: answer })
      }
    } catch (e) {
      cleanupCall()
    }
  }

  const cleanupCall = () => {
    sendSignal('call-end', {})
    localStreamRef.current?.getTracks().forEach(track => track.stop())
    if (peerConnectionRef.current) {
      peerConnectionRef.current.close()
      peerConnectionRef.current = null
    }
    if (remoteAudioRef.current) remoteAudioRef.current.srcObject = null
    setCallState('idle')
    setIsMuted(false)
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
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/40 backdrop-blur-sm">
      <motion.div initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} className="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl overflow-hidden flex flex-col h-[600px] border border-slate-200 dark:border-slate-800">
        
        {/* Header */}
        <div className="px-5 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-slate-50 dark:bg-slate-800/50 shrink-0">
          <div>
            <h3 className="font-bold text-slate-900 dark:text-white">Chat with {peerRole}</h3>
            <p className="text-xs text-slate-500">Secure Direct Messaging</p>
          </div>
          <div className="flex items-center gap-3">
            {callState === 'idle' && (
              <button onClick={startCall} className="p-2 bg-green-100 text-green-700 hover:bg-green-200 dark:bg-green-900/30 dark:text-green-400 rounded-full transition" title="Start Voice Call">
                <Phone size={18} />
              </button>
            )}
            <button onClick={onClose} className="p-2 text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-800 rounded-full transition">
              <X size={18} />
            </button>
          </div>
        </div>

        {/* Active Call UI */}
        <AnimatePresence>
          {callState !== 'idle' && (
            <motion.div initial={{ height: 0 }} animate={{ height: 'auto' }} exit={{ height: 0 }} className="bg-slate-900 text-white overflow-hidden shrink-0">
              <div className="p-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className={cn("w-3 h-3 rounded-full animate-pulse", callState === 'in-call' ? 'bg-green-500' : 'bg-amber-500')} />
                  <span className="font-medium text-sm">
                    {callState === 'calling' ? 'Calling...' : callState === 'receiving' ? 'Incoming Call...' : 'In Call'}
                  </span>
                </div>
                <div className="flex items-center gap-3">
                  {callState === 'receiving' && (
                    <button onClick={acceptCall} className="px-4 py-1.5 bg-green-500 hover:bg-green-600 rounded-full text-sm font-bold transition">Accept</button>
                  )}
                  {callState === 'in-call' && (
                    <button onClick={toggleMute} className={cn("p-2 rounded-full transition", isMuted ? "bg-red-500/20 text-red-500" : "bg-slate-700 hover:bg-slate-600")}>
                      {isMuted ? <MicOff size={18} /> : <Mic size={18} />}
                    </button>
                  )}
                  <button onClick={cleanupCall} className="p-2 bg-red-500 hover:bg-red-600 text-white rounded-full transition" title="End Call">
                    <PhoneOff size={18} />
                  </button>
                </div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Hidden Audio Tag for remote stream */}
        <audio ref={remoteAudioRef} autoPlay />

        {/* Messages List */}
        <div className="flex-1 overflow-y-auto p-4 space-y-4 bg-slate-50/50 dark:bg-slate-900/50">
          {loading ? (
            <p className="text-center text-slate-400 text-sm mt-10">Loading messages...</p>
          ) : messages.length === 0 ? (
            <p className="text-center text-slate-400 text-sm mt-10">No messages yet. Start the conversation!</p>
          ) : (
            messages.map(msg => {
              const isMe = msg.sender_id === currentUserId
              return (
                <div key={msg.id} className={cn("flex", isMe ? "justify-end" : "justify-start")}>
                  <div className={cn("max-w-[75%] rounded-2xl px-4 py-2 text-sm shadow-sm", isMe ? "bg-brand-600 text-white rounded-br-none" : "bg-white dark:bg-slate-800 border border-slate-100 dark:border-slate-700 text-slate-800 dark:text-slate-200 rounded-bl-none")}>
                    {msg.content_type === 'audio' ? (
                      <audio controls src={msg.content_url_or_text} className="h-8 max-w-full" />
                    ) : (
                      <p className="whitespace-pre-wrap">{msg.content_url_or_text}</p>
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
            <button type="submit" disabled={!input.trim()} className="p-2 bg-brand-600 text-white rounded-xl hover:bg-brand-700 disabled:opacity-50 transition">
              <Send size={18} />
            </button>
          </form>
        </div>

      </motion.div>
    </div>
  )
}
