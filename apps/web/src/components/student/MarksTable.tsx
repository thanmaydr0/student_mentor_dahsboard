import { useMemo } from 'react'
import { motion } from 'framer-motion'
import { BookOpen } from 'lucide-react'
import Card from '../ui/Card'
import { Skeleton } from '../ui/Skeleton'
import { cn } from '../../lib/utils'
import type { GradeSummary } from '../../types/app.types'

interface MarksTableProps {
  data: GradeSummary[] | undefined
  isLoading: boolean
}

// Helper to determine the style of a grade badge
function getGradeStyle(grade: string | null | undefined): string {
  const g = grade?.toUpperCase() || ''
  switch (g) {
    case 'A': return 'bg-green-100 dark:bg-green-950/40 text-green-800 dark:text-green-400'
    case 'B': return 'bg-blue-100 dark:bg-blue-950/40 text-blue-800 dark:text-blue-400'
    case 'C': return 'bg-amber-100 dark:bg-amber-950/40 text-amber-800 dark:text-amber-400'
    case 'D': return 'bg-orange-100 dark:bg-orange-950/40 text-orange-800 dark:text-orange-400'
    case 'F': return 'bg-red-100 dark:bg-red-950/40 text-red-800 dark:text-red-400'
    default: return 'bg-slate-100 dark:bg-slate-800 text-slate-800 dark:text-slate-300'
  }
}

// Helper to determine the progress bar fill color based on grade
function getProgressColor(grade: string | null | undefined): string {
  const g = grade?.toUpperCase() || ''
  switch (g) {
    case 'A': return 'bg-green-500'
    case 'B': return 'bg-blue-500'
    case 'C': return 'bg-amber-500'
    case 'D': return 'bg-orange-500'
    case 'F': return 'bg-red-500'
    default: return 'bg-slate-500'
  }
}

