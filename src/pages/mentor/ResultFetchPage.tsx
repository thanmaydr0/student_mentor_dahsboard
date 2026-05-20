import { useEffect, useMemo, useRef, useState, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import {
  ArrowLeft,
  Bot,
  CheckCircle,
  ChevronDown,
  ChevronUp,
  Download,
  FileText,
  Loader2,
  Printer,
  Search,
  Sparkles,
  Users,
  XCircle,
  AlertTriangle,
  GraduationCap,
  TrendingUp,
  RefreshCw,
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

// ── Types ────────────────────────────────────────────────────────────────────

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

/** Describes one fetchable result type for a semester */
interface SemesterUrlEntry {
  semester: number
  label: string
  type: 'regular' | 'reval' | 'summer' | 'summer_reval'
  url: string
}

/** Holds the fetched results for one semester */
interface SemesterResult {
  semester: number
  label: string
  regular: VtuResultItem | null
  reval: VtuResultItem | null
  /** Merged best-of subjects (regular + reval) */
  mergedSubjects: SubjectResult[]
  sgpa: string | null
}

interface SummerResult {
  regular: VtuResultItem | null
  reval: VtuResultItem | null
  mergedSubjects: SubjectResult[]
  sgpa: string | null
}

/** Progress entry for the fetch queue */
interface FetchProgress {
  label: string
  status: 'pending' | 'fetching' | 'done' | 'error' | 'skipped'
  message?: string
}

// ── Semester URL Configuration ───────────────────────────────────────────────

const SEMESTER_URLS: SemesterUrlEntry[] = [
  { semester: 1, label: '1st Semester', type: 'regular', url: 'https://results.vtu.ac.in/DJcbcs25/' },
  { semester: 1, label: '1st Semester Reval', type: 'reval', url: 'https://results.vtu.ac.in/DJRVcbcs25/' },
  { semester: 2, label: '2nd Semester', type: 'regular', url: 'https://results.vtu.ac.in/JJEcbcs25/' },
  { semester: 2, label: '2nd Semester Reval', type: 'reval', url: 'https://results.vtu.ac.in/JJRVcbcs25/' },
  { semester: 3, label: '3rd Semester', type: 'regular', url: 'https://results.vtu.ac.in/D25J26Ecbcs/' },
  // Summer semester
  { semester: 0, label: 'Summer Semester', type: 'summer', url: 'https://results.vtu.ac.in/SEcbcs25/' },
  { semester: 0, label: 'Summer Semester Reval', type: 'summer_reval', url: 'https://results.vtu.ac.in/SERVcbcs25/' },
]

const VTU_FUNCTION_NAME = 'vtu-result'

// ── Helpers ──────────────────────────────────────────────────────────────────

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
    const match = flat.match(/Result\s*[:\-]\s*([A-Za-z0-9 +/().\-]{2,80})/i)
    if (match) summary.result = match[1]
  }

  return summary
}

/**
 * Merge regular + reval subjects: for each subject, take the better total.
 * Reval pages may only contain re-evaluated subjects, so we start with all
 * regular subjects and overlay any reval improvements.
 */
function mergeSubjects(regular: SubjectResult[], reval: SubjectResult[]): SubjectResult[] {
  if (!reval || reval.length === 0) return regular
  if (!regular || regular.length === 0) return reval

  const merged = new Map<string, SubjectResult>()
  for (const s of regular) {
    merged.set(s.code, { ...s })
  }
  for (const s of reval) {
    const existing = merged.get(s.code)
    if (!existing) {
      // Subject only in reval (rare)
      merged.set(s.code, { ...s })
    } else {
      // Take the better total
      const existingTotal = existing.total ?? 0
      const revalTotal = s.total ?? 0
      if (revalTotal > existingTotal) {
        merged.set(s.code, { ...s })
      }
    }
  }
  return Array.from(merged.values())
}

// ── VTU Credit & Grading System (2022 CBCS Scheme, CSE) ─────────────────────

/**
 * Subject code → credits mapping.
 * Covers Semester 1 & 2 CSE (Physics Group) from VTU 2022 scheme.
 * For variant codes (e.g. BESCK104B), we strip the trailing letter and match.
 */
