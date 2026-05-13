import { useMemo } from 'react'
import { motion } from 'framer-motion'
import { Activity, TrendingUp, Award, CheckCircle2, AlertCircle } from 'lucide-react'
import { cn } from '../../lib/utils'
import type { AttendanceSummary, GradeSummary } from '../../types/app.types'
import { Skeleton } from '../ui/Skeleton'

interface PerformanceOverviewProps {
  attendance: AttendanceSummary[] | undefined
  grades: GradeSummary[] | undefined
  isLoading: boolean
}

export default function PerformanceOverview({ attendance, grades, isLoading }: PerformanceOverviewProps) {
  const metrics = useMemo(() => {
    if (!attendance || !grades || attendance.length === 0 || grades.length === 0) return null

    // 1. Calculate Average Attendance
    const avgAttendance = attendance.reduce((acc, curr) => acc + curr.percentage, 0) / attendance.length

    // 2. Calculate Average Total Score (0-100)
    const avgScore = grades.reduce((acc, curr) => acc + curr.total, 0) / grades.length

    // 3. Failing Subjects Penalty
    const failingSubjects = grades.filter(g => (g.grade === 'F' || g.total < 40)).length
    const failPenalty = failingSubjects * 10

    // 4. CGPA Calculation (VTU 10-point scale)
    const gradePointMap: Record<string, number> = { 'A': 10, 'B': 8, 'C': 6, 'D': 4, 'F': 0 }
    const totalGradePoints = grades.reduce((sum, g) => sum + (gradePointMap[g.grade] ?? 0), 0)
    const cgpa = grades.length > 0 ? (totalGradePoints / grades.length) : 0

    // 5. Composite Score (Mirroring mentor's leaderboard logic)
    // Weighted: 40% attendance, 60% marks
    const compositeScore = Math.max(0, Math.min(100, (avgAttendance * 0.4) + (avgScore * 0.6) - failPenalty))

    // 6. Determine Performance Label & Color
    let label = 'Needs Improvement'
    let color = 'from-red-500 to-orange-500'
    let textColor = 'text-red-600'
    let bgColor = 'bg-red-50'
    let icon = <AlertCircle className="text-red-500" size={20} />

    if (compositeScore >= 85) {
      label = 'Excellent'
      color = 'from-emerald-500 to-teal-500'
      textColor = 'text-emerald-600'
      bgColor = 'bg-emerald-50'
      icon = <Award className="text-emerald-500" size={20} />
    } else if (compositeScore >= 70) {
      label = 'Good'
      color = 'from-blue-500 to-indigo-500'
      textColor = 'text-blue-600'
      bgColor = 'bg-blue-50'
      icon = <TrendingUp className="text-blue-500" size={20} />
    } else if (compositeScore >= 50) {
      label = 'Average'
      color = 'from-amber-500 to-orange-500'
      textColor = 'text-amber-600'
      bgColor = 'bg-amber-50'
      icon = <Activity className="text-amber-500" size={20} />
    }

    return {
      score: Math.round(compositeScore),
      avgAttendance: Math.round(avgAttendance),
      avgScore: Math.round(avgScore),
      failingSubjects,
      cgpa: cgpa.toFixed(2),
      label,
      color,
      textColor,
      bgColor,
      icon
    }
  }, [attendance, grades])

  if (isLoading) {
    return (
      <div className="rounded-2xl bg-white p-6 shadow-sm border border-slate-100">
        <Skeleton className="h-4 w-32 mb-4" />
        <Skeleton className="h-12 w-full rounded-xl mb-6" />
        <div className="grid grid-cols-3 gap-4">
          <Skeleton className="h-16 rounded-xl" />
          <Skeleton className="h-16 rounded-xl" />
          <Skeleton className="h-16 rounded-xl" />
        </div>
      </div>
    )
  }

  if (!metrics) return null

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      className="rounded-3xl bg-white p-6 shadow-md border border-slate-100 overflow-hidden relative"
    >
      {/* Background Glow */}
      <div className={cn("absolute -right-20 -top-20 h-64 w-64 rounded-full blur-[80px] opacity-10", metrics.color)} />
      
      <div className="flex flex-col gap-6 relative z-10">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className={cn("flex h-10 w-10 items-center justify-center rounded-xl shadow-sm", metrics.bgColor)}>
              {metrics.icon}
            </div>
            <div>
              <h2 className="text-sm font-bold uppercase tracking-wider text-slate-400">Your Performance</h2>
              <p className={cn("text-lg font-extrabold", metrics.textColor)}>{metrics.label}</p>
            </div>
          </div>
          <div className="text-right">
            <span className="text-4xl font-black text-slate-900">{metrics.score}</span>
            <span className="text-sm font-bold text-slate-400 ml-1">/ 100</span>
          </div>
        </div>

        {/* The Performance Bar */}
        <div className="space-y-3">
          <div className="h-4 w-full rounded-full bg-slate-50 border border-slate-100 p-0.5 overflow-hidden shadow-inner">
            <motion.div
              initial={{ width: 0 }}
              animate={{ width: `${metrics.score}%` }}
              transition={{ duration: 1, ease: 'circOut' }}
              className={cn("h-full rounded-full shadow-lg", metrics.color)}
            />
          </div>
          <div className="flex justify-between px-1">
            <span className="text-[10px] font-bold text-slate-400 uppercase">Beginner</span>
            <span className="text-[10px] font-bold text-slate-400 uppercase">Competent</span>
            <span className="text-[10px] font-bold text-slate-400 uppercase">Expert</span>
          </div>
        </div>

        {/* Key Metrics Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
          <div className="rounded-2xl bg-gradient-to-br from-indigo-50 to-purple-50 p-4 border border-indigo-100 transition-all hover:border-indigo-200 hover:shadow-sm">
            <p className="text-[10px] font-bold text-indigo-400 uppercase mb-1">CGPA</p>
            <div className="flex items-end justify-between">
              <span className="text-2xl font-black text-indigo-700">{metrics.cgpa}</span>
              <span className="text-[10px] font-bold text-indigo-400 bg-indigo-100 px-2 py-0.5 rounded-full">/ 10.0</span>
            </div>
          </div>

          <div className="rounded-2xl bg-slate-50 p-4 border border-slate-100 transition-all hover:border-brand-200">
            <p className="text-[10px] font-bold text-slate-400 uppercase mb-1">Attendance</p>
            <div className="flex items-end justify-between">
              <span className="text-xl font-bold text-slate-800">{metrics.avgAttendance}%</span>
              <div className={cn("flex items-center gap-1 text-[10px] font-bold px-2 py-0.5 rounded-full", 
                metrics.avgAttendance >= 75 ? "bg-emerald-100 text-emerald-700" : "bg-red-100 text-red-700")}>
                {metrics.avgAttendance >= 75 ? <CheckCircle2 size={10} /> : <AlertCircle size={10} />}
                {metrics.avgAttendance >= 75 ? 'Healthy' : 'Critical'}
              </div>
            </div>
          </div>

          <div className="rounded-2xl bg-slate-50 p-4 border border-slate-100 transition-all hover:border-brand-200">
            <p className="text-[10px] font-bold text-slate-400 uppercase mb-1">Avg Marks</p>
            <div className="flex items-end justify-between">
              <span className="text-xl font-bold text-slate-800">{metrics.avgScore}/100</span>
              <span className="text-[10px] font-bold text-slate-500 bg-slate-200 px-2 py-0.5 rounded-full">Academic</span>
            </div>
          </div>

          <div className="rounded-2xl bg-slate-50 p-4 border border-slate-100 transition-all hover:border-brand-200">
            <p className="text-[10px] font-bold text-slate-400 uppercase mb-1">Failures</p>
            <div className="flex items-end justify-between">
              <span className="text-xl font-bold text-slate-800">{metrics.failingSubjects}</span>
              <div className={cn("flex items-center gap-1 text-[10px] font-bold px-2 py-0.5 rounded-full", 
                metrics.failingSubjects === 0 ? "bg-emerald-100 text-emerald-700" : "bg-red-100 text-red-700")}>
                {metrics.failingSubjects === 0 ? 'None' : `${metrics.failingSubjects} Backlogs`}
              </div>
            </div>
          </div>
        </div>
      </div>
    </motion.div>
  )
}
