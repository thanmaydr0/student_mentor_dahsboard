import { useQuery } from '@tanstack/react-query'
import { motion } from 'framer-motion'
import { ClipboardList, CheckCircle2, Clock, TrendingUp, TrendingDown, FlaskConical, PenLine } from 'lucide-react'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'
import { Skeleton } from '../ui/Skeleton'

interface IATRow {
  subject_name: string
  iat1: number | null
  iat2: number | null
  lab_iat1: number | null
  lab_iat2: number | null
  assignment1: number | null
  assignment2: number | null
}

function useStudentIATMarks(userId: string | undefined) {
  return useQuery({
    queryKey: ['student-iat-marks', userId],
    queryFn: async () => {
      if (!userId) throw new Error('User ID required')

      // 1. Get enrollments
      const { data: enrollments } = await supabase
        .from('enrollments')
        .select('class_id')
        .eq('student_id', userId)

      if (!enrollments || enrollments.length === 0) return []

      const classIds = enrollments.map(e => e.class_id)

      // 2. Get class -> subject mapping
      const { data: classes } = await supabase
        .from('classes')
        .select('id, subject_id')
        .in('id', classIds)

      const subjectIds = [...new Set((classes || []).map(c => c.subject_id))]
      const { data: subjects } = await supabase
        .from('subjects')
        .select('id, name')
        .in('id', subjectIds)

      const subjectMap = new Map((subjects || []).map(s => [s.id, s.name]))
      const classSubjectMap = new Map((classes || []).map(c => [c.id, subjectMap.get(c.subject_id) || 'Unknown']))

      // 3. Get IAT marks — using the ACTUAL schema columns
      const { data: iatMarks } = await supabase
        .from('iat_marks')
        .select('student_id, class_id, iat1, iat2, lab_iat1, lab_iat2, assignment1, assignment2')
        .eq('student_id', userId)

      // 4. Deduplicate class IDs per subject
      const classToSubjectId = new Map((classes || []).map(c => [c.id, c.subject_id]))
      const seenSubjects = new Set<string>()
      const uniqueClassIds = classIds.filter(cid => {
        const subjectId = classToSubjectId.get(cid)
        if (!subjectId || seenSubjects.has(subjectId)) return false
        seenSubjects.add(subjectId)
        return true
      })

      // 5. Build IAT marks map keyed by class_id
      const iatMap = new Map<string, any>()
      ;(iatMarks || []).forEach(m => {
        iatMap.set(m.class_id, m)
      })

      const rows: IATRow[] = uniqueClassIds.map(cid => {
        const m = iatMap.get(cid)
        return {
          subject_name: classSubjectMap.get(cid) || 'Unknown',
          iat1: m?.iat1 != null ? Number(m.iat1) : null,
          iat2: m?.iat2 != null ? Number(m.iat2) : null,
          lab_iat1: m?.lab_iat1 != null ? Number(m.lab_iat1) : null,
          lab_iat2: m?.lab_iat2 != null ? Number(m.lab_iat2) : null,
          assignment1: m?.assignment1 != null ? Number(m.assignment1) : null,
          assignment2: m?.assignment2 != null ? Number(m.assignment2) : null,
        }
      })

      return rows
    },
    enabled: !!userId,
  })
}

function MarkBadge({ marks, max = 50 }: { marks: number | null, max?: number }) {
  if (marks === null) {
    return (
      <span className="inline-flex items-center gap-1 rounded-full bg-slate-100 dark:bg-slate-800 px-2.5 py-1 text-xs font-medium text-slate-500 dark:text-slate-400">
        <Clock size={12} />
        Pending
      </span>
    )
  }
  const pct = (marks / max) * 100
  const color = pct >= 70 ? 'bg-green-100 dark:bg-green-900/40 text-green-700 dark:text-green-400' :
                pct >= 50 ? 'bg-amber-100 dark:bg-amber-900/40 text-amber-700 dark:text-amber-400' :
                'bg-red-100 dark:bg-red-900/40 text-red-700 dark:text-red-400'
  return (
    <span className={cn('inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 text-xs font-bold', color)}>
      <CheckCircle2 size={12} />
      {marks}/{max}
    </span>
  )
}