const SUBJECT_CREDITS: Record<string, number> = {
  // ── Semester 1 (Total: 20 credits) ──
  'BMATS101': 4,
  'BPHYS102': 4,
  'BPOPS103': 3,
  // ESC-I (BESCK104 + suffix)
  'BESCK104': 3,
  // ETC-I / PLC-I (BETCK105/BPLCK105 + suffix)
  'BETCK105': 3, 'BPLCK105': 3,
  // AEC
  'BENGK106': 1, 'BPWSK106': 1,
  // HSMC
  'BKSKK107': 1, 'BKBKK107': 1, 'BICOK107': 1,
  // AEC/SDC
  'BIDTK158': 1, 'BSFHK158': 1,

  // ── Semester 2 (Total: 20 credits) ──
  'BMATS201': 4,
  'BCHES202': 4,
  'BCEDK203': 3,
  // ESC-II (BESCK204 + suffix)
  'BESCK204': 3,
  // PLC-II / ETC-II (BETCK205/BPLCK205 + suffix)
  'BETCK205': 3, 'BPLCK205': 3,
  // AEC
  'BPWSK206': 1, 'BENGK206': 1,
  // HSMS
  'BICOK207': 1, 'BKSKK207': 1, 'BKBKK207': 1,
  // HSMS
  'BSFHK258': 1, 'KIDTK258': 1,

  // ── Semester 3 (common CSE subjects — add more as needed) ──
  'BMATS301': 4, 'BCS301': 4,
  'BCS302': 4, 'BCS303': 4,
  'BCS304': 3, 'BCSL305': 1,
  'BCS306': 3, 'BCS306A': 3, 'BCS306B': 3,
  'BSCK307': 1, 'BSCK307A': 1, 'BSCK307B': 1,
  'BNSK359': 0, 'BNSK358': 0, // NSS/NCC/Yoga — 0 credit (non-credit)
  'BCS358A': 1, 'BCS358B': 1, 'BCS358C': 1,
}

/**
 * Look up credits for a VTU subject code.
 * Tries exact match first, then strips trailing letter suffix for variant codes.
 */
function getCreditsForSubject(code: string): number | null {
  const upper = code.toUpperCase().trim()

  // 1. Exact match
  if (upper in SUBJECT_CREDITS) return SUBJECT_CREDITS[upper]

  // 2. Strip trailing letter (e.g., BESCK104B → BESCK104)
  const stripped = upper.replace(/[A-Z]$/, '')
  if (stripped !== upper && stripped in SUBJECT_CREDITS) return SUBJECT_CREDITS[stripped]

  // 3. Fallback heuristic based on VTU numbering convention
  //    Last 2 digits of the number determine subject type:
  //    01-02 = 4 cr (main theory), 03-05 = 3 cr (ESC/lab), 06-07 = 1 cr (AEC/HSMC), 58-59 = 1 cr (SDC)
  const numMatch = upper.match(/(\d{3})[A-Z]?$/)
  if (numMatch) {
    const num = parseInt(numMatch[1])
    const lastTwo = num % 100
    if (lastTwo >= 1 && lastTwo <= 2) return 4
    if (lastTwo >= 3 && lastTwo <= 5) return 3
    if (lastTwo >= 6 && lastTwo <= 7) return 1
    if (lastTwo >= 50 && lastTwo <= 59) return 1
  }

  return null // Unknown — will be excluded from GPA calculation
}

/**
 * VTU 10-point grading: convert total marks (out of 100) to grade points.
 * Based on VTU 2022 CBCS scheme.
 */
function getGradePoint(total: number | null): number {
  if (total === null || total < 0) return 0
  if (total >= 90) return 10  // O  (Outstanding)
  if (total >= 80) return 9   // A+ (Excellent)
  if (total >= 70) return 8   // A  (Very Good)
  if (total >= 60) return 7   // B+ (Good)
  if (total >= 55) return 6   // B  (Above Average)
  if (total >= 50) return 5   // C  (Average)
  if (total >= 40) return 4   // P  (Pass)
  return 0                    // F  (Fail)
}

/**
 * Calculate SGPA from a list of subjects using VTU credit-weighted formula.
 * SGPA = Σ(credit_i × gradePoint_i) / Σ(credit_i)
 * Subjects with unknown credits or 0 credits (like NSS) are excluded.
 */
function calculateSgpaFromSubjects(subjects: SubjectResult[]): string | null {
  if (!subjects || subjects.length === 0) return null

  let totalCredits = 0
  let totalWeighted = 0

  for (const subj of subjects) {
    const credits = getCreditsForSubject(subj.code)
    if (credits === null || credits === 0) continue // Skip unknown or non-credit subjects

    const gp = getGradePoint(subj.total)
    totalCredits += credits
    totalWeighted += credits * gp
  }

  if (totalCredits === 0) return null
  return (totalWeighted / totalCredits).toFixed(2)
}

/**
 * Calculate CGPA using credit-weighted average across semesters.
 * CGPA = Σ(semester_credits_i × SGPA_i) / Σ(semester_credits_i)
 * Falls back to simple average if per-semester credits can't be determined.
 */