export default function MarksTable({ data, isLoading }: MarksTableProps) {
  // Calculate summary statistics
  const summary = useMemo(() => {
    if (!data || data.length === 0) return null

    let totalInternal = 0
    let totalExternal = 0
    let totalScore = 0
    const gradeCounts: Record<string, number> = {}

    data.forEach((item) => {
      totalInternal += item.internal || 0
      totalExternal += item.external || 0
      totalScore += item.total || 0
      const g = item.grade || 'N/A'
      gradeCounts[g] = (gradeCounts[g] || 0) + 1
    })

    const count = data.length

    // Find the most frequent grade
    let commonGrade = 'N/A'
    let maxCount = 0
    for (const [grade, gCount] of Object.entries(gradeCounts)) {
      if (gCount > maxCount) {
        maxCount = gCount
        commonGrade = grade
      }
    }

    return {
      avgInternal: Math.round(totalInternal / count),
      avgExternal: Math.round(totalExternal / count),
      avgTotal: Math.round(totalScore / count),
      commonGrade,
    }
  }, [data])

  if (isLoading) {
    return (
      <motion.div initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.4 }}>
        <Card title="Academic Performance">
          <div className="mt-4 space-y-4 hidden md:block">
            {/* Desktop Skeletons: 5 rows with 5 blocks each */}
            {Array.from({ length: 5 }).map((_, i) => (
              <div key={i} className="flex gap-4 border-b border-slate-50 dark:border-white/5 pb-4 last:border-0 last:pb-0">
                <Skeleton className="h-6 w-1/4" />
                <Skeleton className="h-6 w-1/6" />
                <Skeleton className="h-6 w-1/6" />
                <Skeleton className="h-6 w-1/6" />
                <Skeleton className="h-6 w-12 rounded-full" />
              </div>
            ))}
          </div>
          <div className="mt-4 space-y-4 md:hidden">
            {/* Mobile Skeletons */}
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="flex flex-col gap-2 rounded-xl border border-slate-100 dark:border-white/5 p-4">
                 <Skeleton className="h-5 w-1/2" />
                 <div className="flex justify-between gap-4">
                   <Skeleton className="h-4 w-1/3" />
                   <Skeleton className="h-4 w-12 rounded-full" />
                 </div>
              </div>
            ))}
          </div>
        </Card>
      </motion.div>
    )
  }

  if (!data || data.length === 0) {
    return (
      <motion.div initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.4 }}>
        <Card title="Academic Performance">
          <div className="flex h-48 flex-col items-center justify-center text-slate-400 mt-4">
            <BookOpen size={48} className="mb-4 opacity-50" strokeWidth={1.5} />
            <p className="text-sm font-medium">Marks haven't been entered yet</p>
          </div>
        </Card>
      </motion.div>
    )
  }

  return (
    <motion.div initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.4 }}>
      <Card title="Academic Performance">
        <div className="mt-4">
          
          {/* Mobile Layout: Card-per-subject */}
          <div className="flex flex-col gap-3 md:hidden">
            {data.map((row, idx) => (
              <div key={idx} className="flex flex-col gap-3 rounded-xl border border-slate-100 dark:border-white/5 bg-white dark:bg-white/5 p-4 shadow-sm relative overflow-hidden">
                <div className="flex items-start justify-between gap-2">
                  <h4 className="font-semibold text-brand-900 dark:text-white leading-tight">{row.subject_name}</h4>
                  <span className={cn("shrink-0 rounded-full px-2 py-0.5 text-xs font-bold uppercase tracking-wide", getGradeStyle(row.grade))}>
                    {row.grade || 'N/A'}
                  </span>
                </div>
                
                <div className="grid grid-cols-3 gap-2 text-sm text-brand-600 dark:text-slate-400">
                  <div className="flex flex-col">
                    <span className="text-xs text-brand-400 dark:text-slate-500">Int (50)</span>
                    <span className="font-medium text-brand-900 dark:text-white">{row.internal}</span>
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs text-brand-400 dark:text-slate-500">Ext (50)</span>
                    <span className="font-medium text-brand-900 dark:text-white">{row.external}</span>
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs text-brand-400 dark:text-slate-500">Total</span>
                    <span className="font-bold text-brand-900 dark:text-white">{row.total}</span>
                  </div>
                </div>

                {/* Progress bar */}
                <div className="absolute bottom-0 left-0 right-0 h-1 bg-slate-100 dark:bg-slate-800">
                  <div 
                    className={cn("h-full rounded-r-full transition-all duration-500", getProgressColor(row.grade))}
                    style={{ width: `${Math.min(100, Math.max(0, row.total))}%` }}
                  />
                </div>
              </div>
            ))}
            
            {/* Mobile Summary */}
            {summary && (
              <div className="mt-2 rounded-lg bg-slate-50 dark:bg-slate-900/50 p-4 border border-slate-100 dark:border-white/5 font-medium">
                <p className="mb-2 text-xs font-bold uppercase text-slate-400 dark:text-slate-500 tracking-wider">Averages</p>
                <div className="grid grid-cols-2 gap-y-2 text-sm">
                  <span className="text-brand-600 dark:text-slate-400">Total Score:</span>
                  <span className="text-brand-900 dark:text-white font-bold">{summary.avgTotal}</span>
                  <span className="text-brand-600 dark:text-slate-400">Most Common:</span>
                  <span className={cn("inline-flex justify-self-start items-center rounded-full px-2 py-0.5 text-xs font-bold uppercase", getGradeStyle(summary.commonGrade))}>
                    {summary.commonGrade}
                  </span>
                </div>
              </div>
            )}
          </div>

          {/* Desktop Layout: Table */}
          <div className="hidden md:block overflow-x-auto rounded-xl border border-slate-100 dark:border-white/5">
            <table className="w-full text-left text-sm text-brand-600 dark:text-slate-400 border-collapse">
              <thead className="bg-slate-50 dark:bg-white/5 text-xs uppercase tracking-wide text-slate-400 dark:text-slate-500 border-b border-slate-100 dark:border-white/5">
                <tr>
                  <th className="px-4 py-3 font-semibold">Subject</th>
                  <th className="px-4 py-3 font-semibold text-right">Internal (50)</th>
                  <th className="px-4 py-3 font-semibold text-right">External (50)</th>
                  <th className="px-4 py-3 font-semibold text-right">Total</th>
                  <th className="px-4 py-3 font-semibold text-center w-24">Grade</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-50 dark:divide-white/5 bg-white dark:bg-transparent">
                {data.map((row, idx) => (
                  <tr key={idx} className="transition-colors hover:bg-slate-50/50 dark:hover:bg-white/5 group">
                    <td className="px-4 py-3.5 font-medium text-brand-900 dark:text-white">
                      {row.subject_name}
                    </td>
                    <td className="px-4 py-3.5 text-right font-medium">
                      {row.internal}
                    </td>
                    <td className="px-4 py-3.5 text-right font-medium">
                      {row.external}
                    </td>
                    <td className="px-4 py-3.5 text-right">
                      <div className="flex flex-col items-end gap-1.5">
                        <span className="font-bold text-brand-900 dark:text-white">{row.total}</span>
                        {/* 3px Progress Bar */}
                        <div className="h-[3px] w-16 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                           <div 
                             className={cn("h-full rounded-full transition-all duration-500", getProgressColor(row.grade))}
                             style={{ width: `${Math.min(100, Math.max(0, row.total))}%` }}
                           />
                        </div>
                      </div>
                    </td>
                    <td className="px-4 py-3.5 text-center">
                      <span className={cn("inline-flex items-center justify-center rounded-full px-2.5 py-0.5 text-xs font-bold uppercase tracking-wide", getGradeStyle(row.grade))}>
                        {row.grade || 'N/A'}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
              
              {summary && (
                <tfoot className="bg-slate-50 dark:bg-white/5 font-bold text-brand-900 dark:text-white border-t-2 border-slate-200 dark:border-white/10">
                  <tr>
                    <td className="px-4 py-4 text-xs tracking-wider uppercase text-slate-500 dark:text-slate-400">Averages</td>
                    <td className="px-4 py-4 text-right">{summary.avgInternal}</td>
                    <td className="px-4 py-4 text-right">{summary.avgExternal}</td>
                    <td className="px-4 py-4 text-right">{summary.avgTotal}</td>
                    <td className="px-4 py-4 text-center">
                      <span className={cn("inline-flex items-center justify-center rounded-full px-2.5 py-0.5 text-xs font-bold uppercase tracking-wide", getGradeStyle(summary.commonGrade))}>
                        {summary.commonGrade}
                      </span>
                    </td>
                  </tr>
                </tfoot>
              )}
            </table>
          </div>

        </div>
      </Card>
    </motion.div>
  )
}
