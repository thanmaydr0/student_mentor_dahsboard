import { useEffect, useMemo, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion } from 'framer-motion'
import { 
  ArrowLeft,
  Bot,
  Download,
  FileText,
  Printer,
  Search,
  Sparkles,
  Users,
} from 'lucide-react'
import toast from 'react-hot-toast'
import AppShell from '../../components/layout/AppShell'
import Button from '../../components/ui/Button'
import Card from '../../components/ui/Card'
import Input from '../../components/ui/Input'
import { Skeleton } from '../../components/ui/Skeleton'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import { useMentorStudents, type MentorStudentRow } from '../../hooks/mentor/useMentorStudents'
import { cn } from '../../lib/utils'
import { EnhancedReportModal } from '../../components/mentor/EnhancedReportModal'

interface SubjectResult {
  code: string
  name: string
  internal: number | null
  external: number | null
  total: number | null
  result: string  // P, F, A, W, X, NE
  passed: boolean
}

interface VtuResultSummary {
  usn?: string
  name?: string
  branch?: string
  semester?: string
  result?: string
  sgpa?: string
  cgpa?: string
  subjects?: SubjectResult[]
  totalSubjects?: number
  passedSubjects?: number
  failedSubjects?: number
  [key: string]: any
}

interface VtuResultItem {
  usn: string
  fetchedAt: string
  html: string
  summary: VtuResultSummary
}

const VTU_FUNCTION_NAME = 'vtu-result'

function stripTags(value: string) {
  return value
    .replace(/<br\s*\/?\s*>/gi, ' ')
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/\s+/g, ' ')
    .trim()
}

function normalizeText(value: string) {
  return stripTags(value).replace(/\s+/g, ' ').trim()
}

function extractSummaryFromHtml(html: string): VtuResultSummary {
  const summary: VtuResultSummary = {}
  const rows = [...html.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)]

  for (const row of rows) {
    const cells = [...row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)]
      .map((match) => normalizeText(match[1]))
      .filter(Boolean)

    if (cells.length < 2) continue

    const label = cells[0].toLowerCase()
    const value = cells.slice(1).join(' ').trim()

    if (!summary.usn && /\busn\b/.test(label)) summary.usn = value
    if (!summary.name && /(student\s*)?name|candidate/.test(label)) summary.name = value
    if (!summary.branch && /branch|programme|program/.test(label)) summary.branch = value
    if (!summary.semester && /(semester|sem\b)/.test(label)) summary.semester = value
    if (!summary.result && /(result|status)/.test(label)) summary.result = value
    if (!summary.sgpa && /sgpa/.test(label)) summary.sgpa = value
    if (!summary.cgpa && /cgpa/.test(label)) summary.cgpa = value
  }

  if (!summary.result) {
    const flat = normalizeText(html)
    const match = flat.match(/Result\s*[:\-]\s*([A-Za-z0-9 +/().-]{2,80})/i)
    if (match) summary.result = match[1]
  }

  return summary
}

function looksLikeCaptchaError(html: string) {
  const text = html.toLowerCase()
  return (
    text.includes('captcha') && (
      text.includes('invalid') ||
      text.includes('wrong') ||
      text.includes('enter the captcha') ||
      text.includes('please enter captcha')
    )
  )
}