function calculateCgpa(semesterResults: SemesterResult[]): string | null {
  const entries: { sgpa: number; credits: number }[] = []

  for (const sem of semesterResults) {
    const sgpaVal = sem.sgpa ? parseFloat(sem.sgpa) : null
    if (sgpaVal === null || isNaN(sgpaVal)) continue

    // Sum up credits for this semester's subjects
    let semCredits = 0
    for (const subj of sem.mergedSubjects) {
      const c = getCreditsForSubject(subj.code)
      if (c !== null && c > 0) semCredits += c
    }

    entries.push({ sgpa: sgpaVal, credits: semCredits || 20 }) // Default 20 credits per semester
  }

  if (entries.length === 0) return null

  const totalCredits = entries.reduce((sum, e) => sum + e.credits, 0)
  const weighted = entries.reduce((sum, e) => sum + e.sgpa * e.credits, 0)
  return (weighted / totalCredits).toFixed(2)
}

// ── Subcomponents ────────────────────────────────────────────────────────────

function SubjectTable({ subjects }: { subjects: SubjectResult[] }) {
  if (subjects.length === 0) return null
  return (
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
  )
}

function SemesterResultCard({ semResult, onPrint }: { semResult: SemesterResult; onPrint?: () => void }) {
  const [expanded, setExpanded] = useState(true)
  const subjects = semResult.mergedSubjects
  const passed = subjects.filter((s) => s.passed).length
  const failed = subjects.length - passed
  const overallResult = failed > 0 ? 'FAIL' : subjects.length > 0 ? 'PASS' : null
  const hasReval = semResult.reval !== null
  const frameRef = useRef<HTMLIFrameElement>(null)

  return (
    <div className="rounded-2xl border border-slate-200 bg-white shadow-sm overflow-hidden">
      {/* Header */}
      <button
        onClick={() => setExpanded(!expanded)}
        className="flex w-full items-center justify-between px-5 py-4 text-left transition-colors hover:bg-slate-50"
      >
        <div className="flex items-center gap-3">
          <div className={cn(
            'flex h-10 w-10 items-center justify-center rounded-xl text-sm font-bold',
            overallResult === 'PASS' ? 'bg-emerald-100 text-emerald-700' :
            overallResult === 'FAIL' ? 'bg-red-100 text-red-700' :
            'bg-slate-100 text-slate-500'
          )}>
            S{semResult.semester}
          </div>
          <div>
            <p className="text-sm font-bold text-slate-900">{semResult.label}</p>
            <div className="flex items-center gap-3 text-xs text-slate-500">
              {overallResult && (
                <span className={cn(
                  'font-semibold',
                  overallResult === 'PASS' ? 'text-emerald-600' : 'text-red-600'
                )}>
                  {overallResult === 'PASS' ? '✅' : '❌'} {overallResult}
                </span>
              )}
              {semResult.sgpa && (
                <span className="font-semibold text-indigo-600">SGPA: {semResult.sgpa}</span>
              )}
              {hasReval && (
                <span className="rounded-full bg-amber-100 px-2 py-0.5 text-xs font-semibold text-amber-700">
                  Reval merged
                </span>
              )}
              <span>{subjects.length} subjects</span>
            </div>
          </div>
        </div>
        <div className="text-slate-400">
          {expanded ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
        </div>
      </button>

      {/* Expandable body */}
      <AnimatePresence>
        {expanded && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: 'auto', opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.2 }}
            className="overflow-hidden"
          >
            <div className="space-y-4 border-t border-slate-100 px-5 py-4">
              {/* Summary stats */}
              <div className="flex flex-wrap gap-3">
                <div className="rounded-xl border border-slate-200 bg-slate-50 px-4 py-2">
                  <p className="text-xs text-slate-500">Passed</p>
                  <p className="text-lg font-bold text-emerald-600">{passed}</p>
                </div>
                {failed > 0 && (
                  <div className="rounded-xl border border-red-200 bg-red-50 px-4 py-2">
                    <p className="text-xs text-slate-500">Failed</p>
                    <p className="text-lg font-bold text-red-600">{failed}</p>
                  </div>
                )}
                {semResult.sgpa && (
                  <div className="rounded-xl border border-indigo-200 bg-indigo-50 px-4 py-2">
                    <p className="text-xs text-slate-500">SGPA</p>
                    <p className="text-lg font-bold text-indigo-700">{semResult.sgpa}</p>
                  </div>
                )}
              </div>

              {/* Subject table */}
              <SubjectTable subjects={subjects} />

              {/* Raw HTML preview — collapsible */}
              {semResult.regular && (
                <details className="group">
                  <summary className="cursor-pointer text-xs font-semibold text-slate-500 transition-colors hover:text-slate-700">
                    Show raw VTU result HTML
                  </summary>
                  <div className="mt-2 overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
                    <iframe
                      ref={frameRef}
                      title={`VTU result S${semResult.semester}`}
                      srcDoc={semResult.regular.html}
                      className="h-[600px] w-full bg-white"
                    />
                  </div>
                </details>
              )}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  )
}

