import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { 
  X, Sparkles, MessageSquare, Mail, FileText, Smartphone,
  RefreshCw, Check, Copy, CheckCircle2, ChevronDown, UserPlus, Info
} from 'lucide-react'
import toast from 'react-hot-toast'
import { cn } from '../../lib/utils'

// Services Abstraction Layer
import { profileService, attendanceService, gradesService, authService } from '../../services/api/Repositories'
import { interventionService } from '../../services/api/InterventionService'
import { aiService } from '../../services/external/OpenAIService'
import { telegramService } from '../../services/external/TelegramService'

interface Recipient {
  id: string
  name: string
}

interface MessageComposerProps {
  isOpen: boolean
  onClose: () => void
  initialRecipients: Recipient[]
}

type Goal = 'attendance_warning' | 'attendance_encouragement' | 'exam_reminder' | 'parent_notification' | 'positive_reinforcement' | 'intervention_followup'
type Channel = 'email' | 'sms' | 'letter' | 'telegram'
type Tone = 'formal' | 'warm' | 'urgent'

interface GeneratedMessage {
  student_id: string
  subject_line: string
  body: string
  personalization_notes: string
}

export default function MessageComposer({ isOpen, onClose, initialRecipients }: MessageComposerProps) {
  const [recipients, setRecipients] = useState<Recipient[]>([])
  
  const [goal, setGoal] = useState<Goal>('attendance_warning')
  const [channel, setChannel] = useState<Channel>('email')
  const [tone, setTone] = useState<Tone>('formal')
  
  const [isGenerating, setIsGenerating] = useState(false)
  const [messages, setMessages] = useState<GeneratedMessage[]>([])
  
  const [activeTabIdx, setActiveTabIdx] = useState(0)
  const [logAsIntervention, setLogAsIntervention] = useState(true)

  // Reset state on open
  useEffect(() => {
    if (isOpen) {
      setRecipients(initialRecipients)
      setMessages([])
      setGoal('attendance_warning')
      setChannel('email')
      setTone('formal')
      setActiveTabIdx(0)
    }
  }, [isOpen, initialRecipients])

  const removeRecipient = (id: string) => {
    setRecipients(prev => prev.filter(r => r.id !== id))
    setMessages(prev => prev.filter(m => m.student_id !== id))
    setActiveTabIdx(0)
  }

  const handleGenerate = async () => {
    if (recipients.length === 0) return toast.error("Please add at least one recipient.")
    setIsGenerating(true)
    
    try {
      const studentIds = recipients.map(r => r.id)
      const contextBlocks = await Promise.all(studentIds.map(async (student_id) => {
         const student = await profileService.getStudentInfo(student_id);
         const attendanceData = await attendanceService.getSummary(student_id);
         const gradesData = await gradesService.getGradesWithSubjects(student_id);
         const interventions = await interventionService.getByStudentId(student_id);

         const attendanceText = attendanceData?.map((a: any) => 
           `${a.subject_name}: ${a.percentage}% (${a.present_count}/${a.total_count})`
         ).join(' | ') || 'No attendance records'

         const gradesText = gradesData?.map((g: any) => 
           `${(g.classes as any)?.subjects?.name}: ${g.total_score}/100 (${g.grade})`
         ).join(' | ') || 'No grade specific data'

         const recentIntervention = interventions && interventions.length > 0 
             ? `[${interventions[0].type}]: ${interventions[0].notes}` : 'None logged'

         return `====== STUDENT ID: ${student_id} ======
Name: ${student?.full_name}
Academic Info: ${student?.branch}, Sem ${student?.semester}
Grades Overview: ${gradesText}
Attendance Overview: ${attendanceText}
Most Recenet Intervention Found: ${recentIntervention}`
      }))

      const globalContext = contextBlocks.join('\n\n')

      let lengthConstraint = ""
      if (channel === 'email') lengthConstraint = "Strictly 200 to 350 words per message."
      else if (channel === 'sms' || channel === 'telegram') lengthConstraint = "Strictly exactly less than 160 characters (Short, punchy)."
      else if (channel === 'letter') lengthConstraint = "Strictly 400 to 600 words formal letter length."

      const systemPrompt = `You are an expert Academic Advisor AI Assistant writing targeted, personalized communications natively on behalf of a Mentor explicitly tailored for a cohort context. 
      Constraint Checklist: 
      - Channel / Format: ${channel.toUpperCase()} (${lengthConstraint})
      - Message Goal / Context: ${goal.toUpperCase()}
      - Tone Constraint: ${tone.toUpperCase()}

      CRITICAL RULES:
      - If message goal is 'parent_notification', explicitly address the parent/guardian rather than the student.
      - Every message must explicitly and natively reference specific, concrete numbers found exactly in the provided academic context blocks.
      - Keep the exact tone constraints flawlessly.

      You MUST respond ONLY with a valid JSON array matching EXACTLY the schema below:
      [
        { 
          "student_id": "the exact UUID matched from the block", 
          "subject_line": "Catchy short subject or SMS introductory line", 
          "body": "The fully composed message content properly spaced", 
          "personalization_notes": "1 specific sentence detailing EXACTLY which dataset metric informed the tone/content here." 
        }
      ]`

      const userPrompt = `Generate the batch message requests for the following targeted students natively using their explicit parameters provided:
      ALL TARGETED STUDENT CONTEXTS:
      ${globalContext}`

      const rawContent = await aiService.generateResponse(systemPrompt, userPrompt + '\n\nEnclose your output array in a JSON object using the key "messages", like: { "messages": [ ... ] }', 0.4);
      const parsedJson = JSON.parse(rawContent)
      const data = parsedJson.messages || parsedJson

      if (!data || !Array.isArray(data)) throw new Error("Invalid output from AI Engine.")

      setMessages(data)
      setActiveTabIdx(0)
      toast.success("Messages generated successfully!")
    } catch(err) {
      console.warn("Generating message failed.", err)
      toast.error("Failed to generate messages correctly.")
    } finally {
      setIsGenerating(false)
    }
  }

  const handleRegenerateOne = async (studentId: string) => {
    const toastId = toast.loading("Regenerating targeted message...")
    try {

      const student = await profileService.getStudentInfo(studentId);
      const attendanceData = await attendanceService.getSummary(studentId);
      const gradesData = await gradesService.getGradesWithSubjects(studentId);
      
      const attendanceText = attendanceData?.map((a: any) => `${a.subject_name}: ${a.percentage}%`).join(' | ') || 'No attendance records'
      const gradesText = gradesData?.map((g: any) => `${(g.classes as any)?.subjects?.name}: ${g.total_score}/100`).join(' | ') || 'No grades data'

      const context = `====== STUDENT ID: ${studentId} ======\nName: ${student?.full_name}\nGrades Overview: ${gradesText}\nAttendance Overview: ${attendanceText}`

      const systemPrompt = `You are an Academic Advisor. Write a ${goal.replace('_', ' ')} via ${channel.toUpperCase()} with a ${tone.toUpperCase()} tone. Return JSON: { "messages": [ { "student_id": "${studentId}", "subject_line": "...", "body": "...", "personalization_notes": "..." } ] }`

      const rawContent = await aiService.generateResponse(systemPrompt, context, 0.5);
      const parsedJson = JSON.parse(rawContent)
      const data = parsedJson.messages || parsedJson

      if (data && data[0]) {
         setMessages(prev => prev.map(m => m.student_id === studentId ? data[0] : m))
         toast.success("Message regenerated!", { id: toastId })
      }
    } catch(err) {
      toast.error("Failed to regenerate.", { id: toastId })
    }
  }

  const handleMessageChange = (val: string, studentId: string) => {
    setMessages(prev => prev.map(m => m.student_id === studentId ? { ...m, body: val } : m))
  }

  const handleCopyThis = () => {
    const msg = messages.find(m => m.student_id === recipients[activeTabIdx]?.id)
    if (!msg) return
    let text = msg.body
    if (msg.subject_line && channel === 'email') text = `Subject: ${msg.subject_line}\n\n${text}`
    navigator.clipboard.writeText(text)
    toast.success("Message copied to clipboard!")
  }

  const handleCopyAll = () => {
    if (messages.length === 0) return
    const allTxt = messages.map(m => {
       const recName = recipients.find(r => r.id === m.student_id)?.name || 'Unknown'
       let txt = `--- Message for ${recName} ---\n`
       if (m.subject_line && channel === 'email') txt += `Subject: ${m.subject_line}\n\n`
       txt += `${m.body}\n`
       return txt
    }).join('\n\n')
    navigator.clipboard.writeText(allTxt)
    toast.success(`${messages.length} messages copied to clipboard!`)
  }

  const handleDone = async () => {
    // If enabled, log interventions for these exact drafted items
    if (logAsIntervention && messages.length > 0) {
       try {
         const user = await authService.getCurrentUser()
         if (user) {
           const insertPayload = messages.map(m => ({
              student_id: m.student_id, 
              mentor_id: user.id, 
              type: 'Message', 
              notes: `AI Composed [${channel}]:\n${m.body}`, 
              date: new Date().toISOString().split('T')[0]
           }))
           await interventionService.bulkCreate(insertPayload)
           toast.success("Interventions automatically logged!")
         }
       } catch (err) {
         console.error("Failed to log interventions", err)
       }
    }

    // Send Telegram messages if selected
    if (channel === 'telegram' && messages.length > 0) {
       const sendPromises = messages.map(async m => {
          try {
             await telegramService.sendMessage(
                m.student_id,
                `📢 <b>Message from Mentor:</b>\n\n${m.subject_line ? `<b>${m.subject_line}</b>\n\n` : ''}${m.body}`
             );
          } catch(e) { console.error('Failed to send telegram message to', m.student_id, e) }
       });
       await Promise.all(sendPromises);
       toast.success("Telegram messages dispatched to parents!");
    }

    onClose()
  }

  if (!isOpen) return null

  // UI Helper
  const helperText = `Will draft a ${tone} ${channel} about ${goal.replace('_', ' ')}, referencing explicit subject data precisely.`
  const activeStudentMsg = messages.find(m => m.student_id === recipients[activeTabIdx]?.id)

  return (
    <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm shadow-2xl">
      <motion.div 
        initial={{ opacity: 0, scale: 0.95, y: 10 }} animate={{ opacity: 1, scale: 1, y: 0 }} exit={{ opacity: 0, scale: 0.95, y: 10 }}
        className="bg-white rounded-2xl w-full max-w-4xl max-h-[90vh] flex flex-col overflow-hidden will-change-transform shadow-2xl border border-slate-200"
      >
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-slate-100 dark:border-white/5 bg-slate-50/50 dark:bg-white/5 shrink-0">
          <div className="flex items-center gap-3">
             <div className="w-10 h-10 rounded-xl bg-brand-600 shadow-sm flex flex-row items-center justify-center text-white">
                <Sparkles size={20} />
             </div>
             <div>
                <h2 className="text-lg font-bold text-slate-900 dark:text-white leading-tight">AI Message Composer</h2>
                <p className="text-xs font-semibold text-slate-500 dark:text-slate-400">Draft personalized, data-driven batch communications</p>
             </div>
          </div>
          <button onClick={onClose} className="p-2 text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 hover:bg-slate-100 dark:hover:bg-white/10 rounded-xl transition">
            <X size={20} />
          </button>
        </div>

        <div className="flex-1 overflow-y-auto p-6 bg-slate-50/30 dark:bg-transparent">
           
           {/* Step 1: Recipients */}
           <div className="mb-8">
             <h3 className="text-sm font-bold tracking-wider text-slate-500 dark:text-slate-400 uppercase mb-3">1. Recipients ({recipients.length})</h3>
             <div className="flex flex-wrap gap-2 items-center">
                <AnimatePresence>
                  {recipients.map(r => (
                     <motion.div key={r.id} initial={{scale: 0.8, opacity:0}} animate={{scale:1, opacity:1}} exit={{scale:0.8, opacity:0}}
                        className="flex items-center gap-1.5 px-3 py-1.5 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 shadow-sm rounded-lg text-sm font-semibold text-slate-700 dark:text-slate-200"
                     >
                        <MessageSquare size={14} className="text-slate-400" /> {r.name}
                        <button onClick={() => removeRecipient(r.id)} className="ml-1 text-slate-400 hover:text-red-500 transition focus:outline-none"><X size={14}/></button>
                     </motion.div>
                  ))}
                </AnimatePresence>
                <button className="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 dark:bg-white/10 hover:bg-slate-200 dark:hover:bg-white/20 border border-transparent rounded-lg text-sm font-bold text-slate-600 dark:text-slate-300 transition">
                  <UserPlus size={14}/> Add More
                </button>
             </div>
           </div>

           {/* Step 2: Settings */}
           <div className="mb-8">
             <h3 className="text-sm font-bold tracking-wider text-slate-500 dark:text-slate-400 uppercase mb-3">2. Message Parameters</h3>
             <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
               <div>
                  <label className="block text-xs font-bold text-slate-400 mb-1.5 uppercase tracking-wide">Goal target</label>
                  <div className="relative">
                     <select value={goal} onChange={(e) => setGoal(e.target.value as Goal)} className="w-full appearance-none rounded-xl border-slate-200 dark:border-white/10 bg-white dark:bg-[#13151a] dark:text-slate-200 py-2.5 pl-4 pr-10 text-sm font-semibold focus:border-brand-500 focus:ring-brand-500 shadow-sm cursor-pointer">
                       <option value="attendance_warning">Attendance Warning</option>
                       <option value="attendance_encouragement">Attendance Encouragement</option>
                       <option value="exam_reminder">Exam Reminder</option>
                       <option value="parent_notification">Parent Notification</option>
                       <option value="positive_reinforcement">Positive Reinforcement</option>
                       <option value="intervention_followup">Intervention Follow-up</option>
                     </select>
                     <ChevronDown size={16} className="absolute right-3 top-3 text-slate-400 pointer-events-none" />
                  </div>
               </div>
               <div>
                  <label className="block text-xs font-bold text-slate-400 mb-1.5 uppercase tracking-wide">Output Channel</label>
                  <div className="relative">
                     <select value={channel} onChange={(e) => setChannel(e.target.value as Channel)} className="w-full appearance-none rounded-xl border-slate-200 dark:border-white/10 bg-white dark:bg-[#13151a] dark:text-slate-200 py-2.5 pl-4 pr-10 text-sm font-semibold focus:border-brand-500 focus:ring-brand-500 shadow-sm cursor-pointer">
                       <option value="email">Email (~250 words)</option>
                       <option value="sms">SMS (&lt;160 chars)</option>
                       <option value="telegram">Telegram Bot</option>
                       <option value="letter">Formal Letter (~500 words)</option>
                     </select>
                     <ChevronDown size={16} className="absolute right-3 top-3 text-slate-400 pointer-events-none" />
                  </div>
               </div>
               <div>
                  <label className="block text-xs font-bold text-slate-400 mb-1.5 uppercase tracking-wide">Vocal Tone</label>
                  <div className="relative">
                     <select value={tone} onChange={(e) => setTone(e.target.value as Tone)} className="w-full appearance-none rounded-xl border-slate-200 dark:border-white/10 bg-white dark:bg-[#13151a] dark:text-slate-200 py-2.5 pl-4 pr-10 text-sm font-semibold focus:border-brand-500 focus:ring-brand-500 shadow-sm cursor-pointer">
                       <option value="formal">Formal & Academic</option>
                       <option value="warm">Warm & Empathetic</option>
                       <option value="urgent">Urgent & Direct</option>
                     </select>
                     <ChevronDown size={16} className="absolute right-3 top-3 text-slate-400 pointer-events-none" />
                  </div>
               </div>
             </div>
             
             <div className="mt-4 flex items-center justify-between bg-brand-50 dark:bg-brand-900/20 rounded-xl px-4 py-3 border border-brand-100 dark:border-brand-500/20">
               <div className="flex items-center gap-2 text-sm text-brand-700 dark:text-brand-300 font-medium">
                 <Info size={16} className="text-brand-500" />
                 {helperText}
               </div>
               <button 
                  onClick={handleGenerate}
                  disabled={isGenerating || recipients.length === 0}
                  className="flex items-center gap-2 px-5 py-2 text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed rounded-lg shadow-sm transition"
               >
                 {isGenerating ? <><RefreshCw size={16} className="animate-spin" /> Fetching Contexts...</> : <><Sparkles size={16} /> Draft Messages</>}
               </button>
             </div>
           </div>

           {/* Step 3: Review */}
           {messages.length > 0 && (
             <motion.div initial={{opacity:0, y:20}} animate={{opacity:1, y:0}} className="mb-4">
               <h3 className="text-sm font-bold tracking-wider text-slate-500 dark:text-slate-400 uppercase mb-3 flex justify-between items-end">
                 <span>3. Review & Edit ({messages.length})</span>
                 {activeStudentMsg && channel === 'sms' && activeStudentMsg.body.length > 160 && (
                    <span className="text-xs text-red-500 font-bold bg-red-50 dark:bg-red-900/20 px-2 py-0.5 rounded border border-red-200 dark:border-red-500/30">Warning: &gt; 160 characters</span>
                 )}
               </h3>
               
               <div className="bg-white dark:bg-[#13151a]/50 rounded-2xl border border-slate-200 dark:border-white/10 shadow-sm overflow-hidden flex flex-col">
                  {/* Tab Selector */}
                  {recipients.length > 1 && (
                    <div className="flex overflow-x-auto border-b border-slate-200 dark:border-white/10 bg-slate-50/50 dark:bg-white/5">
                       {recipients.reverse().map((r, i) => (
                          <button key={r.id} onClick={() => setActiveTabIdx(i)} className={cn("px-5 py-3 text-sm font-bold border-r border-slate-200 dark:border-white/10 transition whitespace-nowrap", activeTabIdx === i ? "bg-white dark:bg-[#13151a] text-brand-700 dark:text-brand-400 border-b-2 border-b-brand-500" : "text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-slate-200 hover:bg-slate-100 dark:hover:bg-white/5")}>
                             {r.name}
                          </button>
                       ))}
                    </div>
                  )}

                  {/* Editor Window */}
                  {activeStudentMsg && (
                    <div className="p-0 flex flex-col">
                       {channel === 'email' && (
                          <div className="px-5 py-3 border-b border-slate-100 dark:border-white/5 flex items-center gap-3">
                            <span className="text-xs font-bold text-slate-400 uppercase">Input Subject:</span>
                            <div className="font-semibold text-slate-800 dark:text-slate-200 text-sm flex-1">{activeStudentMsg.subject_line}</div>
                          </div>
                       )}
                       <textarea 
                          value={activeStudentMsg.body}
                          onChange={(e) => handleMessageChange(e.target.value, activeStudentMsg.student_id)}
                          className="w-full h-48 focus:outline-none p-5 text-slate-700 dark:text-slate-200 leading-relaxed resize-none bg-transparent"
                       />
                       
                       {/* Context Info Box */}
                       <div className="border-t border-slate-100 dark:border-white/5 bg-slate-50/80 dark:bg-white/5 px-5 py-3 flex flex-row items-start justify-between gap-4">
                          <div className="text-xs text-slate-500 dark:text-slate-400 leading-relaxed font-medium">
                            <span className="font-bold text-slate-700 dark:text-slate-300 tracking-wider uppercase inline-block mb-1">AI Reasoning</span><br />
                            {activeStudentMsg.personalization_notes}
                          </div>
                          <div className="shrink-0 flex items-center gap-3 mt-1">
                            <span className="text-xs font-bold text-slate-400">{activeStudentMsg.body.length} chars</span>
                            <button onClick={() => handleRegenerateOne(activeStudentMsg.student_id)} className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 shadow-sm rounded-md text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-white/5 transition">
                              <RefreshCw size={12}/> Retry
                            </button>
                          </div>
                       </div>
                    </div>
                  )}
               </div>
             </motion.div>
           )}
        </div>

        {/* Footer */}
        <div className="px-6 py-4 border-t border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-[#13151a] flex items-center justify-between shrink-0 rounded-b-2xl">
           <div className="flex items-center gap-4">
              <label className="flex items-center gap-2 cursor-pointer group">
                 <input type="checkbox" checked={logAsIntervention} onChange={(e) => setLogAsIntervention(e.target.checked)} className="rounded border-slate-300 dark:border-slate-600 dark:bg-transparent text-brand-600 focus:ring-brand-500 w-4 h-4 cursor-pointer" />
                 <span className="text-sm font-semibold text-slate-600 dark:text-slate-400 group-hover:text-slate-900 dark:group-hover:text-slate-200 transition">Log automatically as interventions</span>
              </label>
           </div>
           
           <div className="flex items-center gap-3">
              {messages.length > 0 && (
                <>
                  {recipients.length > 1 && (
                    <button onClick={handleCopyAll} className="flex px-4 py-2.5 bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 text-slate-700 dark:text-slate-300 shadow-sm rounded-xl font-bold text-sm hover:bg-slate-50 dark:hover:bg-white/5 transition items-center gap-2">
                       <Copy size={16}/> Copy All ({messages.length})
                    </button>
                  )}
                  <button onClick={handleCopyThis} className="flex px-4 py-2.5 bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 text-slate-700 dark:text-slate-300 shadow-sm rounded-xl font-bold text-sm hover:bg-slate-50 dark:hover:bg-white/5 transition items-center gap-2">
                     <Copy size={16}/> Copy Current
                  </button>
                </>
              )}
              <button 
                onClick={handleDone}
                className={cn(
                  "flex px-6 py-2.5 rounded-xl font-bold text-sm shadow-sm transition items-center gap-2",
                  messages.length > 0 ? "bg-brand-600 text-white hover:bg-brand-700" : "bg-white dark:bg-transparent border border-slate-200 dark:border-white/10 text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/5"
                )}
              >
                {messages.length > 0 ? <><CheckCircle2 size={16}/> Save & Close</> : "Close"}
              </button>
           </div>
        </div>

      </motion.div>
    </div>
  )
}