function ResultPreview({ item, onPrint }: { item: VtuResultItem; onPrint: () => void }) {
  const frameRef = useRef<HTMLIFrameElement>(null)
  const [isSavingSgpa, setIsSavingSgpa] = useState(false)
  const isPassing = item.summary.result?.toUpperCase() === 'PASS'
  const isFailing = item.summary.result?.toUpperCase() === 'FAIL'
  const subjects = item.summary.subjects || []
  
  const [isEnhancedModalOpen, setIsEnhancedModalOpen] = useState(false)
  const [aiSummary, setAiSummary] = useState<string | null>(null)
  const [isLoadingSummary, setIsLoadingSummary] = useState(false)
  const [sgpa, setSgpa] = useState<string | null>(null)

  const handleOpenEnhancedReport = async () => {
    setIsEnhancedModalOpen(true)
    if (aiSummary) return // already fetched

    try {
      setIsLoadingSummary(true)
      const { data, error } = await supabase.functions.invoke('generate-ai-summary', {
        body: {
          studentName: item.summary.name,
          usn: item.usn,
          semester: item.summary.semester,
          subjects: item.summary.subjects,
          result: item.summary.result,
        }
      })
      if (error) throw error
      if (!data.ok) throw new Error(data.error || 'Failed to generate summary')
      
      setAiSummary(data.summary)
      if (data.sgpa) setSgpa(data.sgpa)
    } catch (err: any) {
      toast.error('Could not generate AI summary: ' + err.message)
    } finally {
      setIsLoadingSummary(false)
    }
  }

  useEffect(() => {
    // Keep the current iframe in sync for printing.
    if (frameRef.current && frameRef.current.srcdoc !== item.html) {
      frameRef.current.srcdoc = item.html
    }
  }, [item.html])

  const handleSaveSgpa = async () => {
    try {
      setIsSavingSgpa(true)
      const { data, error } = await supabase.functions.invoke('calculate-sgpa', {
        body: { 
          usn: item.usn, 
          studentName: item.summary.name, // Added studentName to look up in profiles table
          semester: item.summary.semester,
          subjects: item.summary.subjects 
        }
      })

      if (error) throw error
      if (!data.ok) throw new Error(data.message || 'Failed to calculate SGPA')
      
      toast.success(`Saved SGPA: ${data.sgpa}`)
    } catch (error: any) {
      toast.error(error.message || 'Failed to calculate SGPA')
    } finally {
      setIsSavingSgpa(false)
    }
  }

  return (
    <Card
      title={`Result preview: ${item.usn}`}
      action={
        <div className="flex items-center gap-2">
          <Button variant="secondary" size="sm" onClick={handleOpenEnhancedReport} className="text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 border-indigo-200">
            <Sparkles size={16} className="mr-2" /> Enhanced Report (AI)
          </Button>
          <Button variant="secondary" size="sm" onClick={handleSaveSgpa} disabled={isSavingSgpa}>
            {isSavingSgpa ? 'Saving...' : 'Calculate & Save SGPA'}
          </Button>
          <Button variant="secondary" size="sm" onClick={onPrint}>
            <Printer size={16} className="mr-2" /> Save as PDF
          </Button>
        </div>
      }
    >
      <EnhancedReportModal
        isOpen={isEnhancedModalOpen}
        onClose={() => setIsEnhancedModalOpen(false)}
        student={item}
        aiSummary={aiSummary}
        isLoadingSummary={isLoadingSummary}
        sgpa={sgpa || 'N/A'}
      />
      <div className="space-y-4">
        {/* Summary cards */}
        <div className="grid gap-3 md:grid-cols-4">
          <div className="rounded-xl border border-slate-200 bg-slate-50 p-3">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">USN</p>
            <p className="mt-1 text-sm font-semibold text-slate-900">{item.summary.usn || item.usn}</p>
          </div>
          <div className="rounded-xl border border-slate-200 bg-slate-50 p-3">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Name</p>
            <p className="mt-1 text-sm font-semibold text-slate-900">{item.summary.name || '—'}</p>
          </div>
          <div className={cn(
            'rounded-xl border p-3',
            isPassing ? 'border-emerald-200 bg-emerald-50' : isFailing ? 'border-red-200 bg-red-50' : 'border-slate-200 bg-slate-50'
          )}>
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Result</p>
            <p className={cn(
              'mt-1 text-sm font-bold',
              isPassing ? 'text-emerald-700' : isFailing ? 'text-red-700' : 'text-slate-900'
            )}>
              {isPassing && '✅ '}{isFailing && '❌ '}{item.summary.result || '—'}
            </p>
          </div>
          <div className="rounded-xl border border-slate-200 bg-slate-50 p-3">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Semester</p>
            <p className="mt-1 text-sm font-bold text-indigo-700">
              {item.summary.semester || '—'}
            </p>
          </div>
        </div>

        {/* Subjects summary */}
        {item.summary.totalSubjects != null && (
          <div className="flex gap-4 rounded-xl border border-slate-200 bg-slate-50 px-4 py-2 text-sm">
            <span className="text-slate-500">Total Subjects: <span className="font-semibold text-slate-800">{item.summary.totalSubjects}</span></span>
            <span className="text-slate-500">Passed: <span className="font-semibold text-emerald-700">{item.summary.passedSubjects ?? 0}</span></span>
            {(item.summary.failedSubjects ?? 0) > 0 && (
              <span className="text-slate-500">Failed: <span className="font-semibold text-red-700">{item.summary.failedSubjects}</span></span>
            )}
          </div>
        )}

        {/* Subject-wise table */}
        {subjects.length > 0 && (
          <div className="overflow-x-auto rounded-xl border border-slate-200 bg-white shadow-sm">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-slate-200 bg-slate-50">
                  <th className="px-3 py-2 text-left text-xs font-semibold uppercase tracking-wide text-slate-500">Code</th>
                  <th className="px-3 py-2 text-left text-xs font-semibold uppercase tracking-wide text-slate-500">Subject</th>
                  <th className="px-3 py-2 text-center text-xs font-semibold uppercase tracking-wide text-slate-500">Internal</th>
                  <th className="px-3 py-2 text-center text-xs font-semibold uppercase tracking-wide text-slate-500">External</th>
                  <th className="px-3 py-2 text-center text-xs font-semibold uppercase tracking-wide text-slate-500">Total</th>
                  <th className="px-3 py-2 text-center text-xs font-semibold uppercase tracking-wide text-slate-500">Result</th>
                </tr>
              </thead>
              <tbody>
                {subjects.map((subj, idx) => (
                  <tr
                    key={subj.code + idx}
                    className={cn(
                      'border-b border-slate-100 transition-colors',
                      !subj.passed ? 'bg-red-50' : idx % 2 === 0 ? 'bg-white' : 'bg-slate-50/50'
                    )}
                  >
                    <td className="px-3 py-2 font-mono text-xs font-semibold text-slate-700">{subj.code}</td>
                    <td className="max-w-[300px] truncate px-3 py-2 text-slate-800" title={subj.name}>{subj.name}</td>
                    <td className="px-3 py-2 text-center text-slate-600">{subj.internal ?? '—'}</td>
                    <td className="px-3 py-2 text-center text-slate-600">{subj.external ?? '—'}</td>
                    <td className="px-3 py-2 text-center font-semibold text-slate-800">{subj.total ?? '—'}</td>
                    <td className="px-3 py-2 text-center">
                      {subj.passed ? (
                        <span className="inline-flex items-center rounded-full bg-emerald-100 px-2.5 py-0.5 text-xs font-bold text-emerald-700">PASS</span>
                      ) : (
                        <span className="inline-flex items-center rounded-full bg-red-100 px-2.5 py-0.5 text-xs font-bold text-red-700">FAIL</span>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {/* VTU raw HTML preview */}
        <div className="overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
          <iframe
            ref={frameRef}
            title={`VTU result ${item.usn}`}
            srcDoc={item.html}
            className="h-[900px] w-full bg-white"
          />
        </div>
      </div>
    </Card>
  )
}

export default function ResultFetchPage() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const { data: mentorStudents, isLoading: studentsLoading } = useMentorStudents(user?.id)

  const [usn, setUsn] = useState('1CR24CI063')
  const [isFetching, setIsFetching] = useState(false)
  const [results, setResults] = useState<VtuResultItem[]>([])
  const [activeResultUsn, setActiveResultUsn] = useState<string | null>(null)
  const [filterQuery, setFilterQuery] = useState('')
  const [bulkBusyUsn, setBulkBusyUsn] = useState<string | null>(null)

  const selectedResult = useMemo(
    () => results.find((item) => item.usn === activeResultUsn) || results[0] || null,
    [activeResultUsn, results]
  )

  useEffect(() => {
    if (!activeResultUsn && results.length > 0) {
      setActiveResultUsn(results[0].usn)
    }
  }, [activeResultUsn, results])

  const filteredStudents = useMemo(() => {
    const list = mentorStudents || []
    if (!filterQuery.trim()) return list
    const q = filterQuery.trim().toLowerCase()
    return list.filter((student) =>
      student.full_name.toLowerCase().includes(q) ||
      student.id.toLowerCase().includes(q) ||
      student.branch.toLowerCase().includes(q)
    )
  }, [mentorStudents, filterQuery])

  const fetchVtuResult = async (targetUsn: string) => {
    const trimmedUsn = targetUsn.trim().toUpperCase()
    if (!trimmedUsn || trimmedUsn.length < 8) {
      toast.error('Enter a valid USN.')
      return null
    }

    setIsFetching(true)
    try {
      const { data, error } = await supabase.functions.invoke(VTU_FUNCTION_NAME, {
        body: {
          usn: trimmedUsn,
        },
      })

      if (error) throw error
      if (!data?.ok) {
        throw new Error(data?.message || 'VTU result fetch failed.')
      }

      const item: VtuResultItem = {
        usn: trimmedUsn,
        fetchedAt: new Date().toISOString(),
        html: data.html,
        summary: data.summary || extractSummaryFromHtml(data.html),
      }

      setResults((prev) => {
        const withoutTarget = prev.filter((result) => result.usn !== trimmedUsn)
        return [item, ...withoutTarget]
      })
      setActiveResultUsn(trimmedUsn)
      toast.success(`Fetched result for ${trimmedUsn}`)
      return item
    } catch (err: any) {
      toast.error(err?.message || 'Could not fetch VTU result.')
      return null
    } finally {
      setIsFetching(false)
    }
  }

  const handleManualFetch = async () => {
    await fetchVtuResult(usn)
  }

  const handleFillStudent = (student: MentorStudentRow) => {
    setUsn(student.id.toUpperCase())
    toast.success(`Loaded ${student.full_name}`)
  }

  const handleFetchForStudent = async (student: MentorStudentRow) => {
    setBulkBusyUsn(student.id)
    setUsn(student.id.toUpperCase())
    const item = await fetchVtuResult(student.id)
    setBulkBusyUsn(null)
    return item
  }

  const handlePrintSelected = () => {
    const frame = document.querySelector<HTMLIFrameElement>('iframe[title^="VTU result "]')
    if (!frame?.contentWindow) {
      toast.error('No result preview available to print.')
      return
    }
    frame.contentWindow.focus()
    frame.contentWindow.print()
  }

  return (
    <AppShell role="mentor">
      <div className="mx-auto flex w-full max-w-7xl flex-col gap-8 pb-10">
        <motion.div
          initial={{ opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col gap-4"
        >
          <div className="flex flex-col gap-3 border-b border-slate-200 pb-4 sm:flex-row sm:items-end sm:justify-between">
            <div>
              <div className="mb-3 flex items-center gap-3">
                <button
                  onClick={() => navigate('/mentor/dashboard')}
                  className="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-50"
                >
                  <ArrowLeft size={16} /> Back to dashboard
                </button>
                <span className="inline-flex items-center gap-2 rounded-full border border-violet-200 bg-violet-50 px-3 py-1 text-xs font-semibold text-violet-700">
                  <Bot size={14} /> AI auto-captcha
                </span>
              </div>
              <h1 className="text-2xl font-bold text-slate-900 sm:text-3xl">VTU Result Fetch</h1>
              <p className="mt-1 max-w-2xl text-sm text-slate-500">
                Enter a USN and click Fetch — the captcha is solved automatically by AI.
                Use the mentor student list below to move through your cohort quickly.
              </p>
            </div>

            <div className="grid grid-cols-3 gap-3 rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Stored results</p>
                <p className="mt-1 text-2xl font-bold text-slate-900">{results.length}</p>
              </div>
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Mentor students</p>
                <p className="mt-1 text-2xl font-bold text-slate-900">{mentorStudents?.length ?? 0}</p>
              </div>
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Fetch mode</p>
                <p className="mt-1 text-sm font-semibold text-slate-900">One USN at a time</p>
              </div>
            </div>
          </div>
        </motion.div>

        <div className="grid gap-6 lg:grid-cols-3">
          <div className="lg:col-span-1 space-y-6">
            <Card
              title="Fetch result"
              action={<Sparkles size={16} className="text-brand-600" />}
            >
              <div className="space-y-4">
                <Input
                  label="USN"
                  value={usn}
                  onChange={(e) => setUsn(e.target.value.toUpperCase())}
                  placeholder="1CR24CI063"
                  icon={Search}
                />
                <Button loading={isFetching} onClick={handleManualFetch} fullWidth>
                  <FileText size={16} className="mr-2" /> {isFetching ? 'Solving captcha & fetching...' : 'Fetch result'}
                </Button>
                <div className="flex items-start gap-2 rounded-xl border border-violet-100 bg-violet-50 p-3">
                  <Bot size={16} className="mt-0.5 shrink-0 text-violet-600" />
                  <p className="text-xs text-violet-700">
                    The VTU captcha is solved automatically using AI vision. The server fetches the captcha image and reads it in the same session, so it stays valid. Up to 3 retries if rejected.
                  </p>
                </div>
              </div>
            </Card>

            <Card
              title="Mentor student queue"
              action={<Users size={16} className="text-brand-600" />}
            >
              <div className="space-y-4">
                <Input
                  label="Search students"
                  value={filterQuery}
                  onChange={(e) => setFilterQuery(e.target.value)}
                  placeholder="Filter by name, USN, or branch"
                  icon={Search}
                />
                <div className="max-h-[28rem] space-y-3 overflow-y-auto pr-1">
                  {studentsLoading ? (
                    Array.from({ length: 4 }).map((_, idx) => (
                      <Skeleton key={idx} className="h-20 w-full rounded-2xl" />
                    ))
                  ) : filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => {
                      const isBusy = bulkBusyUsn === student.id
                      return (
                        <div
                          key={student.id}
                          className="rounded-2xl border border-slate-200 bg-slate-50 p-4"
                        >
                          <div className="flex items-start justify-between gap-3">
                            <div>
                              <p className="font-semibold text-slate-900">{student.full_name}</p>
                              <p className="text-xs text-slate-500">
                                {student.id} • {student.branch} • Sem {student.semester}
                              </p>
                            </div>
                            <Button size="sm" variant="ghost" onClick={() => handleFillStudent(student)}>
                              Use
                            </Button>
                          </div>
                          <div className="mt-3 flex gap-2">
                            <Button
                              size="sm"
                              loading={isBusy}
                              onClick={() => handleFetchForStudent(student)}
                            >
                              Fetch
                            </Button>
                            <Button size="sm" variant="secondary" onClick={() => setUsn(student.id.toUpperCase())}>
                              Load USN
                            </Button>
                          </div>
                        </div>
                      )
                    })
                  ) : (
                    <div className="rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-4 text-sm text-slate-500">
                      No students match the filter.
                    </div>
                  )}
                </div>
              </div>
            </Card>
          </div>

          <div className="lg:col-span-2 space-y-6">
            <Card
              title="Fetched results"
              action={<Download size={16} className="text-brand-600" />}
            >
              {results.length === 0 ? (
                <div className="rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-6 text-sm text-slate-500">
                  No fetched results yet. Solve the captcha and fetch a USN to create a printable result card.
                </div>
              ) : (
                <div className="space-y-4">
                  <div className="flex flex-wrap gap-2">
                    {results.map((result) => (
                      <button
                        key={result.usn}
                        onClick={() => setActiveResultUsn(result.usn)}
                        className={cn(
                          'rounded-full border px-3 py-1.5 text-sm font-semibold transition',
                          selectedResult?.usn === result.usn
                            ? 'border-brand-600 bg-brand-50 text-brand-700'
                            : 'border-slate-200 bg-white text-slate-600 hover:bg-slate-50'
                        )}
                      >
                        {result.usn}
                      </button>
                    ))}
                  </div>

                  {selectedResult && (
                    <div className="rounded-2xl border border-slate-200 bg-white p-4">
                      <div className="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                        <div>
                          <p className="text-sm font-semibold text-slate-900">{selectedResult.summary.name || selectedResult.usn}</p>
                          <p className="text-xs text-slate-500">
                            Fetched {new Date(selectedResult.fetchedAt).toLocaleString()}
                          </p>
                        </div>
                        <div className="flex gap-2">
                          <Button variant="secondary" size="sm" onClick={handlePrintSelected}>
                            <Printer size={16} className="mr-2" /> Print / save PDF
                          </Button>
                        </div>
                      </div>
                      <ResultPreview item={selectedResult} onPrint={handlePrintSelected} />
                    </div>
                  )}
                </div>
              )}
            </Card>

            <Card title="Result workflow notes">
              <ul className="space-y-3 text-sm text-slate-600">
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 rounded-full bg-brand-500" /> If VTU changes the form or result layout, update the edge function parser only.</li>
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 rounded-full bg-brand-500" /> PDF download uses the browser print dialog so mentors can save the page as a PDF without extra libraries.</li>
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 rounded-full bg-brand-500" /> For the cohort queue, load a student, enter the captcha, and fetch one result at a time.</li>
              </ul>
            </Card>
          </div>
        </div>
      </div>
    </AppShell>
  )
}
