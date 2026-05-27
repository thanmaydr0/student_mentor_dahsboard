import React, { useState } from 'react'
import { motion } from 'framer-motion'
import { Users, Send, MessageSquare, Smartphone, Mail, Sparkles, Loader2, FileText, CheckCircle2 } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import Input from '../../components/ui/Input'
import Button from '../../components/ui/Button'
import { useAuth } from '../../hooks/useAuth'
import { useMentorStudents } from '../../hooks/mentor/useMentorStudents'
import { supabase } from '../../lib/supabase'
import toast from 'react-hot-toast'
import { cn } from '../../lib/utils'

export default function CommunityPage() {
  const { user } = useAuth()
  const { data: students, isLoading: isLoadingStudents } = useMentorStudents(user?.id)

  const [selectedStudents, setSelectedStudents] = useState<Set<string>>(new Set())
  const [message, setMessage] = useState('')
  const [channels, setChannels] = useState({
    email: true,
    whatsapp: true,
    sms: false
  })
  const [includeVtuResult, setIncludeVtuResult] = useState(false)
  const [includeAiSummary, setIncludeAiSummary] = useState(false)
  const [includeAttendance, setIncludeAttendance] = useState(false)
  const [includeIatMarks, setIncludeIatMarks] = useState(false)
  const [usn, setUsn] = useState('')
  const [isSending, setIsSending] = useState(false)

  const toggleStudent = (id: string) => {
    const next = new Set(selectedStudents)
    if (next.has(id)) {
      next.delete(id)
    } else {
      next.add(id)
    }
    setSelectedStudents(next)
    if (next.size !== 1) {
      setIncludeAiSummary(false)
      setIncludeVtuResult(false)
    }
  }

  const toggleAll = () => {
    if (selectedStudents.size === students?.length) {
      setSelectedStudents(new Set())
      setIncludeAiSummary(false)
      setIncludeVtuResult(false)
      setIncludeAttendance(false)
      setIncludeIatMarks(false)
    } else {
      setSelectedStudents(new Set(students?.map(s => s.id) || []))
      setIncludeAiSummary(false)
      setIncludeVtuResult(false)
      setIncludeAttendance(false)
      setIncludeIatMarks(false)
    }
  }

  const handleBroadcast = async () => {
    if (selectedStudents.size === 0) return toast.error('Select at least one student')
    if (!message.trim() && !includeAiSummary && !includeVtuResult && !includeAttendance && !includeIatMarks) return toast.error('Enter a message or attach an item')
    if (!channels.email && !channels.whatsapp && !channels.sms) return toast.error('Select at least one channel')
    if ((includeAiSummary || includeVtuResult) && !usn.trim()) return toast.error('Please enter the student\'s USN to fetch data')

    try {
      setIsSending(true)

      let vtuPayload = null;

      if (includeAiSummary || includeVtuResult) {
        const toastMsg = includeVtuResult && includeAiSummary ? 'Fetching VTU results & generating AI summary...' : 
                         includeVtuResult ? 'Fetching VTU results...' : 'Generating AI summary...';
        toast.loading(toastMsg, { id: 'vtu-fetch' })
        
        // 1. Fetch VTU Result
        const { data: vtuData, error: vtuError } = await supabase.functions.invoke('vtu-result', {
          body: { usn, name: 'Student' }
        })
        
        if (vtuError) throw vtuError
        if (!vtuData.ok) throw new Error(vtuData.message || 'Failed to fetch VTU results')

        // 2. Calculate SGPA
        const { data: sgpaData, error: sgpaError } = await supabase.functions.invoke('calculate-sgpa', {
          body: {
            studentId: Array.from(selectedStudents)[0],
            semester: parseInt(vtuData.summary.semester.replace(/\\D/g, '')) || 0,
            subjects: vtuData.summary.subjects
          }
        })

        if (sgpaError) throw sgpaError
        if (!sgpaData.ok) throw new Error(sgpaData.error || 'Failed to calculate SGPA')

        vtuPayload = {
          usn,
          subjects: vtuData.summary.subjects,
          sgpa: sgpaData.sgpa,
          result: vtuData.summary.result,
          aiSummary: vtuData.aiSummary
        }
        
        toast.success('VTU Data fetched!', { id: 'vtu-fetch' })
      }

      toast.loading('Dispatching messages...', { id: 'broadcast' })
      const studentIds = Array.from(selectedStudents)
      
      const channelsArray = Object.entries(channels).filter(([_, v]) => v).map(([k]) => k)

      const { data, error } = await supabase.functions.invoke('broadcast-message', {
        body: {
          studentIds,
          message,
          channels: channelsArray,
          includeAiSummary,
          includeVtuResult,
          includeAttendance,
          includeIatMarks,
          vtuData: vtuPayload
        }
      })

      // If supabase-js gives us a FunctionsHttpError (non-2xx), try to extract the body
      if (error) {
        let detail = error.message
        try {
          // FunctionsHttpError has a .context property with the Response
          const ctx = (error as any).context
          if (ctx && typeof ctx.json === 'function') {
            const body = await ctx.json()
            detail = body?.error || body?.message || detail
          }
        } catch (_) { /* ignore */ }
        throw new Error(detail)
      }

      if (!data?.ok) throw new Error(data?.error || 'Failed to send broadcast')
      
      toast.success(data.message || 'Messages successfully dispatched!', { id: 'broadcast' })
      setMessage('')
      setIncludeAiSummary(false)
      setIncludeVtuResult(false)
      setIncludeAttendance(false)
      setIncludeIatMarks(false)
      setUsn('')
      setSelectedStudents(new Set())
    } catch (err: any) {
      toast.dismiss('vtu-fetch')
      console.error('[Broadcast Error]', err)
      toast.error(err.message || 'Could not send broadcast', { id: 'broadcast' })
    } finally {
      setIsSending(false)
    }
  }

  return (
    <AppShell role="mentor">
      <div className="mx-auto flex w-full max-w-7xl flex-col gap-8 pb-10">
        
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col gap-4"
        >
          <div className="flex flex-col gap-3 border-b border-slate-200 dark:border-white/10 pb-4">
            <h1 className="text-2xl font-bold text-slate-900 dark:text-white sm:text-3xl">Community & Messaging</h1>
            <p className="max-w-2xl text-sm text-slate-500 dark:text-slate-400">
              Communicate directly with parents via Email, SMS, or WhatsApp. Broadcast announcements to your entire cohort, or send personalized updates.
            </p>
          </div>
        </motion.div>

        <div className="grid gap-6 lg:grid-cols-12">
          
          {/* LEFT PANE: Recipients */}
          <div className="lg:col-span-5 flex flex-col h-[700px]">
            <Card className="flex-1 flex flex-col overflow-hidden">
              <div className="flex items-center justify-between border-b border-slate-100 dark:border-white/5 pb-4 mb-4">
                <div>
                  <h3 className="font-semibold text-slate-900 dark:text-white">Select Recipients</h3>
                  <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">{selectedStudents.size} of {students?.length || 0} selected</p>
                </div>
                <button 
                  onClick={toggleAll}
                  className="text-xs font-semibold text-indigo-600 dark:text-indigo-400 hover:text-indigo-700 dark:hover:text-indigo-300 bg-indigo-50 dark:bg-indigo-900/40 px-3 py-1.5 rounded-md transition-colors"
                >
                  {selectedStudents.size === students?.length ? 'Deselect All' : 'Select All'}
                </button>
              </div>

              <div className="flex-1 overflow-y-auto pr-2 space-y-2 custom-scrollbar">
                {isLoadingStudents ? (
                  <div className="flex justify-center py-8"><Loader2 className="animate-spin text-slate-300" /></div>
                ) : (
                  students?.map(student => (
                    <div 
                      key={student.id}
                      onClick={() => toggleStudent(student.id)}
                      className={cn(
                        "flex items-center gap-3 p-3 rounded-xl border cursor-pointer transition-all",
                        selectedStudents.has(student.id) 
                          ? "border-indigo-200 dark:border-indigo-500/30 bg-indigo-50 dark:bg-indigo-500/20" 
                          : "border-slate-100 dark:border-white/5 hover:border-slate-200 dark:hover:border-white/10 hover:bg-slate-50 dark:hover:bg-white/5"
                      )}
                    >
                      <div className={cn(
                        "flex h-5 w-5 shrink-0 items-center justify-center rounded border",
                        selectedStudents.has(student.id) ? "border-indigo-600 bg-indigo-600 text-white" : "border-slate-300 dark:border-slate-600 bg-white dark:bg-transparent"
                      )}>
                        {selectedStudents.has(student.id) && <CheckCircle2 size={14} />}
                      </div>
                      <div>
                        <p className={cn("text-sm font-medium", selectedStudents.has(student.id) ? "text-indigo-900 dark:text-indigo-300" : "text-slate-700 dark:text-slate-300")}>
                          {student.full_name}
                        </p>
                        <p className="text-xs text-slate-500 dark:text-slate-400">Sem {student.semester} • {student.branch}</p>
                      </div>
                    </div>
                  ))
                )}
              </div>
            </Card>
          </div>

          {/* RIGHT PANE: Compose */}
          <div className="lg:col-span-7 flex flex-col h-[700px]">
            <Card className="flex-1 flex flex-col">
              <div className="border-b border-slate-100 dark:border-white/5 pb-4 mb-6">
                <h3 className="font-semibold text-slate-900 dark:text-white flex items-center gap-2">
                  <MessageSquare size={18} className="text-indigo-500" />
                  Compose Message
                </h3>
              </div>

              <div className="space-y-6 flex-1 overflow-y-auto pr-2 custom-scrollbar">
                
                {/* Channels */}
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-3">Sending Channels</label>
                  <div className="flex gap-3">
                    <button
                      onClick={() => setChannels(c => ({...c, email: !c.email}))}
                      className={cn(
                        "flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg border text-sm font-medium transition-colors",
                        channels.email ? "bg-slate-900 dark:bg-white border-slate-900 dark:border-white text-white dark:text-slate-900" : "bg-white dark:bg-transparent border-slate-200 dark:border-white/10 text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/5"
                      )}
                    >
                      <Mail size={16} /> Email
                    </button>
                    <button
                      onClick={() => setChannels(c => ({...c, whatsapp: !c.whatsapp}))}
                      className={cn(
                        "flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg border text-sm font-medium transition-colors",
                        channels.whatsapp ? "bg-green-600 border-green-600 text-white" : "bg-white dark:bg-transparent border-slate-200 dark:border-white/10 text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/5"
                      )}
                    >
                      <MessageSquare size={16} /> WhatsApp
                    </button>
                    <button
                      onClick={() => setChannels(c => ({...c, sms: !c.sms}))}
                      className={cn(
                        "flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg border text-sm font-medium transition-colors",
                        channels.sms ? "bg-sky-500 border-sky-500 text-white" : "bg-white dark:bg-transparent border-slate-200 dark:border-white/10 text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/5"
                      )}
                    >
                      <Smartphone size={16} /> SMS
                    </button>
                  </div>
                </div>

                {/* Attachments */}
                <div className="rounded-xl border border-indigo-100 dark:border-indigo-500/20 bg-indigo-50/50 dark:bg-indigo-500/10 p-4 space-y-3">
                  <label className="flex items-start gap-3 cursor-pointer">
                    <input 
                      type="checkbox" 
                      className="mt-1 h-4 w-4 rounded border-indigo-300 text-indigo-600 focus:ring-indigo-600 dark:border-indigo-500/40 dark:bg-transparent"
                      checked={includeAttendance}
                      onChange={(e) => setIncludeAttendance(e.target.checked)}
                    />
                    <div>
                      <p className="text-sm font-semibold text-indigo-900 dark:text-indigo-300 flex items-center gap-1.5">
                        <CheckCircle2 size={14} className="text-indigo-500" />
                        Attach Overall Attendance
                      </p>
                      <p className="text-xs text-indigo-700/70 dark:text-indigo-300/70 mt-0.5 leading-relaxed">
                        Calculates and includes the student's current attendance percentage.
                      </p>
                    </div>
                  </label>

                  <label className="flex items-start gap-3 cursor-pointer">
                    <input 
                      type="checkbox" 
                      className="mt-1 h-4 w-4 rounded border-indigo-300 text-indigo-600 focus:ring-indigo-600 dark:border-indigo-500/40 dark:bg-transparent"
                      checked={includeIatMarks}
                      onChange={(e) => setIncludeIatMarks(e.target.checked)}
                    />
                    <div>
                      <p className="text-sm font-semibold text-indigo-900 dark:text-indigo-300 flex items-center gap-1.5">
                        <FileText size={14} className="text-indigo-500" />
                        Attach IAT Marks
                      </p>
                      <p className="text-xs text-indigo-700/70 dark:text-indigo-300/70 mt-0.5 leading-relaxed">
                        Includes the latest Internal Assessment Test (IAT) scores.
                      </p>
                    </div>
                  </label>

                  <div className="my-2 border-t border-indigo-100/60 dark:border-indigo-500/20"></div>

                  <label className="flex items-start gap-3 cursor-pointer">
                    <input 
                      type="checkbox" 
                      className="mt-1 h-4 w-4 rounded border-indigo-300 text-indigo-600 focus:ring-indigo-600 dark:border-indigo-500/40 dark:bg-transparent"
                      checked={includeVtuResult}
                      onChange={(e) => {
                        if (selectedStudents.size !== 1) {
                          toast.error('VTU Results can only be attached when exactly 1 student is selected.')
                          return
                        }
                        setIncludeVtuResult(e.target.checked)
                      }}
                    />
                    <div>
                      <p className="text-sm font-semibold text-indigo-900 dark:text-indigo-300 flex items-center gap-1.5">
                        <FileText size={14} className="text-indigo-500" />
                        Attach VTU Result Details
                      </p>
                      <p className="text-xs text-indigo-700/70 dark:text-indigo-300/70 mt-0.5 leading-relaxed">
                        Fetches the latest VTU marks and SGPA dynamically.
                      </p>
                    </div>
                  </label>

                  <label className="flex items-start gap-3 cursor-pointer">
                    <input 
                      type="checkbox" 
                      className="mt-1 h-4 w-4 rounded border-indigo-300 text-indigo-600 focus:ring-indigo-600 dark:border-indigo-500/40 dark:bg-transparent"
                      checked={includeAiSummary}
                      onChange={(e) => {
                        if (selectedStudents.size !== 1) {
                          toast.error('AI Summary can only be generated when exactly 1 student is selected.')
                          return
                        }
                        setIncludeAiSummary(e.target.checked)
                      }}
                    />
                    <div>
                      <p className="text-sm font-semibold text-indigo-900 dark:text-indigo-300 flex items-center gap-1.5">
                        <Sparkles size={14} className="text-indigo-500" />
                        Generate & Attach AI Summary
                      </p>
                      <p className="text-xs text-indigo-700/70 dark:text-indigo-300/70 mt-0.5 leading-relaxed">
                        Generates a personalized AI insight report to attach to the message.
                      </p>
                    </div>
                  </label>

                  {(includeAiSummary || includeVtuResult) && (
                    <div className="mt-4 border-t border-indigo-100/50 pt-4">
                      <p className="text-xs font-semibold text-amber-600 mb-3">Note: Only available for single-student messaging.</p>
                      <Input
                        label="Student USN"
                        placeholder="e.g. 1CR24CI063"
                        value={usn}
                        onChange={(e) => setUsn(e.target.value.toUpperCase())}
                        icon={FileText}
                      />
                    </div>
                  )}
                </div>

                {/* Message Body */}
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-2">Custom Message</label>
                  <textarea
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    placeholder="Type your message here... (e.g., Parent-Teacher Meeting tomorrow at 10 AM)"
                    className="w-full min-h-[160px] rounded-xl border border-slate-200 dark:border-white/10 bg-white dark:bg-[#13151a]/50 p-4 text-sm text-slate-900 dark:text-white placeholder:text-slate-400 dark:placeholder:text-slate-500 focus:border-indigo-500 focus:outline-none focus:ring-4 focus:ring-indigo-500/10 transition-shadow resize-y"
                  />
                </div>

              </div>

              {/* Action Footer */}
              <div className="mt-6 pt-4 border-t border-slate-100 dark:border-white/5">
                <Button 
                  fullWidth 
                  size="lg"
                  onClick={handleBroadcast}
                  loading={isSending}
                  disabled={selectedStudents.size === 0 || (!message && !includeAiSummary && !includeVtuResult && !includeAttendance && !includeIatMarks)}
                  className="bg-indigo-600 hover:bg-indigo-700 text-white shadow-lg shadow-indigo-600/20"
                >
                  <Send size={18} className="mr-2" />
                  {isSending ? 'Dispatching Messages...' : `Send to ${selectedStudents.size} Parent${selectedStudents.size !== 1 ? 's' : ''}`}
                </Button>
              </div>

            </Card>
          </div>

        </div>
      </div>
    </AppShell>
  )
}
