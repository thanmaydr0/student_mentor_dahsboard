import React, { useState } from 'react'
import { X, Download, Loader2, Sparkles, GraduationCap, Send, MessageSquare, Smartphone } from 'lucide-react'
import Button from '../ui/Button'
import { cn } from '../../lib/utils'
import { supabase } from '../../lib/supabase'
import toast from 'react-hot-toast'

interface EnhancedReportModalProps {
  isOpen: boolean
  onClose: () => void
  student: any // the VtuResultSummary + usn
  aiSummary: string | null
  isLoadingSummary: boolean
  sgpa: string | number
}

export function EnhancedReportModal({
  isOpen,
  onClose,
  student,
  aiSummary,
  isLoadingSummary,
  sgpa
}: EnhancedReportModalProps) {
  if (!isOpen) return null

  const isPassing = student?.summary?.result?.toUpperCase() === 'PASS'
  const isOverall = student?.summary?.semester === 'All Semesters'
  
  const [isSendingEmail, setIsSendingEmail] = useState(false)
  const [isSendingTelegram, setIsSendingTelegram] = useState(false)
  const [isSendingSms, setIsSendingSms] = useState<'sms' | 'whatsapp' | null>(null)

  const handleSendMessage = async (type: 'sms' | 'whatsapp') => {
    try {
      setIsSendingSms(type)
      const { data, error } = await supabase.functions.invoke('send-parent-sms', {
        body: {
          type,
          studentName: student?.summary?.name,
          usn: student?.usn,
          sgpa: sgpa,
          result: student?.summary?.result,
          aiSummary: aiSummary
        }
      })

      if (error) throw error
      if (!data.ok) throw new Error(data.error || 'Failed to send message')
      
      toast.success(`${type === 'whatsapp' ? 'WhatsApp' : 'SMS'} successfully sent to parents!`)
    } catch (err: any) {
      toast.error(err.message || 'Could not send message')
    } finally {
      setIsSendingSms(null)
    }
  }

  const handleSendTelegram = async () => {
    try {
      setIsSendingTelegram(true)
      const messageBody = `📢 <b>Academic AI Report for ${student?.summary?.name}</b>\nUSN: ${student?.usn}\nSemester: ${student?.summary?.semester}\nResult: ${student?.summary?.result}\n\n<b>AI Summary:</b>\n${aiSummary}`
      
      const { data, error } = await supabase.functions.invoke('telegram-bot', {
        body: {
          action: 'send_message',
          to_student_id: student?.usn,
          message_body: messageBody
        }
      })

      if (error) throw error
      if (!data.ok || !data.sent) throw new Error(data.error || 'Failed to send Telegram message. No parent linked.')
      
      toast.success('Telegram successfully sent to connected parents!')
    } catch (err: any) {
      toast.error(err.message || 'Could not send Telegram message')
    } finally {
      setIsSendingTelegram(false)
    }
  }

  const handleSendEmail = async () => {
    try {
      setIsSendingEmail(true)
      const { data, error } = await supabase.functions.invoke('send-parent-report', {
        body: {
          studentName: student?.summary?.name,
          usn: student?.usn,
          semester: student?.summary?.semester,
          sgpa: sgpa,
          result: student?.summary?.result,
          subjects: student?.summary?.subjects,
          aiSummary: aiSummary
        }
      })

      if (error) throw error
      if (!data.ok) throw new Error(data.error || 'Failed to send email')
      
      toast.success('Email successfully sent to parents!')
    } catch (err: any) {
      toast.error(err.message || 'Could not send email')
    } finally {
      setIsSendingEmail(false)
    }
  }

  const handlePrint = () => {
    const reportContent = document.getElementById('enhanced-printable-report')
    if (!reportContent) return

    const iframe = document.createElement('iframe')
    iframe.style.position = 'fixed'
    iframe.style.right = '0'
    iframe.style.bottom = '0'
    iframe.style.width = '0'
    iframe.style.height = '0'
    iframe.style.border = '0'
    document.body.appendChild(iframe)

    const iframeDoc = iframe.contentWindow?.document
    if (!iframeDoc) return

    // Copy Tailwind styles from the main document head
    const styles = Array.from(document.querySelectorAll('style, link[rel="stylesheet"]'))
      .map(node => node.outerHTML)
      .join('\n')

    iframeDoc.open()
    iframeDoc.write(`
      <!DOCTYPE html>
      <html>
        <head>
          ${styles}
          <style>
            @page { size: A4; margin: 15mm; }
            body { background: white !important; margin: 0; padding: 0; }
            /* Force background graphics to print */
            * { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
          </style>
        </head>
        <body class="bg-white">
          ${reportContent.outerHTML}
        </body>
      </html>
    `)
    iframeDoc.close()

    setTimeout(() => {
      iframe.contentWindow?.focus()
      iframe.contentWindow?.print()
      setTimeout(() => document.body.removeChild(iframe), 1000)
    }, 500)
  }

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/60 p-4 backdrop-blur-sm">
      
      {/* Modal Container */}
      <div className="relative flex max-h-[90vh] w-full max-w-4xl flex-col overflow-hidden rounded-2xl bg-slate-100 shadow-2xl">

        
        {/* Header - Screen Only */}
        <div className="flex items-center justify-between border-b border-slate-200 bg-white px-6 py-4 print-hide">
          <div className="flex items-center gap-2 text-indigo-900">
            <Sparkles className="h-5 w-5 text-indigo-500" />
            <h2 className="text-lg font-bold">{isOverall ? 'Overall Academic AI Report' : 'Enhanced AI Academic Report'}</h2>
          </div>
          <div className="flex items-center gap-2">
            <Button 
              onClick={handleSendTelegram} 
              disabled={isLoadingSummary || isSendingTelegram || !aiSummary}
              className="bg-sky-500 hover:bg-sky-600 text-white px-3"
              title="Send via Telegram"
            >
              {isSendingTelegram ? <Loader2 size={16} className="animate-spin" /> : <Send size={16} />}
            </Button>
            <Button 
              onClick={() => handleSendMessage('whatsapp')} 
              disabled={isLoadingSummary || isSendingSms !== null || !aiSummary}
              className="bg-green-600 hover:bg-green-700 text-white px-3"
              title="Send via WhatsApp"
            >
              {isSendingSms === 'whatsapp' ? <Loader2 size={16} className="animate-spin" /> : <MessageSquare size={16} />}
            </Button>
            <Button 
              onClick={() => handleSendMessage('sms')} 
              disabled={isLoadingSummary || isSendingSms !== null || !aiSummary}
              className="bg-slate-600 hover:bg-slate-700 text-white px-3"
              title="Send via SMS"
            >
              {isSendingSms === 'sms' ? <Loader2 size={16} className="animate-spin" /> : <Smartphone size={16} />}
            </Button>
            <Button 
              onClick={handleSendEmail} 
              disabled={isLoadingSummary || isSendingEmail || !aiSummary}
              className="bg-indigo-600 hover:bg-indigo-700 text-white px-3"
              title="Send via Email"
            >
              {isSendingEmail ? <Loader2 size={16} className="animate-spin" /> : <Send size={16} />}
            </Button>
            <Button 
              onClick={handlePrint} 
              disabled={isLoadingSummary}
              className="bg-slate-800 hover:bg-slate-900 text-white px-3"
              title="Download PDF"
            >
              <Download size={16} />
            </Button>
            <div className="w-px h-6 bg-slate-200 mx-1"></div>
            <button onClick={onClose} className="rounded-full p-2 hover:bg-slate-100 text-slate-500 transition-colors">
              <X size={20} />
            </button>
          </div>
        </div>

        {/* Scrollable Content Area */}
        <div className="overflow-y-auto p-6 print:overflow-visible print:p-0">
          
          {/* THE PRINTABLE REPORT PAGE */}
          <div 
            id="enhanced-printable-report" 
            className="mx-auto bg-white shadow-sm ring-1 ring-slate-200 sm:rounded-xl p-8 print:ring-0 print:shadow-none"
          >
            
            {/* Report Header */}
            <div className="flex items-start justify-between border-b-2 border-indigo-100 pb-6 mb-6">
              <div>
                <h1 className="text-2xl font-extrabold text-slate-900 tracking-tight">Academic Performance Report</h1>
                <p className="mt-1 text-sm font-medium text-slate-500 uppercase tracking-widest">Confidential Student Analysis</p>
              </div>
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-indigo-50 text-indigo-600">
                <GraduationCap size={28} />
              </div>
            </div>

            {/* Student Meta Details */}
            <div className="grid grid-cols-2 gap-4 md:grid-cols-4 mb-8">
              <div className="rounded-xl bg-slate-50 p-4">
                <p className="text-xs font-semibold uppercase tracking-wider text-slate-500">Student Name</p>
                <p className="mt-1 text-sm font-bold text-slate-900 truncate">{student?.summary?.name || '—'}</p>
              </div>
              <div className="rounded-xl bg-slate-50 p-4">
                <p className="text-xs font-semibold uppercase tracking-wider text-slate-500">USN</p>
                <p className="mt-1 font-mono text-sm font-bold text-slate-900">{student?.usn || '—'}</p>
              </div>
              <div className="rounded-xl bg-slate-50 p-4">
                <p className="text-xs font-semibold uppercase tracking-wider text-slate-500">Semester</p>
                <p className="mt-1 text-sm font-bold text-slate-900">{student?.summary?.semester || '—'}</p>
              </div>
              <div className={cn(
                "rounded-xl p-4 border",
                isPassing ? "bg-emerald-50 border-emerald-100" : "bg-red-50 border-red-100"
              )}>
                <p className={cn(
                  "text-xs font-semibold uppercase tracking-wider",
                  isPassing ? "text-emerald-600" : "text-red-600"
                )}>Status & SGPA</p>
                <div className="mt-1 flex items-baseline gap-2">
                  <span className={cn(
                    "text-lg font-black",
                    isPassing ? "text-emerald-700" : "text-red-700"
                  )}>
                    {isPassing ? 'PASS' : 'FAIL'}
                  </span>
                  {sgpa && <span className="text-sm font-bold text-slate-700">• SGPA: {sgpa}</span>}
                </div>
              </div>
            </div>

            {/* AI Summary Section */}
            <div className="mb-8 overflow-hidden rounded-2xl border border-indigo-100 bg-gradient-to-br from-indigo-50/50 to-white relative">
              <div className="absolute top-0 left-0 w-1.5 h-full bg-indigo-500 rounded-l-2xl"></div>
              <div className="p-6">
                <div className="flex items-center gap-2 mb-3">
                  <Sparkles className="h-5 w-5 text-indigo-600" />
                  <h3 className="text-lg font-bold text-indigo-950">AI Academic Analysis</h3>
                </div>
                
                {isLoadingSummary ? (
                  <div className="flex flex-col items-center justify-center py-8 text-slate-500">
                    <Loader2 className="h-8 w-8 animate-spin mb-3 text-indigo-400" />
                    <p className="text-sm font-medium">Analyzing marks and generating insights...</p>
                  </div>
                ) : aiSummary ? (
                  <div className="prose prose-sm prose-slate max-w-none text-slate-700 leading-relaxed whitespace-pre-wrap">
                    {aiSummary}
                  </div>
                ) : (
                  <p className="text-sm italic text-slate-500">Analysis unavailable.</p>
                )}
              </div>
            </div>

            {/* Subject Breakdown */}
            <div>
              <h3 className="text-lg font-bold text-slate-900 mb-4">Subject Breakdown</h3>
              <div className="overflow-hidden rounded-xl border border-slate-200">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="bg-slate-50 border-b border-slate-200">
                      <th className="px-4 py-3 text-left font-semibold text-slate-600">Subject</th>
                      <th className="px-4 py-3 text-center font-semibold text-slate-600 w-24">Internal</th>
                      <th className="px-4 py-3 text-center font-semibold text-slate-600 w-24">External</th>
                      <th className="px-4 py-3 text-left font-semibold text-slate-600 w-48">Total & Grade</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {(student?.summary?.subjects || []).map((subj: any, idx: number) => {
                      const total = subj.total || 0;
                      const percentage = Math.min(100, Math.max(0, total)); // Assuming out of 100
                      
                      return (
                        <tr key={idx} className={!subj.passed ? "bg-red-50/30" : "bg-white"}>
                          <td className="px-4 py-4">
                            <p className="font-bold text-slate-800">{subj.name}</p>
                            <p className="text-xs font-mono text-slate-500 mt-0.5">{subj.code}</p>
                          </td>
                          <td className="px-4 py-4 text-center font-medium text-slate-700">{subj.internal ?? '-'}</td>
                          <td className="px-4 py-4 text-center font-medium text-slate-700">{subj.external ?? '-'}</td>
                          <td className="px-4 py-4">
                            <div className="flex items-center justify-between mb-1">
                              <span className="font-bold text-slate-900">{total}</span>
                              {subj.passed ? (
                                <span className="text-[10px] font-bold text-emerald-700 bg-emerald-100 px-1.5 py-0.5 rounded">PASS</span>
                              ) : (
                                <span className="text-[10px] font-bold text-red-700 bg-red-100 px-1.5 py-0.5 rounded">FAIL</span>
                              )}
                            </div>
                            <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                              <div 
                                className={cn(
                                  "h-full rounded-full",
                                  !subj.passed ? "bg-red-500" : percentage >= 80 ? "bg-emerald-500" : percentage >= 60 ? "bg-indigo-500" : "bg-amber-500"
                                )}
                                style={{ width: `${percentage}%` }}
                              />
                            </div>
                          </td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Footer */}
            <div className="mt-12 pt-6 border-t border-slate-100 text-center">
              <p className="text-xs text-slate-400 font-medium">Generated by EduPredict Platform</p>
              <p className="text-[10px] text-slate-400 mt-1">{new Date().toLocaleDateString('en-IN', { day: 'numeric', month: 'long', year: 'numeric' })}</p>
            </div>

          </div>
        </div>
      </div>
    </div>
  )
}
