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

  // Render a hidden or overlay DirectChat modal to handle the incoming call
  // The 'receiving' state will be picked up immediately due to window.incomingCallOffer
  return (
    <DirectChat 
       isOpen={true}
       onClose={() => {
         // @ts-ignore
         window.incomingCallOffer = null
         // @ts-ignore
         window.incomingCallIsVideo = false
         setIncomingCall(null)
       }}
       currentUserId={user.id}
       peerId={incomingCall.peerId}
       peerRole={incomingCall.peerRole}
    />
  )
}