function CgpaCard({ cgpa, semesterResults }: { cgpa: string | null; semesterResults: SemesterResult[] }) {
  if (!cgpa && semesterResults.length === 0) return null

  return (
    <div className="rounded-2xl border-2 border-indigo-200 bg-gradient-to-br from-indigo-50 via-white to-violet-50 p-6 shadow-sm">
      <div className="flex items-center gap-3 mb-4">
        <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-indigo-100">
          <GraduationCap size={24} className="text-indigo-600" />
        </div>
        <div>
          <h3 className="text-lg font-bold text-slate-900">Overall Performance</h3>
          <p className="text-xs text-slate-500">Across all fetched semesters</p>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {/* CGPA */}
        <div className="rounded-xl bg-white/80 border border-indigo-100 p-4 text-center shadow-sm">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">CGPA</p>
          <p className="mt-1 text-3xl font-black text-indigo-700">{cgpa || '—'}</p>
        </div>

        {/* Per-semester SGPAs */}
        {semesterResults.map((sem) => (
          <div key={sem.semester} className="rounded-xl bg-white/80 border border-slate-200 p-4 text-center shadow-sm">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
              Sem {sem.semester} SGPA
            </p>
            <p className={cn(
              'mt-1 text-2xl font-bold',
              sem.sgpa ? 'text-slate-800' : 'text-slate-400'
            )}>
              {sem.sgpa || '—'}
            </p>
          </div>
        ))}
      </div>
    </div>
  )
}

function FetchProgressPanel({ progress }: { progress: FetchProgress[] }) {
  if (progress.length === 0) return null

  return (
    <div className="rounded-2xl border border-violet-200 bg-violet-50/50 p-4 space-y-2">
      <div className="flex items-center gap-2 mb-2">
        <Loader2 size={16} className="animate-spin text-violet-600" />
        <p className="text-sm font-semibold text-violet-800">Fetching results...</p>
      </div>
      {progress.map((p, idx) => (
        <div key={idx} className="flex items-center gap-2 text-sm">
          {p.status === 'pending' && <div className="h-4 w-4 rounded-full border-2 border-slate-300" />}
          {p.status === 'fetching' && <Loader2 size={16} className="animate-spin text-violet-600" />}
          {p.status === 'done' && <CheckCircle size={16} className="text-emerald-600" />}
          {p.status === 'error' && <XCircle size={16} className="text-red-500" />}
          {p.status === 'skipped' && <AlertTriangle size={16} className="text-amber-500" />}
          <span className={cn(
            'text-sm',
            p.status === 'fetching' ? 'font-semibold text-violet-800' :
            p.status === 'done' ? 'text-emerald-700' :
            p.status === 'error' ? 'text-red-600' :
            p.status === 'skipped' ? 'text-amber-600' :
            'text-slate-500'
          )}>
            {p.label}
          </span>
          {p.message && (
            <span className="text-xs text-slate-400">— {p.message}</span>
          )}
        </div>
      ))}
    </div>
  )
}

// ── Main Page ────────────────────────────────────────────────────────────────