function ScoreBar({ value, max = 50 }: { value: number | null, max?: number }) {
  if (value === null) return <div className="h-1.5 w-full rounded-full bg-slate-100 dark:bg-slate-800" />
  const pct = Math.min(100, (value / max) * 100)
  const color = pct >= 70 ? 'bg-green-500' : pct >= 50 ? 'bg-amber-500' : 'bg-red-500'
  return (
    <div className="h-1.5 w-full rounded-full bg-slate-100 dark:bg-slate-800 overflow-hidden">
      <motion.div
        initial={{ width: 0 }}
        animate={{ width: `${pct}%` }}
        transition={{ duration: 0.5, ease: 'easeOut' }}
        className={cn('h-full rounded-full', color)}
      />
    </div>
  )
}

export default function IATMarksCard({ userId }: { userId: string | undefined }) {
  const { data, isLoading } = useStudentIATMarks(userId)

  if (isLoading) {
    return (
      <div className="rounded-2xl bg-white dark:bg-[#13151a]/80 shadow-sm border border-slate-200 dark:border-white/5 overflow-hidden dark:backdrop-blur-md">
        <div className="flex items-center gap-3 border-b border-slate-100 dark:border-white/5 bg-slate-50/50 dark:bg-white/5 px-5 py-4">
          <Skeleton className="h-10 w-10 rounded-xl" />
          <div className="space-y-2">
            <Skeleton className="h-4 w-40 rounded" />
            <Skeleton className="h-3 w-52 rounded" />
          </div>
        </div>
        <div className="p-5 space-y-3">
          {Array.from({ length: 4 }).map((_, i) => (
            <Skeleton key={i} className="h-16 w-full rounded-xl" />
          ))}
        </div>
      </div>
    )
  }

  if (!data || data.length === 0) return null

  // Calculate improvement/decline between IAT1 and IAT2
  const bothAvailable = data.filter(d => d.iat1 !== null && d.iat2 !== null)
  const avgChange = bothAvailable.length > 0
    ? bothAvailable.reduce((sum, d) => sum + (d.iat2! - d.iat1!), 0) / bothAvailable.length
    : null

  // Check if any lab/assignment data exists
  const hasLabData = data.some(d => d.lab_iat1 !== null || d.lab_iat2 !== null)
  const hasAssignmentData = data.some(d => d.assignment1 !== null || d.assignment2 !== null)

  return (
    <div className="rounded-2xl bg-white dark:bg-[#13151a]/80 shadow-sm border border-slate-200 dark:border-white/5 overflow-hidden dark:backdrop-blur-md">
      {/* Header */}
      <div className="flex items-center gap-3 border-b border-slate-100 dark:border-white/5 bg-slate-50/50 dark:bg-white/5 px-5 py-4">
        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-purple-100 dark:bg-purple-900/40 text-purple-600 dark:text-purple-400 shadow-sm">
          <ClipboardList size={20} />
        </div>
        <div className="flex-1">
          <h2 className="text-lg font-semibold text-slate-800 dark:text-white tracking-tight">IAT Marks</h2>
          <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">Synced from mentor's records</p>
        </div>
        {avgChange !== null && (
          <div className={cn(
            'flex items-center gap-1 rounded-full px-3 py-1.5 text-xs font-bold',
            avgChange >= 0 ? 'bg-green-100 dark:bg-green-900/40 text-green-700 dark:text-green-400' : 'bg-red-100 dark:bg-red-900/40 text-red-700 dark:text-red-400'
          )}>
            {avgChange >= 0 ? <TrendingUp size={14} /> : <TrendingDown size={14} />}
            {avgChange >= 0 ? '+' : ''}{avgChange.toFixed(1)} avg
          </div>
        )}
      </div>

      <div className="p-5">
        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto rounded-xl border border-slate-100 dark:border-white/5">
          <table className="w-full text-left text-sm">
            <thead className="bg-slate-50 dark:bg-white/5 text-xs uppercase tracking-wide text-slate-400 dark:text-slate-500 border-b border-slate-100 dark:border-white/5">
              <tr>
                <th className="px-4 py-3 font-semibold">Subject</th>
                <th className="px-4 py-3 font-semibold text-center">IAT 1</th>
                <th className="px-4 py-3 font-semibold text-center">IAT 2</th>
                {hasLabData && <th className="px-4 py-3 font-semibold text-center">Lab 1</th>}
                {hasLabData && <th className="px-4 py-3 font-semibold text-center">Lab 2</th>}
                {hasAssignmentData && <th className="px-4 py-3 font-semibold text-center">Assign 1</th>}
                {hasAssignmentData && <th className="px-4 py-3 font-semibold text-center">Assign 2</th>}
                <th className="px-4 py-3 font-semibold text-center">Trend</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50 dark:divide-white/5 bg-white dark:bg-transparent">
              {data.map((row, idx) => {
                const trend = row.iat1 !== null && row.iat2 !== null
                  ? row.iat2 - row.iat1
                  : null
                return (
                  <tr key={idx} className="hover:bg-slate-50/50 dark:hover:bg-white/5 transition-colors">
                    <td className="px-4 py-3.5 font-medium text-slate-800 dark:text-white">{row.subject_name}</td>
                    <td className="px-4 py-3.5 text-center">
                      <MarkBadge marks={row.iat1} />
                    </td>
                    <td className="px-4 py-3.5 text-center">
                      <MarkBadge marks={row.iat2} />
                    </td>
                    {hasLabData && (
                      <td className="px-4 py-3.5 text-center">
                        <MarkBadge marks={row.lab_iat1} />
                      </td>
                    )}
                    {hasLabData && (
                      <td className="px-4 py-3.5 text-center">
                        <MarkBadge marks={row.lab_iat2} />
                      </td>
                    )}
                    {hasAssignmentData && (
                      <td className="px-4 py-3.5 text-center">
                        <MarkBadge marks={row.assignment1} />
                      </td>
                    )}
                    {hasAssignmentData && (
                      <td className="px-4 py-3.5 text-center">
                        <MarkBadge marks={row.assignment2} />
                      </td>
                    )}
                    <td className="px-4 py-3.5 text-center">
                      {trend !== null ? (
                        <span className={cn(
                          'inline-flex items-center gap-1 text-xs font-bold',
                          trend > 0 ? 'text-green-600 dark:text-green-400' : trend < 0 ? 'text-red-600 dark:text-red-400' : 'text-slate-400 dark:text-slate-500'
                        )}>
                          {trend > 0 ? <TrendingUp size={14} /> : trend < 0 ? <TrendingDown size={14} /> : null}
                          {trend > 0 ? '+' : ''}{trend}
                        </span>
                      ) : (
                        <span className="text-xs text-slate-400 dark:text-slate-500">—</span>
                      )}
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>

        {/* Mobile Cards */}
        <div className="flex flex-col gap-3 md:hidden">
          {data.map((row, idx) => (
            <div key={idx} className="rounded-xl border border-slate-100 dark:border-white/5 bg-white dark:bg-white/5 p-4 shadow-sm">
              <h4 className="font-semibold text-slate-800 dark:text-white mb-3">{row.subject_name}</h4>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <span className="text-xs text-slate-400 dark:text-slate-500 font-medium">IAT 1</span>
                  <div className="mt-1"><MarkBadge marks={row.iat1} /></div>
                  <div className="mt-1.5"><ScoreBar value={row.iat1} /></div>
                </div>
                <div>
                  <span className="text-xs text-slate-400 dark:text-slate-500 font-medium">IAT 2</span>
                  <div className="mt-1"><MarkBadge marks={row.iat2} /></div>
                  <div className="mt-1.5"><ScoreBar value={row.iat2} /></div>
                </div>
              </div>
              {(hasLabData || hasAssignmentData) && (
                <div className="grid grid-cols-2 gap-3 mt-3 pt-3 border-t border-slate-100 dark:border-white/5">
                  {hasLabData && (
                    <>
                      <div>
                        <span className="text-xs text-slate-400 dark:text-slate-500 font-medium flex items-center gap-1"><FlaskConical size={10} /> Lab 1</span>
                        <div className="mt-1"><MarkBadge marks={row.lab_iat1} /></div>
                      </div>
                      <div>
                        <span className="text-xs text-slate-400 dark:text-slate-500 font-medium flex items-center gap-1"><FlaskConical size={10} /> Lab 2</span>
                        <div className="mt-1"><MarkBadge marks={row.lab_iat2} /></div>
                      </div>
                    </>
                  )}
                  {hasAssignmentData && (
                    <>
                      <div>
                        <span className="text-xs text-slate-400 dark:text-slate-500 font-medium flex items-center gap-1"><PenLine size={10} /> Assign 1</span>
                        <div className="mt-1"><MarkBadge marks={row.assignment1} /></div>
                      </div>
                      <div>
                        <span className="text-xs text-slate-400 dark:text-slate-500 font-medium flex items-center gap-1"><PenLine size={10} /> Assign 2</span>
                        <div className="mt-1"><MarkBadge marks={row.assignment2} /></div>
                      </div>
                    </>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
