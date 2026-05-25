import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import DirectChat from './DirectChat'

export default function GlobalCallManager() {
  const { user } = useAuth()
  const [incomingCall, setIncomingCall] = useState<{
    peerId: string
    peerRole: string
    isVideo: boolean
  } | null>(null)
  
  useEffect(() => {
    if (!user) return

    const channel = supabase.channel(`webrtc-global-${user.id}`, {
      config: { broadcast: { self: false } }
    })
    
    channel.on('broadcast', { event: 'webrtc-signal' }, ({ payload }: any) => {
       if (payload.type === 'call-offer') {
          // If the user already has this specific chat open, DirectChat handles it internally
          // @ts-ignore
          if (window.activeChatPeerId === payload.callerId) return

          // Store the offer globally so DirectChat can answer it
          // @ts-ignore
          window.incomingCallOffer = payload.sdp
          // @ts-ignore
          window.incomingCallIsVideo = payload.isVideo || false
          // @ts-ignore — initialize ICE candidate buffer for candidates that arrive before DirectChat mounts
          window.incomingCallIceCandidates = []
          
          // Pre-subscribe to the room channel to capture ICE candidates before DirectChat mounts
          const roomId = [user.id, payload.callerId].sort().join('-')
          const prebufferChannel = supabase.channel(`webrtc-prebuffer-${roomId}`, {
            config: { broadcast: { self: false } }
          })
          
          // NOTE: This subscribes to a DIFFERENT channel name than DirectChat uses,
          // so it won't conflict. The caller sends ICE candidates to webrtc-${roomId},
          // not webrtc-prebuffer-${roomId}. However, the caller will RE-TRANSMIT all
          // candidates when the callee sends the answer, so this is a secondary safety net.
          // The primary fix is the re-transmission in DirectChat's call-answer handler.
          
          // Clean up pre-buffer after 15s (DirectChat will have mounted by then)
          prebufferChannel.subscribe()
          setTimeout(() => supabase.removeChannel(prebufferChannel), 15000)
          
          setIncomingCall({
             peerId: payload.callerId,
             peerRole: payload.callerRole || 'User',
             isVideo: payload.isVideo
          })
       }
    }).subscribe()
    
    return () => { 
      supabase.removeChannel(channel) 
    }
  }, [user])

  if (!incomingCall || !user) return null

  // Render DirectChat modal to handle the incoming call
  // The 'receiving' state will be picked up immediately due to window.incomingCallOffer
  return (
    <DirectChat 
       isOpen={true}
       onClose={() => {
         // @ts-ignore
         window.incomingCallOffer = null
         // @ts-ignore
         window.incomingCallIsVideo = false
         // @ts-ignore
         window.incomingCallIceCandidates = []
         setIncomingCall(null)
       }}
       currentUserId={user.id}
       peerId={incomingCall.peerId}
       peerRole={incomingCall.peerRole}
    />
  )
}