export default function ResultFetchPage() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const { data: mentorStudents, isLoading: studentsLoading } = useMentorStudents(user?.id)

  // Form state
  const [usn, setUsn] = useState('1CR24CI063')
  const [filterQuery, setFilterQuery] = useState('')

  // Semester selection
  const [selectedSemesters, setSelectedSemesters] = useState<Set<number>>(new Set([1, 2, 3]))
  const [includeReval, setIncludeReval] = useState<Set<number>>(new Set())
  const [includeSummer, setIncludeSummer] = useState(false)
  const [includeSummerReval, setIncludeSummerReval] = useState(false)

  // Fetching state
  const [isFetching, setIsFetching] = useState(false)
  const [fetchProgress, setFetchProgress] = useState<FetchProgress[]>([])

  // Results state
  const [semesterResults, setSemesterResults] = useState<SemesterResult[]>([])
  const [summerResult, setSummerResult] = useState<SummerResult | null>(null)
  const [studentName, setStudentName] = useState<string | null>(null)
  const [studentBranch, setStudentBranch] = useState<string | null>(null)
  const [resultUsn, setResultUsn] = useState<string | null>(null)
  const [cgpa, setCgpa] = useState<string | null>(null)

  // Legacy single-result state (for Enhanced Report modal compatibility)
  const [selectedSemForReport, setSelectedSemForReport] = useState<number | null>(null)
  const [isEnhancedModalOpen, setIsEnhancedModalOpen] = useState(false)
  const [aiSummary, setAiSummary] = useState<string | null>(null)
  const [isLoadingSummary, setIsLoadingSummary] = useState(false)

  // Student queue
  const [bulkBusyUsn, setBulkBusyUsn] = useState<string | null>(null)

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

  // Toggle semester selection
  const toggleSemester = (sem: number) => {
    setSelectedSemesters((prev) => {
      const next = new Set(prev)
      if (next.has(sem)) {
        next.delete(sem)
        // Also remove from reval if deselected
        setIncludeReval((r) => { const n = new Set(r); n.delete(sem); return n })
      } else {
        next.add(sem)
      }
      return next
    })
  }

  const toggleReval = (sem: number) => {
    setIncludeReval((prev) => {
      const next = new Set(prev)
      if (next.has(sem)) next.delete(sem)
      else next.add(sem)
      return next
    })
  }

  // ── Core fetch logic ─────────────────────────────────────────────────────

  const fetchSingleResult = useCallback(async (targetUsn: string, resultUrl: string): Promise<VtuResultItem | null> => {
    try {
      const { data, error } = await supabase.functions.invoke(VTU_FUNCTION_NAME, {
        body: { usn: targetUsn, resultUrl },
      })

      if (error) throw error
      if (!data?.ok) throw new Error(data?.message || 'VTU result fetch failed.')

      return {
        usn: targetUsn.trim().toUpperCase(),
        fetchedAt: new Date().toISOString(),
        html: data.html,
        summary: data.summary || extractSummaryFromHtml(data.html),
      }
    } catch {
      return null
    }
  }, [])

  const fetchAllResults = useCallback(async (targetUsn: string) => {
    const trimmedUsn = targetUsn.trim().toUpperCase()
    if (!trimmedUsn || trimmedUsn.length < 8) {
      toast.error('Enter a valid USN.')
      return
    }

    setIsFetching(true)
    setSemesterResults([])
    setSummerResult(null)
    setStudentName(null)
    setStudentBranch(null)
    setResultUsn(trimmedUsn)
    setCgpa(null)

    // Build the fetch queue
    const queue: { entry: SemesterUrlEntry; progressIdx: number }[] = []
    const progress: FetchProgress[] = []

    // Regular semesters
    const sortedSemesters = Array.from(selectedSemesters).sort((a, b) => a - b)
    for (const sem of sortedSemesters) {
      const regularEntry = SEMESTER_URLS.find((e) => e.semester === sem && e.type === 'regular')
      if (regularEntry) {
        progress.push({ label: `Sem ${sem} — Regular`, status: 'pending' })
        queue.push({ entry: regularEntry, progressIdx: progress.length - 1 })
      }

      if (includeReval.has(sem)) {
        const revalEntry = SEMESTER_URLS.find((e) => e.semester === sem && e.type === 'reval')
        if (revalEntry) {
          progress.push({ label: `Sem ${sem} — Reval`, status: 'pending' })
          queue.push({ entry: revalEntry, progressIdx: progress.length - 1 })
        }
      }
    }

    // Summer
    if (includeSummer) {
      const summerEntry = SEMESTER_URLS.find((e) => e.type === 'summer')
      if (summerEntry) {
        progress.push({ label: 'Summer Semester', status: 'pending' })
        queue.push({ entry: summerEntry, progressIdx: progress.length - 1 })
      }

      if (includeSummerReval) {
        const summerRevalEntry = SEMESTER_URLS.find((e) => e.type === 'summer_reval')
        if (summerRevalEntry) {
          progress.push({ label: 'Summer Semester — Reval', status: 'pending' })
          queue.push({ entry: summerRevalEntry, progressIdx: progress.length - 1 })
        }
      }
    }

    setFetchProgress([...progress])

    // Accumulate results
    const semResults = new Map<number, { regular: VtuResultItem | null; reval: VtuResultItem | null }>()
    let summerRegular: VtuResultItem | null = null
    let summerReval: VtuResultItem | null = null

    // Sequential fetch
    for (const { entry, progressIdx } of queue) {
      // Update progress
      progress[progressIdx].status = 'fetching'
      setFetchProgress([...progress])

      const result = await fetchSingleResult(trimmedUsn, entry.url)

      if (result) {
        progress[progressIdx].status = 'done'
        progress[progressIdx].message = result.summary.result || 'Fetched'

        // Capture student name/branch from first successful result
        if (!studentName && result.summary.name) setStudentName(result.summary.name)
        if (!studentBranch && result.summary.branch) setStudentBranch(result.summary.branch)

        if (entry.type === 'regular') {
          const existing = semResults.get(entry.semester) || { regular: null, reval: null }
          existing.regular = result
          semResults.set(entry.semester, existing)
        } else if (entry.type === 'reval') {
          const existing = semResults.get(entry.semester) || { regular: null, reval: null }
          existing.reval = result
          semResults.set(entry.semester, existing)
        } else if (entry.type === 'summer') {
          summerRegular = result
        } else if (entry.type === 'summer_reval') {
          summerReval = result
        }
      } else {
        progress[progressIdx].status = 'error'
        progress[progressIdx].message = 'Failed or no result found'
      }

      setFetchProgress([...progress])

      // Small delay between fetches
      await new Promise((r) => setTimeout(r, 500))
    }

    // Build final semester results
    const finalSemResults: SemesterResult[] = []
    for (const sem of sortedSemesters) {
      const data = semResults.get(sem)
      if (!data) {
        finalSemResults.push({
          semester: sem,
          label: `Semester ${sem}`,
          regular: null,
          reval: null,
          mergedSubjects: [],
          sgpa: null,
        })
        continue
      }

      const regularSubjects = data.regular?.summary.subjects || []
      const revalSubjects = data.reval?.summary.subjects || []
      const merged = mergeSubjects(regularSubjects, revalSubjects)

      // SGPA: calculate from merged subjects using credit-weighted formula
      // Falls back to VTU-provided value if our calculation returns null
      const calculatedSgpa = calculateSgpaFromSubjects(merged)
      const vtuSgpa = data.regular?.summary.sgpa || data.reval?.summary.sgpa || null
      const sgpa = calculatedSgpa || vtuSgpa

      finalSemResults.push({
        semester: sem,
        label: `Semester ${sem}`,
        regular: data.regular,
        reval: data.reval,
        mergedSubjects: merged,
        sgpa,
      })
    }

    setSemesterResults(finalSemResults)

    // Summer result
    if (summerRegular || summerReval) {
      const summerSubjects = mergeSubjects(
        summerRegular?.summary.subjects || [],
        summerReval?.summary.subjects || []
      )
      const summerSgpa = calculateSgpaFromSubjects(summerSubjects)
        || summerRegular?.summary.sgpa || summerReval?.summary.sgpa || null
      setSummerResult({
        regular: summerRegular,
        reval: summerReval,
        mergedSubjects: summerSubjects,
        sgpa: summerSgpa,
      })
    }

    // Calculate CGPA from regular semesters only
    const computedCgpa = calculateCgpa(finalSemResults)
    setCgpa(computedCgpa)

    setIsFetching(false)

    const successCount = progress.filter((p) => p.status === 'done').length
    const errorCount = progress.filter((p) => p.status === 'error').length
    if (successCount > 0) {
      toast.success(`Fetched ${successCount} result(s)${errorCount > 0 ? `, ${errorCount} failed` : ''}`)
    } else {
      toast.error('Could not fetch any results. Check the USN and try again.')
    }
  }, [selectedSemesters, includeReval, includeSummer, includeSummerReval, fetchSingleResult, studentName, studentBranch])

  const handleManualFetch = async () => {
    await fetchAllResults(usn)
  }

  const handleFillStudent = (student: MentorStudentRow) => {
    setUsn(student.id.toUpperCase())
    toast.success(`Loaded ${student.full_name}`)
  }

  const handleFetchForStudent = async (student: MentorStudentRow) => {
    setBulkBusyUsn(student.id)
    setUsn(student.id.toUpperCase())
    await fetchAllResults(student.id)
    setBulkBusyUsn(null)
  }

  // Enhanced report for a specific semester
  const handleOpenEnhancedReport = async (semIdx: number) => {
    const sem = semesterResults[semIdx]
    if (!sem?.regular) return
    setSelectedSemForReport(semIdx)
    setIsEnhancedModalOpen(true)

    if (aiSummary) return

    try {
      setIsLoadingSummary(true)
      const { data, error } = await supabase.functions.invoke('generate-ai-summary', {
        body: {
          studentName: studentName || sem.regular.summary.name,
          usn: resultUsn,
          semester: String(sem.semester),
          subjects: sem.mergedSubjects,
          result: sem.mergedSubjects.some((s) => !s.passed) ? 'FAIL' : 'PASS',
        },
      })
      if (error) throw error
      if (!data.ok) throw new Error(data.error || 'Failed to generate summary')
      setAiSummary(data.summary)
    } catch (err: any) {
      toast.error('Could not generate AI summary: ' + err.message)
    } finally {
      setIsLoadingSummary(false)
    }
  }

  // Build a VtuResultItem for the enhanced report modal (compatibility shim)
  const reportItem: VtuResultItem | null = useMemo(() => {
    if (selectedSemForReport === null || !semesterResults[selectedSemForReport]) return null
    const sem = semesterResults[selectedSemForReport]
    return sem.regular || {
      usn: resultUsn || '',
      fetchedAt: new Date().toISOString(),
      html: '',
      summary: {
        usn: resultUsn || undefined,
        name: studentName || undefined,
        semester: String(sem.semester),
        subjects: sem.mergedSubjects,
        result: sem.mergedSubjects.some((s) => !s.passed) ? 'FAIL' : 'PASS',
      },
    }
  }, [selectedSemForReport, semesterResults, resultUsn, studentName])

  const hasResults = semesterResults.length > 0 || summerResult !== null

  // ── Semester selection checkboxes ────────────────────────────────────────

  const semCheckboxes = [1, 2, 3].map((sem) => {
    const hasRevalUrl = SEMESTER_URLS.some((e) => e.semester === sem && e.type === 'reval')
    return { sem, hasRevalUrl }
  })

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
              <h1 className="text-2xl font-bold text-slate-900 sm:text-3xl">VTU Multi-Semester Results</h1>
              <p className="mt-1 max-w-2xl text-sm text-slate-500">
                Fetch results for all semesters at once. Optionally include reval and summer semester results.
                SGPA per semester and overall CGPA are calculated automatically.
              </p>
            </div>

            <div className="grid grid-cols-3 gap-3 rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Semesters</p>
                <p className="mt-1 text-2xl font-bold text-slate-900">{selectedSemesters.size}</p>
              </div>
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">Students</p>
                <p className="mt-1 text-2xl font-bold text-slate-900">{mentorStudents?.length ?? 0}</p>
              </div>
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">CGPA</p>
                <p className="mt-1 text-2xl font-bold text-indigo-700">{cgpa || '—'}</p>
              </div>
            </div>
          </div>
        </motion.div>

        <div className="grid gap-6 lg:grid-cols-3">
          {/* ── Left column: controls ────────────────────────────────────── */}
          <div className="lg:col-span-1 space-y-6">
            {/* USN + Fetch */}
            <Card title="Fetch results" action={<Sparkles size={16} className="text-brand-600" />}>
              <div className="space-y-4">
                <Input
                  label="USN"
                  value={usn}
                  onChange={(e) => setUsn(e.target.value.toUpperCase())}
                  placeholder="1CR24CI063"
                  icon={Search}
                />

                {/* Semester selection */}
                <div>
                  <p className="mb-2 text-xs font-semibold uppercase tracking-wide text-slate-500">
                    Select semesters
                  </p>
                  <div className="space-y-2">
                    {semCheckboxes.map(({ sem, hasRevalUrl }) => (
                      <div key={sem} className="rounded-xl border border-slate-200 bg-slate-50 p-3">
                        <label className="flex items-center gap-2 cursor-pointer">
                          <input
                            type="checkbox"
                            checked={selectedSemesters.has(sem)}
                            onChange={() => toggleSemester(sem)}
                            className="h-4 w-4 rounded border-slate-300 text-indigo-600 focus:ring-indigo-500"
                          />
                          <span className="text-sm font-semibold text-slate-800">Semester {sem}</span>
                        </label>

                        {/* Reval toggle — only if semester is selected and reval URL exists */}
                        {selectedSemesters.has(sem) && hasRevalUrl && (
                          <label className="mt-2 ml-6 flex items-center gap-2 cursor-pointer">
                            <input
                              type="checkbox"
                              checked={includeReval.has(sem)}
                              onChange={() => toggleReval(sem)}
                              className="h-3.5 w-3.5 rounded border-slate-300 text-amber-600 focus:ring-amber-500"
                            />
                            <span className="text-xs text-slate-600">Include reval</span>
                          </label>
                        )}
                      </div>
                    ))}
                  </div>
                </div>

                {/* Summer semester */}
                <div className="rounded-xl border border-amber-200 bg-amber-50 p-3 space-y-2">
                  <label className="flex items-center gap-2 cursor-pointer">
                    <input
                      type="checkbox"
                      checked={includeSummer}
                      onChange={() => {
                        setIncludeSummer(!includeSummer)
                        if (includeSummer) setIncludeSummerReval(false)
                      }}
                      className="h-4 w-4 rounded border-amber-300 text-amber-600 focus:ring-amber-500"
                    />
                    <span className="text-sm font-semibold text-amber-800">Summer Semester</span>
                    <span className="text-xs text-amber-600">(optional)</span>
                  </label>
                  {includeSummer && (
                    <label className="ml-6 flex items-center gap-2 cursor-pointer">
                      <input
                        type="checkbox"
                        checked={includeSummerReval}
                        onChange={() => setIncludeSummerReval(!includeSummerReval)}
                        className="h-3.5 w-3.5 rounded border-amber-300 text-amber-600 focus:ring-amber-500"
                      />
                      <span className="text-xs text-amber-700">Include summer reval</span>
                    </label>
                  )}
                </div>

                <Button loading={isFetching} onClick={handleManualFetch} fullWidth disabled={selectedSemesters.size === 0}>
                  <FileText size={16} className="mr-2" /> {isFetching ? 'Fetching results...' : `Fetch ${selectedSemesters.size} semester(s)`}
                </Button>

                <div className="flex items-start gap-2 rounded-xl border border-violet-100 bg-violet-50 p-3">
                  <Bot size={16} className="mt-0.5 shrink-0 text-violet-600" />
                  <p className="text-xs text-violet-700">
                    Each semester requires a separate captcha solve. Fetching {selectedSemesters.size} semester(s)
                    {includeReval.size > 0 ? ` + ${includeReval.size} reval(s)` : ''}
                    {includeSummer ? ' + summer' : ''}
                    {' '}will take ~{(selectedSemesters.size + includeReval.size + (includeSummer ? 1 : 0) + (includeSummerReval ? 1 : 0)) * 8}–
                    {(selectedSemesters.size + includeReval.size + (includeSummer ? 1 : 0) + (includeSummerReval ? 1 : 0)) * 15}s.
                  </p>
                </div>
              </div>
            </Card>

            {/* Mentor student queue */}
            <Card title="Mentor student queue" action={<Users size={16} className="text-brand-600" />}>
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
                        <div key={student.id} className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
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
                            <Button size="sm" loading={isBusy} onClick={() => handleFetchForStudent(student)}>
                              Fetch all
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

          {/* ── Right column: results ────────────────────────────────────── */}
          <div className="lg:col-span-2 space-y-6">
            {/* Progress */}
            {isFetching && <FetchProgressPanel progress={fetchProgress} />}

            {/* CGPA Overview Card */}
            {hasResults && <CgpaCard cgpa={cgpa} semesterResults={semesterResults} />}

            {/* Student info */}
            {hasResults && (studentName || resultUsn) && (
              <div className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
                <div className="flex items-center gap-4">
                  <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-indigo-100 text-indigo-700 font-bold text-lg">
                    {(studentName || '?')[0]}
                  </div>
                  <div>
                    <p className="text-lg font-bold text-slate-900">{studentName || resultUsn}</p>
                    <p className="text-sm text-slate-500">
                      {resultUsn}{studentBranch ? ` • ${studentBranch}` : ''}
                    </p>
                  </div>
                </div>
              </div>
            )}

            {/* Semester result cards */}
            {semesterResults.map((sem, idx) => (
              <div key={sem.semester} className="space-y-3">
                <SemesterResultCard semResult={sem} />
                {sem.regular && (
                  <div className="flex gap-2 pl-2">
                    <Button
                      variant="secondary"
                      size="sm"
                      onClick={() => handleOpenEnhancedReport(idx)}
                      className="text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 border-indigo-200"
                    >
                      <Sparkles size={14} className="mr-1.5" /> AI Report
                    </Button>
                  </div>
                )}
              </div>
            ))}

            {/* Summer semester */}
            {summerResult && (
              <div className="space-y-3">
                <div className="rounded-2xl border-2 border-amber-200 bg-amber-50/30 p-1">
                  <SemesterResultCard
                    semResult={{
                      semester: 0,
                      label: 'Summer Semester',
                      regular: summerResult.regular,
                      reval: summerResult.reval,
                      mergedSubjects: summerResult.mergedSubjects,
                      sgpa: summerResult.sgpa,
                    }}
                  />
                </div>
              </div>
            )}

            {/* Empty state */}
            {!hasResults && !isFetching && (
              <Card title="Results">
                <div className="rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-8 text-center">
                  <GraduationCap size={40} className="mx-auto mb-3 text-slate-300" />
                  <p className="text-sm font-semibold text-slate-500">No results fetched yet</p>
                  <p className="mt-1 text-xs text-slate-400">
                    Enter a USN, select semesters, and click Fetch to get started.
                  </p>
                </div>
              </Card>
            )}

            {/* Notes */}
            <Card title="Workflow notes">
              <ul className="space-y-3 text-sm text-slate-600">
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 shrink-0 rounded-full bg-brand-500" /> Results are fetched sequentially — each semester requires a separate VTU captcha session.</li>
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 shrink-0 rounded-full bg-brand-500" /> When reval is enabled, marks are merged automatically — the better score per subject is kept.</li>
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 shrink-0 rounded-full bg-brand-500" /> CGPA is calculated as the average of all regular semester SGPAs (summer is excluded).</li>
                <li className="flex gap-2"><span className="mt-1 h-2 w-2 shrink-0 rounded-full bg-amber-500" /> Summer semester is separate and optional — not all students will have summer results.</li>
              </ul>
            </Card>
          </div>
        </div>
      </div>

      {/* Enhanced Report Modal */}
      {reportItem && (
        <EnhancedReportModal
          isOpen={isEnhancedModalOpen}
          onClose={() => {
            setIsEnhancedModalOpen(false)
            setAiSummary(null)
            setSelectedSemForReport(null)
          }}
          student={reportItem}
          aiSummary={aiSummary}
          isLoadingSummary={isLoadingSummary}
          sgpa={semesterResults[selectedSemForReport ?? 0]?.sgpa || 'N/A'}
        />
      )}
    </AppShell>
  )
}
