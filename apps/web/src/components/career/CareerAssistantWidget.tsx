import { useState, useRef, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { MessageSquare, X, Send, Bot, User, Sparkles } from 'lucide-react'
import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import { supabase } from '../../lib/supabase'

interface ChatMessage {
  role: 'user' | 'assistant'
  content: string
}

const INITIAL_MESSAGE: ChatMessage = { 
  role: 'assistant', 
  content: "Hi! I'm your AI Career Coach. I can help you tailor your resume, prepare for interviews, or write cover letters. What would you like to focus on today?" 
}

const SUGGESTIONS = [
  "Review my resume",
  "How to answer 'Tell me about yourself'",
  "Salary negotiation tips"
]

export default function CareerAssistantWidget() {
  const [isOpen, setIsOpen] = useState(false)
  const [messages, setMessages] = useState<ChatMessage[]>([])
  const [input, setInput] = useState('')
  const [isTyping, setIsTyping] = useState(false)
  const messagesEndRef = useRef<HTMLDivElement>(null)

  // Load from local storage
  useEffect(() => {
    const saved = localStorage.getItem('career_assistant_history')
    if (saved) {
      try {
        setMessages(JSON.parse(saved))
      } catch(e) {
        setMessages([INITIAL_MESSAGE])
      }
    } else {
      setMessages([INITIAL_MESSAGE])
    }
  }, [])

  // Save to local storage on change
  useEffect(() => {
    if (messages.length > 0) {
      localStorage.setItem('career_assistant_history', JSON.stringify(messages))
    }
  }, [messages])

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }

  useEffect(() => {
    if (isOpen) {
      scrollToBottom()
    }
  }, [messages, isOpen, isTyping])

  const handleSend = async (text: string) => {
    if (!text.trim()) return

    const newMessages: ChatMessage[] = [...messages, { role: 'user', content: text.trim() }]
    setMessages(newMessages)
    setInput('')
    setIsTyping(true)

    try {
      const { data, error } = await supabase.functions.invoke('career-assistant', {
        body: { messages: newMessages.slice(-5) }
      })
      if (error) throw error
      
      setMessages([...newMessages, { role: 'assistant', content: data.reply }])
    } catch (e) {
      setMessages([...newMessages, { role: 'assistant', content: "Sorry, I'm having trouble connecting right now." }])
    } finally {
      setIsTyping(false)
    }
  }

  const clearHistory = () => {
    setMessages([INITIAL_MESSAGE])
    localStorage.removeItem('career_assistant_history')
  }

  return (
    <>
      <AnimatePresence>
        {!isOpen && (
          <motion.button 
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            exit={{ scale: 0 }}
            onClick={() => setIsOpen(true)}
            className="fixed bottom-6 right-6 w-14 h-14 bg-brand-600 hover:bg-brand-700 text-white rounded-full shadow-2xl flex items-center justify-center transition-colors z-40 group"
          >
            <MessageSquare size={24} className="group-hover:scale-110 transition-transform" />
            <span className="absolute -top-2 -right-2 w-4 h-4 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
          </motion.button>
        )}
      </AnimatePresence>

      <AnimatePresence>
        {isOpen && (
          <motion.div 
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 20, scale: 0.95 }}
            transition={{ duration: 0.2 }}
            className="fixed bottom-6 right-6 w-[380px] h-[600px] max-h-[85vh] bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 rounded-2xl shadow-2xl flex flex-col overflow-hidden z-50"
          >
            {/* Header */}
            <div className="bg-brand-600 text-white p-4 flex items-center justify-between shadow-md z-10 shrink-0">
              <div className="flex items-center gap-3">
                <div className="w-8 h-8 bg-white/20 rounded-full flex items-center justify-center">
                   <Bot size={20} />
                </div>
                <div>
                  <h3 className="font-bold text-sm leading-tight">Career Assistant</h3>
                  <p className="text-[10px] text-white/80">AI Coach online</p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <button onClick={clearHistory} className="text-white/60 hover:text-white transition text-xs mr-2">Clear</button>
                <button onClick={() => setIsOpen(false)} className="text-white/80 hover:text-white transition p-1 bg-white/10 hover:bg-white/20 rounded-lg">
                  <X size={18} />
                </button>
              </div>
            </div>

            {/* Messages */}
            <div className="flex-1 overflow-y-auto p-4 space-y-5 bg-slate-50 dark:bg-slate-900/50 relative">
              {messages.map((msg, i) => (
                <div key={i} className={`flex gap-3 max-w-[90%] ${msg.role === 'user' ? 'ml-auto flex-row-reverse' : ''}`}>
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center shrink-0 mt-1 ${msg.role === 'user' ? 'bg-slate-200 dark:bg-slate-800 text-slate-600 dark:text-slate-300' : 'bg-brand-100 text-brand-600 dark:bg-brand-900/40'}`}>
                    {msg.role === 'user' ? <User size={14} /> : <Bot size={14} />}
                  </div>
                  <div className={`px-4 py-3 rounded-2xl text-sm shadow-sm ${
                    msg.role === 'user' 
                      ? 'bg-brand-600 text-white rounded-tr-sm' 
                      : 'bg-white dark:bg-slate-800 border border-slate-200 dark:border-white/10 text-slate-800 dark:text-slate-200 rounded-tl-sm'
                  }`}>
                    {msg.role === 'user' ? (
                      msg.content
                    ) : (
                      <div className="prose prose-sm dark:prose-invert prose-p:leading-snug prose-p:my-1 prose-ul:my-1 prose-li:my-0.5 max-w-none break-words">
                        <ReactMarkdown remarkPlugins={[remarkGfm]}>{msg.content}</ReactMarkdown>
                      </div>
                    )}
                  </div>
                </div>
              ))}
              
              {messages.length === 1 && !isTyping && (
                <div className="flex flex-col gap-2 mt-4 max-w-[85%] ml-11">
                   {SUGGESTIONS.map((sug, i) => (
                     <button key={i} onClick={() => handleSend(sug)} className="text-left text-xs bg-white dark:bg-slate-800 border border-brand-200 dark:border-brand-900/50 text-brand-700 dark:text-brand-300 px-3 py-2 rounded-xl hover:bg-brand-50 dark:hover:bg-brand-900/30 transition-colors shadow-sm flex items-center justify-between group">
                        {sug}
                        <Sparkles size={12} className="opacity-0 group-hover:opacity-100 transition-opacity" />
                     </button>
                   ))}
                </div>
              )}

              {isTyping && (
                <div className="flex gap-3">
                   <div className="w-8 h-8 rounded-full bg-brand-100 text-brand-600 flex items-center justify-center shrink-0 mt-1"><Bot size={14} /></div>
                   <div className="px-4 py-3 rounded-2xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-white/10 shadow-sm flex gap-1.5 items-center h-[38px]">
                      <span className="w-1.5 h-1.5 bg-slate-400 rounded-full animate-bounce"></span>
                      <span className="w-1.5 h-1.5 bg-slate-400 rounded-full animate-bounce" style={{animationDelay: '150ms'}}></span>
                      <span className="w-1.5 h-1.5 bg-slate-400 rounded-full animate-bounce" style={{animationDelay: '300ms'}}></span>
                   </div>
                </div>
              )}
              <div ref={messagesEndRef} className="h-1" />
            </div>

            {/* Input */}
            <div className="p-3 bg-white dark:bg-[#13151a] border-t border-slate-100 dark:border-white/10 shrink-0">
              <form onSubmit={e => { e.preventDefault(); handleSend(input) }} className="flex gap-2">
                <input 
                  type="text" 
                  value={input}
                  onChange={e => setInput(e.target.value)}
                  placeholder="Ask for resume feedback..." 
                  className="flex-1 bg-slate-100 dark:bg-slate-800 border border-transparent dark:border-white/5 focus:border-brand-500 rounded-xl px-4 py-2.5 text-sm outline-none transition-colors"
                />
                <button type="submit" disabled={!input.trim() || isTyping} className="w-11 h-11 bg-brand-600 text-white rounded-xl flex items-center justify-center hover:bg-brand-700 transition-colors disabled:opacity-50 shrink-0">
                  <Send size={18} className="ml-0.5" />
                </button>
              </form>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  )
}
