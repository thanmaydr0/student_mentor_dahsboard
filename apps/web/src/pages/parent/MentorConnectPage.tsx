import React, { useState, useEffect, useRef } from 'react'
import { MessageSquare, Video, Phone, Calendar, Send, MoreVertical, Paperclip, Smile } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import Input from '../../components/ui/Input'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import toast from 'react-hot-toast'

export default function MentorConnectPage() {
  const { user } = useAuth()
  const [message, setMessage] = useState('')
  const [messages, setMessages] = useState<any[]>([])
  const [mentor, setMentor] = useState<any>(null)
  const messagesEndRef = useRef<HTMLDivElement>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    async function loadChat() {
      // 1. Get the assigned mentor via parent_student_links -> student -> mentor
      const { data: link } = await supabase
        .from('parent_student_links')
        .select('student_id, profiles!parent_student_links_student_id_fkey(mentor_id)')
        .eq('parent_id', user?.id)
        .single()
        
      if (!link || !link.profiles?.mentor_id) {
         // Fallback to dummy mentor for demonstration if not linked
         setMentor({ id: 'dummy-mentor', full_name: 'Academic Mentor' })
         return
      }
      
      const mentorId = link.profiles.mentor_id
      
      const { data: mentorData } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', mentorId)
        .single()
        
      setMentor(mentorData)

      // 2. Fetch past messages between this parent and the mentor
      const { data: pastMsgs } = await supabase
        .from('direct_messages')
        .select('*')
        .or(`and(sender_id.eq.${user?.id},receiver_id.eq.${mentorId}),and(sender_id.eq.${mentorId},receiver_id.eq.${user?.id})`)
        .order('created_at', { ascending: true })

      if (pastMsgs) setMessages(pastMsgs)

      // 3. Subscribe to new messages
      const channel = supabase.channel('direct_messages_updates')
        .on('postgres_changes', { 
            event: 'INSERT', 
            schema: 'public', 
            table: 'direct_messages',
            filter: `receiver_id=eq.${user?.id}`
        }, (payload) => {
            if (payload.new.sender_id === mentorId) {
               setMessages(prev => [...prev, payload.new])
            }
        })
        .subscribe()

      return () => {
        supabase.removeChannel(channel)
      }
    }
    
    if (user?.id) loadChat()
  }, [user?.id])

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  const handleSend = async () => {
    if (!message.trim() || !user) return
    
    const newMsg = {
      sender_id: user.id,
      receiver_id: mentor?.id || 'dummy-mentor',
      content_type: 'text',
      content_url_or_text: message.trim()
    }
    
    // Optimistic UI update
    setMessages(prev => [...prev, { ...newMsg, id: 'temp-'+Date.now(), created_at: new Date().toISOString() }])
    setMessage('')
    
    if (mentor?.id && mentor.id !== 'dummy-mentor') {
       await supabase.from('direct_messages').insert(newMsg)
    }
  }

  const handleQuickAction = async (type: 'video' | 'meeting') => {
    if (!user) return
    
    const text = type === 'video' 
      ? `📅 Hello Prof. ${mentor?.full_name || 'Mentor'}, I would like to request a quick Video Call to discuss my child's progress. Please let me know when you are available.`
      : `📅 Hello Prof. ${mentor?.full_name || 'Mentor'}, I would like to schedule an in-person meeting with you at the campus. Please let me know your available slots.`

    const newMsg = {
      sender_id: user.id,
      receiver_id: mentor?.id || 'dummy-mentor',
      content_type: 'text',
      content_url_or_text: text
    }

    setMessages(prev => [...prev, { ...newMsg, id: 'temp-'+Date.now(), created_at: new Date().toISOString() }])
    toast.success(`${type === 'video' ? 'Video call' : 'Meeting'} request sent!`)
    
    if (mentor?.id && mentor.id !== 'dummy-mentor') {
       await supabase.from('direct_messages').insert(newMsg)
    }
  }

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file || !user) return
    
    // Simulate upload delay
    toast.loading('Sending attachment...', { id: 'upload' })
    setTimeout(async () => {
       const text = `📎 Attached file: ${file.name}`
       const newMsg = {
          sender_id: user.id,
          receiver_id: mentor?.id || 'dummy-mentor',
          content_type: 'text',
          content_url_or_text: text
       }
       setMessages(prev => [...prev, { ...newMsg, id: 'temp-'+Date.now(), created_at: new Date().toISOString() }])
       if (mentor?.id && mentor.id !== 'dummy-mentor') {
          await supabase.from('direct_messages').insert(newMsg)
       }
       toast.success('Attachment sent', { id: 'upload' })
    }, 1000)
  }

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') handleSend()
  }

  return (
    <AppShell role="parent">
      <div className="max-w-7xl mx-auto flex flex-col h-[calc(100vh-6rem)]">
        
        {/* Header */}
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 pb-4 mb-4 shrink-0">
          <div className="flex flex-col gap-2">
            <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
              <MessageSquare className="text-brand-600 dark:text-brand-400" size={28} />
              Mentor Connect
            </h1>
            <p className="text-slate-500 dark:text-slate-400 text-sm">
              Direct, real-time communication with the assigned academic mentor.
            </p>
          </div>
        </div>

        {/* Chat Application Container */}
        <div className="flex-1 flex bg-white dark:bg-[#0c0d10] border border-slate-200 dark:border-white/10 rounded-2xl overflow-hidden shadow-xl shadow-brand-500/5 min-h-0">
          
          {/* Left Sidebar: Mentor Info (Hidden on mobile) */}
          <div className="w-80 border-r border-slate-200 dark:border-white/10 hidden md:flex flex-col shrink-0 bg-slate-50/50 dark:bg-[#13151a]/50">
            <div className="p-8 border-b border-slate-200 dark:border-white/10 flex flex-col items-center text-center">
              <div className="w-24 h-24 rounded-full bg-slate-200 dark:bg-white/10 mb-4 overflow-hidden border-4 border-white dark:border-[#0c0d10] shadow-sm">
                <img src={mentor?.avatar_url || `https://api.dicebear.com/7.x/avataaars/svg?seed=${mentor?.full_name || 'Mentor'}&backgroundColor=c0aede`} alt="Mentor" className="w-full h-full object-cover" />
              </div>
              <h3 className="text-lg font-black text-slate-900 dark:text-white">{mentor ? `Prof. ${mentor.full_name}` : 'Loading...'}</h3>
              <p className="text-sm font-bold text-brand-600 dark:text-brand-400 mt-1">Senior Academic Mentor</p>
            </div>
            
            <div className="p-6 flex-1 overflow-y-auto space-y-6">
               <div>
                 <h4 className="font-bold text-slate-900 dark:text-white text-sm mb-3">Quick Actions</h4>
                 <div className="space-y-2">
                   <button onClick={() => handleQuickAction('video')} className="w-full flex items-center justify-center gap-2 py-3 bg-slate-900 dark:bg-white text-white dark:text-slate-900 hover:bg-black dark:hover:bg-slate-200 rounded-xl font-bold text-sm transition active:scale-95">
                     <Video size={16} /> Request Video Call
                   </button>
                   <button onClick={() => handleQuickAction('meeting')} className="w-full flex items-center justify-center gap-2 py-3 border border-slate-200 dark:border-white/10 text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/5 rounded-xl font-bold text-sm transition active:scale-95">
                     <Calendar size={16} /> Schedule Meeting
                   </button>
                 </div>
               </div>

               <div className="p-4 bg-blue-50 dark:bg-blue-900/10 rounded-xl border border-blue-100 dark:border-blue-900/30">
                 <h4 className="font-bold text-blue-900 dark:text-blue-400 text-sm flex items-center gap-2 mb-2">
                   <Phone size={14} /> Contact Hours
                 </h4>
                 <p className="text-sm text-blue-800 dark:text-blue-300 font-medium">Mon - Fri, 9:00 AM - 4:00 PM</p>
                 <p className="text-xs text-blue-600/70 dark:text-blue-400/70 mt-2">Expect replies within 2-4 hours during business days.</p>
               </div>
            </div>
          </div>

          {/* Right Area: Chat Interface */}
          <div className="flex-1 flex flex-col min-w-0 bg-white dark:bg-[#0c0d10]">
             {/* Chat Header */}
             <div className="h-16 px-6 border-b border-slate-200 dark:border-white/10 flex items-center justify-between bg-white/50 dark:bg-[#13151a]/50 backdrop-blur-md shrink-0">
               <div className="flex items-center gap-3">
                 <div className="relative">
                   <div className="w-10 h-10 rounded-full bg-slate-200 dark:bg-white/10 overflow-hidden border border-slate-200 dark:border-white/10 md:hidden">
                     <img src={mentor?.avatar_url || `https://api.dicebear.com/7.x/avataaars/svg?seed=${mentor?.full_name || 'Mentor'}&backgroundColor=c0aede`} alt="Mentor" className="w-full h-full object-cover" />
                   </div>
                   <div className="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-white dark:border-[#13151a] rounded-full md:hidden"></div>
                 </div>
                 <div>
                   <h3 className="font-bold text-slate-900 dark:text-white flex items-center gap-2">
                     {mentor?.full_name || 'Mentor'}
                     <span className="hidden md:flex w-2 h-2 rounded-full bg-emerald-500"></span>
                   </h3>
                   <p className="text-xs text-emerald-600 dark:text-emerald-400 font-bold md:hidden">Online</p>
                 </div>
               </div>
               <button className="p-2 text-slate-400 hover:text-slate-900 dark:hover:text-white rounded-lg transition">
                 <MoreVertical size={20} />
               </button>
             </div>

             {/* Chat Messages */}
             <div className="flex-1 overflow-y-auto p-4 sm:p-6 space-y-6 custom-scrollbar bg-slate-50/50 dark:bg-transparent">
                <div className="flex justify-center">
                  <span className="px-3 py-1 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 shadow-sm rounded-full text-xs font-bold text-slate-500 dark:text-slate-400">Today</span>
                </div>
                
                {messages.length === 0 && (
                  <div className="flex flex-col items-center justify-center h-full text-slate-400 dark:text-slate-500 space-y-3">
                    <MessageSquare size={48} className="opacity-20" />
                    <p className="text-sm font-medium">No messages yet. Start the conversation!</p>
                  </div>
                )}
                
                {messages.map((msg) => {
                  const isMe = msg.sender_id === user?.id;
                  return (
                    <div key={msg.id} className={`flex ${isMe ? 'justify-end' : 'justify-start'} group`}>
                      <div className={`max-w-[85%] sm:max-w-[70%] flex flex-col ${isMe ? 'items-end' : 'items-start'}`}>
                        <div className={`px-5 py-3.5 rounded-2xl shadow-sm ${
                          isMe 
                            ? 'bg-brand-600 text-white rounded-tr-sm' 
                            : 'bg-white dark:bg-[#1a1d24] border border-slate-200 dark:border-white/5 text-slate-800 dark:text-slate-200 rounded-tl-sm'
                        }`}>
                          <p className="text-sm leading-relaxed whitespace-pre-wrap">{msg.content_url_or_text}</p>
                        </div>
                        <span className="text-[10px] font-bold text-slate-400 dark:text-slate-500 mt-1.5 px-1 opacity-0 group-hover:opacity-100 transition-opacity">
                          {new Date(msg.created_at).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}
                        </span>
                      </div>
                    </div>
                  );
                })}
                <div ref={messagesEndRef} />
             </div>

             {/* Chat Input */}
             <div className="p-4 bg-white dark:bg-[#0c0d10] border-t border-slate-200 dark:border-white/10 shrink-0">
                <div className="flex items-end gap-2 sm:gap-3 bg-slate-50 dark:bg-[#1a1d24] rounded-2xl border border-slate-200 dark:border-white/5 p-2 focus-within:ring-2 focus-within:ring-brand-500/20 focus-within:border-brand-500 transition-all">
                  
                  <input type="file" ref={fileInputRef} className="hidden" onChange={handleFileUpload} />
                  
                  <button onClick={() => fileInputRef.current?.click()} className="p-3 text-slate-400 hover:text-brand-600 dark:hover:text-brand-400 transition shrink-0 rounded-xl hover:bg-white dark:hover:bg-white/5">
                    <Paperclip size={20} />
                  </button>
                  <textarea 
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === 'Enter' && !e.shiftKey) {
                        e.preventDefault();
                        handleSend();
                      }
                    }}
                    placeholder="Type your message here..." 
                    className="flex-1 bg-transparent border-none focus:ring-0 text-sm text-slate-900 dark:text-white placeholder:text-slate-400 resize-none max-h-32 min-h-[44px] py-3 custom-scrollbar"
                    rows={1}
                  />
                  <button onClick={handleSend} disabled={!message.trim()} className="p-3 bg-brand-600 disabled:bg-slate-300 dark:disabled:bg-white/10 text-white rounded-xl hover:bg-brand-700 transition shadow-sm shrink-0 disabled:shadow-none disabled:cursor-not-allowed cursor-pointer disabled:opacity-50">
                    <Send size={18} className="ml-0.5" />
                  </button>
                </div>
                <p className="text-center text-[10px] font-medium text-slate-400 mt-2">Press Enter to send, Shift + Enter for new line.</p>
             </div>
          </div>
        </div>
      </div>
    </AppShell>
  )
}
