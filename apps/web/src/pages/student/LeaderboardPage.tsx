import { useMemo, useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { useQuery } from '@tanstack/react-query'
import { Trophy, Crown, Medal, Flame, Zap, Star, TrendingUp, ChevronDown, ChevronUp, Target, Award, Sparkles, Shield, ClipboardList, BarChart3 } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import { useAuth } from '../../hooks/useAuth'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'
import { Skeleton } from '../../components/ui/Skeleton'
import Sparkline from '../../components/ui/Sparkline'
import BarChart from '../../components/ui/BarChart'

// ─── Types ───
interface LeaderboardEntry {
  student_id: string
  full_name: string
  branch: string
  semester: number
  avg_attendance: number | null
  avg_total_score: number | null
  failing_subjects: number
  risk_level: string | null
}

interface IATEntry {
  student_id: string
  avg_iat_marks: number | null
  iat_count: number
}

interface TrendData {
  student_id: string
  attendance_weekly: { week_start: string; pct: number }[]
  iat_scores: { iat_num: number; avg_marks: number; max_marks: number }[]
  subject_scores: { name: string; score: number }[]
}

interface RankedEntry extends LeaderboardEntry {
  xp: number
  level: number
  levelTitle: string
  levelColor: string
  sgpa: number
  attendanceScore: number
  marksScore: number
  iatScore: number
  avgIAT: number
  rank: number
  isYou: boolean
}

// ─── Gamification Logic ───
const LEVEL_THRESHOLDS = [
  { min: 0, title: 'Rookie', color: 'text-slate-500', bg: 'bg-slate-100', border: 'border-slate-200', emoji: '🌱' },
  { min: 250, title: 'Scholar', color: 'text-blue-600', bg: 'bg-blue-50', border: 'border-blue-200', emoji: '📚' },
  { min: 500, title: 'Achiever', color: 'text-emerald-600', bg: 'bg-emerald-50', border: 'border-emerald-200', emoji: '⭐' },
  { min: 750, title: 'Champion', color: 'text-purple-600', bg: 'bg-purple-50', border: 'border-purple-200', emoji: '🏆' },
  { min: 1000, title: 'Legend', color: 'text-amber-600', bg: 'bg-amber-50', border: 'border-amber-200', emoji: '👑' },
]

function getLevel(xp: number) {
  let level = LEVEL_THRESHOLDS[0]
  for (const l of LEVEL_THRESHOLDS) {
    if (xp >= l.min) level = l
  }
  return level
}

function computeXP(
  s: LeaderboardEntry,
  avgIAT: number
): { xp: number; sgpa: number; attendanceScore: number; marksScore: number; iatScore: number } {
  const att = s.avg_attendance ?? 0
  const score = s.avg_total_score ?? 0
  const fails = s.failing_subjects

  // Attendance XP: max 300
  const attendanceScore = Math.round((att / 100) * 300)
  // Marks XP: max 350
  const marksScore = Math.round((score / 100) * 350)
  // IAT Marks XP: max 250 (avg IAT out of 50)
  const iatScore = Math.round((avgIAT / 50) * 250)
  // Fail penalty: -50 per fail
  const failPenalty = fails * 50
  // Bonus: Perfect attendance
  const perfectBonus = att >= 95 ? 50 : att >= 85 ? 25 : 0
  // Bonus: High scorer
  const scorerBonus = score >= 90 ? 50 : score >= 80 ? 25 : 0
  // Bonus: IAT topper
  const iatBonus = avgIAT >= 45 ? 50 : avgIAT >= 40 ? 25 : 0

  const xp = Math.max(0, attendanceScore + marksScore + iatScore - failPenalty + perfectBonus + scorerBonus + iatBonus)

  // SGPA from score (VTU style)
  let sgpa = 0
  if (score >= 85) sgpa = 10
  else if (score >= 70) sgpa = 8
  else if (score >= 55) sgpa = 6
  else if (score >= 40) sgpa = 4
  else sgpa = 0

  return { xp, sgpa, attendanceScore, marksScore, iatScore }
}

// ─── Components ───
function XPBar({ current, max, color }: { current: number; max: number; color: string }) {
  const pct = Math.min(100, (current / max) * 100)
  return (
    <div className="h-2.5 w-full rounded-full bg-slate-100 overflow-hidden shadow-inner">
      <motion.div
        initial={{ width: 0 }}
        animate={{ width: `${pct}%` }}
        transition={{ duration: 0.8, ease: 'circOut' }}
        className={cn('h-full rounded-full', color)}
      />
    </div>
  )
}

function StatChip({ icon, label, value, color }: { icon: React.ReactNode; label: string; value: string; color: string }) {
  return (
    <div className={cn('flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-bold', color)}>
      {icon}
      <span>{label}:</span>
      <span>{value}</span>
    </div>
  )
}

export default function LeaderboardPage() {
  const { user, profile } = useAuth()
  const [expandedView, setExpandedView] = useState(false)
  const [expandedStudent, setExpandedStudent] = useState<string | null>(null)
  const [activeFilter, setActiveFilter] = useState<'xp' | 'attendance' | 'iat' | 'sgpa'>('xp')

  // Fetch cohort data via the student's mentor_id
  const { data: cohortData, isLoading: cohortLoading } = useQuery({
    queryKey: ['student-leaderboard', profile?.mentor_id],
    queryFn: async () => {
      if (!profile?.mentor_id) throw new Error('No mentor assigned')
      const { data, error } = await supabase.rpc('get_mentor_cohort_summary', {
        p_mentor_id: profile.mentor_id
      })
      if (error) throw error
      return data as LeaderboardEntry[]
    },
    enabled: !!profile?.mentor_id,
  })

  // Fetch IAT marks averages for the cohort
  const { data: iatData, isLoading: iatLoading } = useQuery({
    queryKey: ['student-leaderboard-iat', profile?.mentor_id],
    queryFn: async () => {
      if (!profile?.mentor_id) throw new Error('No mentor assigned')
      const { data, error } = await supabase.rpc('get_cohort_iat_averages', {
        p_mentor_id: profile.mentor_id
      })
      if (error) {
        console.warn('[Leaderboard] IAT fetch failed (function may not exist yet):', error.message)
        return [] as IATEntry[]
      }
      return data as IATEntry[]
    },
    enabled: !!profile?.mentor_id,
  })

  // Fetch trend data for sparklines
  const { data: trendData } = useQuery({
    queryKey: ['student-leaderboard-trends', profile?.mentor_id],
    queryFn: async () => {
      if (!profile?.mentor_id) throw new Error('No mentor assigned')
      const { data, error } = await supabase.rpc('get_cohort_trends', {
        p_mentor_id: profile.mentor_id
      })
      if (error) {
        console.warn('[Leaderboard] Trends fetch failed:', error.message)
        return [] as TrendData[]
      }
      return (data ?? []) as TrendData[]
    },
    enabled: !!profile?.mentor_id,
  })

  // Build trend lookup map
  const trendMap = useMemo(() => {
    const map = new Map<string, TrendData>()
    if (trendData) {
      for (const t of trendData) map.set(t.student_id, t)
    }
    return map
  }, [trendData])

  const isLoading = cohortLoading || iatLoading

  // Build IAT lookup map
  const iatMap = useMemo(() => {
    const map = new Map<string, number>()
    if (iatData) {
      for (const entry of iatData) {
        map.set(entry.student_id, Number(entry.avg_iat_marks) || 0)
      }
    }
    return map
  }, [iatData])

  // Rank and gamify
  const rankedStudents = useMemo(() => {
    if (!cohortData) return []

    const withXP: RankedEntry[] = cohortData.map(s => {
      const avgIAT = iatMap.get(s.student_id) ?? 0
      const { xp, sgpa, attendanceScore, marksScore, iatScore } = computeXP(s, avgIAT)
      const level = getLevel(xp)
      return {
        ...s,
        xp,
        sgpa,
        attendanceScore,
        marksScore,
        iatScore,
        avgIAT,
        level: LEVEL_THRESHOLDS.indexOf(level),
        levelTitle: level.title,
        levelColor: level.color,
        rank: 0,
        isYou: s.student_id === user?.id,
      }
    })

    // Sort by selected filter
    withXP.sort((a, b) => {
      if (activeFilter === 'xp') return b.xp - a.xp
      if (activeFilter === 'attendance') return (b.avg_attendance ?? 0) - (a.avg_attendance ?? 0)
      if (activeFilter === 'iat') return b.avgIAT - a.avgIAT
      return b.sgpa - a.sgpa
    })

    withXP.forEach((s, i) => { s.rank = i + 1 })
    return withXP
  }, [cohortData, iatMap, user?.id, activeFilter])

  const myRank = rankedStudents.find(s => s.isYou)
  const topThree = rankedStudents.slice(0, 3)
  const restStudents = expandedView ? rankedStudents.slice(3) : rankedStudents.slice(3, 13)
  const hasMore = rankedStudents.length > 13

  const podiumOrder = topThree.length >= 3 ? [topThree[1], topThree[0], topThree[2]] : topThree

  return (
    <AppShell role="student">
      <div className="flex flex-col gap-6 max-w-3xl mx-auto w-full pb-10">
        {/* ─── Header ─── */}
        <div className="text-center">
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-amber-100 to-orange-100 px-4 py-1.5 text-sm font-bold text-amber-700 mb-3 border border-amber-200/50"
          >
            <Trophy size={16} /> Class Leaderboard
          </motion.div>
          <h1 className="text-2xl sm:text-3xl font-black tracking-tight text-slate-900">
            Who's on 🔥 this semester?
          </h1>
          <p className="text-sm text-slate-500 mt-1 font-medium">
            Earn XP from attendance, IAT marks & SGPA. Climb the ranks!
          </p>
        </div>

        {/* ─── Your Rank Card ─── */}
        {myRank && (
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.1 }}
            className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-500 p-5 text-white shadow-lg shadow-indigo-500/20"
          >
            <div className="absolute -right-8 -top-8 h-32 w-32 rounded-full bg-white/10 blur-2xl" />
            <div className="absolute -left-8 -bottom-8 h-28 w-28 rounded-full bg-white/5 blur-xl" />
            <div className="relative z-10 flex items-center justify-between">
              <div className="flex items-center gap-4">
                <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-white/20 backdrop-blur-sm text-2xl font-black">
                  #{myRank.rank}
                </div>
                <div>
                  <p className="text-xs font-bold text-white/70 uppercase tracking-wider">Your Rank</p>
                  <p className="text-lg font-extrabold">{myRank.full_name}</p>
                  <div className="flex items-center gap-2 mt-0.5">
                    <span className="text-sm font-bold text-white/80">
                      {getLevel(myRank.xp).emoji} {myRank.levelTitle}
                    </span>
                    <span className="text-xs bg-white/20 px-2 py-0.5 rounded-full font-bold">
                      {myRank.xp} XP
                    </span>
                  </div>
                </div>
              </div>
              <div className="text-right hidden sm:block">
                <div className="flex items-center gap-3 text-xs font-bold text-white/70">
                  <span>SGPA: {myRank.sgpa}</span>
                  <span>IAT: {myRank.avgIAT}/50</span>
                  <span>Att: {myRank.avg_attendance ?? 0}%</span>
                </div>
                <div className="mt-2 w-44">
                  <XPBar current={myRank.xp} max={1200} color="bg-white/40" />
                  <p className="text-[10px] text-white/50 mt-1 text-right">{myRank.xp}/1200 XP</p>
                </div>
              </div>
            </div>
          </motion.div>
        )}

        {/* ─── Filter Tabs ─── */}
        <div className="flex items-center justify-center gap-2 flex-wrap">
          {[
            { key: 'xp' as const, label: 'Total XP', icon: <Zap size={14} /> },
            { key: 'attendance' as const, label: 'Attendance', icon: <Target size={14} /> },
            { key: 'iat' as const, label: 'IAT Marks', icon: <ClipboardList size={14} /> },
            { key: 'sgpa' as const, label: 'SGPA', icon: <Award size={14} /> },
          ].map(tab => (
            <button
              key={tab.key}
              onClick={() => setActiveFilter(tab.key)}
              className={cn(
                'flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-bold transition-all',
                activeFilter === tab.key
                  ? 'bg-indigo-600 text-white shadow-sm shadow-indigo-500/30'
                  : 'bg-white text-slate-600 border border-slate-200 hover:border-indigo-200 hover:bg-indigo-50'
              )}
            >
              {tab.icon} {tab.label}
            </button>
          ))}
        </div>

        {/* ─── Podium ─── */}
        {isLoading ? (
          <div className="grid grid-cols-3 gap-3 px-4">
            {[1, 2, 3].map(i => (
              <Skeleton key={i} className="h-48 rounded-2xl" />
            ))}
          </div>
        ) : topThree.length >= 3 ? (
          <div className="flex items-end justify-center gap-2 sm:gap-4 px-4 pt-4">
            {podiumOrder.map((student, idx) => {
              const isFirst = idx === 1
              const podiumHeight = isFirst ? 'h-44' : idx === 0 ? 'h-36' : 'h-32'
              const podiumColor = isFirst
                ? 'from-amber-400 to-amber-500'
                : idx === 0
                  ? 'from-slate-300 to-slate-400'
                  : 'from-orange-300 to-orange-400'
              const medal = isFirst ? '🥇' : idx === 0 ? '🥈' : '🥉'
              const rankNum = isFirst ? 1 : idx === 0 ? 2 : 3

              return (
                <motion.div
                  key={student.student_id}
                  initial={{ y: 30, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  transition={{ delay: idx * 0.15 }}
                  className={cn('flex flex-col items-center', isFirst ? 'order-2' : idx === 0 ? 'order-1' : 'order-3')}
                >
                  {/* Avatar */}
                  <div className={cn(
                    'relative flex items-center justify-center rounded-2xl bg-gradient-to-br text-white font-black text-xl shadow-lg mb-2',
                    isFirst ? 'h-16 w-16 shadow-amber-300/40' : 'h-12 w-12',
                    podiumColor
                  )}>
                    {student.full_name.charAt(0)}
                    <span className="absolute -bottom-1 -right-1 text-lg">{medal}</span>
                    {student.isYou && (
                      <span className="absolute -top-1 -left-1 text-[10px] bg-indigo-600 text-white px-1.5 py-0.5 rounded-full font-bold">YOU</span>
                    )}
                  </div>

                  <p className={cn('text-xs font-bold text-slate-800 text-center max-w-[90px] truncate', isFirst && 'text-sm')}>
                    {student.full_name.split(' ')[0]}
                  </p>
                  <div className="flex flex-col items-center gap-0.5 mt-0.5">
                    <p className="text-[10px] font-bold text-indigo-600">{student.xp} XP</p>
                    {student.avgIAT > 0 && (
                      <p className="text-[9px] font-semibold text-orange-500">IAT: {student.avgIAT}/50</p>
                    )}
                  </div>

                  {/* Podium Bar */}
                  <div className={cn(
                    'w-20 sm:w-24 rounded-t-xl bg-gradient-to-b mt-2 flex items-start justify-center pt-3',
                    podiumHeight, podiumColor
                  )}>
                    <span className="text-2xl font-black text-white/80">#{rankNum}</span>
                  </div>
                </motion.div>
              )
            })}
          </div>
        ) : null}

        {/* ─── Overall Comparison Bar Charts ─── */}
        {!isLoading && rankedStudents.length > 1 && (
          <div className="flex flex-col gap-4">
            {/* Attendance Comparison — show when filter is 'attendance' or 'xp' */}
            {(activeFilter === 'attendance' || activeFilter === 'xp') && (
              <motion.div
                key="chart-att"
                initial={{ opacity: 0, y: 12 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.15 }}
                className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden"
              >
                <div className="px-5 py-3 border-b border-slate-100 bg-emerald-50/40 flex items-center gap-2">
                  <Target size={16} className="text-emerald-600" />
                  <h3 className="text-sm font-bold text-slate-700">Attendance Comparison</h3>
                  <span className="text-[10px] text-slate-400 font-medium ml-auto">{rankedStudents.length} students</span>
                </div>
                <div className="p-4">
                  <BarChart
                    data={rankedStudents.map(s => ({ label: s.full_name, value: Math.round(s.avg_attendance ?? 0), isYou: s.isYou }))}
                    max={100}
                    unit="%"
                    threshold={75}
                    thresholdLabel="75%"
                    barColor="#10b981"
                    dangerColor="#ef4444"
                  />
                </div>
              </motion.div>
            )}

            {/* IAT Marks Comparison — show when filter is 'iat' or 'xp' */}
            {(activeFilter === 'iat' || activeFilter === 'xp') && (
              <motion.div
                key="chart-iat"
                initial={{ opacity: 0, y: 12 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.25 }}
                className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden"
              >
                <div className="px-5 py-3 border-b border-slate-100 bg-orange-50/40 flex items-center gap-2">
                  <ClipboardList size={16} className="text-orange-600" />
                  <h3 className="text-sm font-bold text-slate-700">IAT Marks Comparison</h3>
                  <span className="text-[10px] text-slate-400 font-medium ml-auto">avg out of 50</span>
                </div>
                <div className="p-4">
                  <BarChart
                    data={rankedStudents.map(s => ({ label: s.full_name, value: Math.round(s.avgIAT), isYou: s.isYou }))}
                    max={50}
                    unit=""
                    threshold={20}
                    thresholdLabel="20"
                    barColor="#f97316"
                    dangerColor="#ef4444"
                  />
                </div>
              </motion.div>
            )}

            {/* SGPA Comparison — show when filter is 'sgpa' or 'xp' */}
            {(activeFilter === 'sgpa' || activeFilter === 'xp') && (
              <motion.div
                key="chart-sgpa"
                initial={{ opacity: 0, y: 12 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.35 }}
                className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden"
              >
                <div className="px-5 py-3 border-b border-slate-100 bg-purple-50/40 flex items-center gap-2">
                  <Award size={16} className="text-purple-600" />
                  <h3 className="text-sm font-bold text-slate-700">SGPA Comparison</h3>
                  <span className="text-[10px] text-slate-400 font-medium ml-auto">out of 10</span>
                </div>
                <div className="p-4">
                  <BarChart
                    data={rankedStudents.map(s => ({ label: s.full_name, value: s.sgpa, isYou: s.isYou }))}
                    max={10}
                    unit=""
                    threshold={4}
                    thresholdLabel="4.0"
                    barColor="#8b5cf6"
                    dangerColor="#ef4444"
                  />
                </div>
              </motion.div>
            )}
          </div>
        )}

        {!isLoading && rankedStudents.length > 3 && (
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
            <div className="px-5 py-3 border-b border-slate-100 bg-slate-50/50 flex items-center gap-2">
              <TrendingUp size={16} className="text-slate-400" />
              <h3 className="text-sm font-bold text-slate-700">Full Rankings</h3>
              <span className="text-xs text-slate-400 font-medium ml-auto">{rankedStudents.length} students</span>
            </div>

            <div className="divide-y divide-slate-50">
              {restStudents.map((student, idx) => {
                const lvl = getLevel(student.xp)
                const isExpanded = expandedStudent === student.student_id
                const trend = trendMap.get(student.student_id)
                const attData = (trend?.attendance_weekly ?? []).map(w => w.pct)
                const attLabels = (trend?.attendance_weekly ?? []).map(w => {
                  const d = new Date(w.week_start)
                  return `${d.getDate()}/${d.getMonth() + 1}`
                })
                const iatPoints = (trend?.iat_scores ?? []).map(i => i.avg_marks)
                const iatLabels = (trend?.iat_scores ?? []).map(i => `IAT ${i.iat_num}`)
                const subScores = (trend?.subject_scores ?? []).map(s => s.score)
                const subLabels = (trend?.subject_scores ?? []).map(s => s.name.length > 6 ? s.name.slice(0, 6) : s.name)

                return (
                  <div key={student.student_id}>
                    <motion.div
                      initial={{ opacity: 0, x: -10 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: idx * 0.02 }}
                      onClick={() => setExpandedStudent(isExpanded ? null : student.student_id)}
                      className={cn(
                        'flex items-center gap-3 px-5 py-3.5 transition-colors cursor-pointer',
                        student.isYou ? 'bg-indigo-50/60 border-l-2 border-indigo-500' : 'hover:bg-slate-50/60',
                        isExpanded && 'bg-slate-50'
                      )}
                    >
                      {/* Rank */}
                      <span className={cn(
                        'text-sm font-black w-8 text-center',
                        student.rank <= 5 ? 'text-amber-500' : 'text-slate-400'
                      )}>
                        #{student.rank}
                      </span>

                      {/* Avatar */}
                      <div className={cn(
                        'flex h-9 w-9 shrink-0 items-center justify-center rounded-xl text-sm font-bold',
                        lvl.bg, lvl.border, 'border'
                      )}>
                        {student.full_name.charAt(0)}
                      </div>

                      {/* Name + Level */}
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2">
                          <span className="text-sm font-bold text-slate-800 truncate">{student.full_name}</span>
                          {student.isYou && (
                            <span className="text-[9px] bg-indigo-100 text-indigo-700 px-1.5 py-0.5 rounded-full font-bold">YOU</span>
                          )}
                        </div>
                        <div className="flex items-center gap-2 mt-0.5">
                          <span className={cn('text-[10px] font-bold', lvl.color)}>{lvl.emoji} {lvl.title}</span>
                          <span className="text-[10px] text-slate-400">Sem {student.semester}</span>
                        </div>
                      </div>

                      {/* Stats */}
                      <div className="hidden sm:flex items-center gap-1.5 flex-wrap justify-end">
                        <StatChip icon={<Target size={10} />} label="Att" value={`${student.avg_attendance ?? 0}%`} color="bg-emerald-50 text-emerald-700" />
                        <StatChip icon={<ClipboardList size={10} />} label="IAT" value={`${student.avgIAT}/50`} color="bg-orange-50 text-orange-700" />
                        <StatChip icon={<Star size={10} />} label="SGPA" value={`${student.sgpa}`} color="bg-purple-50 text-purple-700" />
                      </div>

                      {/* XP + expand toggle */}
                      <div className="flex items-center gap-2 shrink-0">
                        <div className="flex flex-col items-end">
                          <span className="text-sm font-black text-slate-800">{student.xp}</span>
                          <span className="text-[9px] font-bold text-slate-400">XP</span>
                        </div>
                        <BarChart3 size={14} className={cn('transition-colors', isExpanded ? 'text-indigo-500' : 'text-slate-300')} />
                      </div>
                    </motion.div>

                    {/* ─── Expandable Trend Charts ─── */}
                    <AnimatePresence>
                      {isExpanded && (
                        <motion.div
                          initial={{ height: 0, opacity: 0 }}
                          animate={{ height: 'auto', opacity: 1 }}
                          exit={{ height: 0, opacity: 0 }}
                          transition={{ duration: 0.25 }}
                          className="overflow-hidden"
                        >
                          <div className="px-5 pb-4 pt-1 grid grid-cols-1 sm:grid-cols-3 gap-3">
                            {/* Attendance Trend */}
                            <div className="rounded-xl border border-emerald-100 bg-emerald-50/40 p-3">
                              <p className="text-[10px] font-bold text-emerald-700 uppercase tracking-wider mb-2 flex items-center gap-1">
                                <Target size={12} /> Attendance Trend
                              </p>
                              <Sparkline
                                data={attData}
                                labels={attLabels}
                                max={100}
                                min={0}
                                color="#10b981"
                                height={50}
                                width={180}
                              />
                              {attData.length === 0 && <p className="text-[10px] text-slate-400">No weekly data</p>}
                            </div>

                            {/* IAT Marks Trend */}
                            <div className="rounded-xl border border-orange-100 bg-orange-50/40 p-3">
                              <p className="text-[10px] font-bold text-orange-700 uppercase tracking-wider mb-2 flex items-center gap-1">
                                <ClipboardList size={12} /> IAT Marks
                              </p>
                              <Sparkline
                                data={iatPoints}
                                labels={iatLabels}
                                max={50}
                                min={0}
                                color="#f97316"
                                height={50}
                                width={180}
                              />
                              {iatPoints.length === 0 && <p className="text-[10px] text-slate-400">No IAT data</p>}
                            </div>

                            {/* Subject Scores / CGPA */}
                            <div className="rounded-xl border border-purple-100 bg-purple-50/40 p-3">
                              <p className="text-[10px] font-bold text-purple-700 uppercase tracking-wider mb-2 flex items-center gap-1">
                                <Star size={12} /> Subject Scores
                              </p>
                              <Sparkline
                                data={subScores}
                                labels={subLabels}
                                max={100}
                                min={0}
                                color="#8b5cf6"
                                height={50}
                                width={180}
                              />
                              {subScores.length === 0 && <p className="text-[10px] text-slate-400">No grades data</p>}
                            </div>
                          </div>
                        </motion.div>
                      )}
                    </AnimatePresence>
                  </div>
                )
              })}
            </div>

            {/* Show More / Less */}
            {hasMore && (
              <div className="px-5 py-3 border-t border-slate-100 text-center">
                <button
                  onClick={() => setExpandedView(!expandedView)}
                  className="flex items-center justify-center gap-1.5 mx-auto text-xs font-bold text-indigo-600 hover:text-indigo-700 transition-colors"
                >
                  {expandedView ? (
                    <><ChevronUp size={14} /> Show less</>
                  ) : (
                    <><ChevronDown size={14} /> Show all {rankedStudents.length - 3} students</>
                  )}
                </button>
              </div>
            )}
          </div>
        )}

        {/* ─── XP Breakdown Legend ─── */}
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="rounded-2xl border border-slate-200 bg-gradient-to-br from-slate-50 to-white p-5"
        >
          <h3 className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-slate-500 mb-3">
            <Sparkles size={14} /> How XP is Calculated
          </h3>
          <div className="grid grid-cols-2 sm:grid-cols-5 gap-3 text-xs">
            <div className="flex items-center gap-2 bg-white rounded-xl p-3 border border-slate-100">
              <Target size={16} className="text-emerald-500 shrink-0" />
              <div>
                <p className="font-bold text-slate-700">Attendance</p>
                <p className="text-slate-400">Up to 300 XP</p>
              </div>
            </div>
            <div className="flex items-center gap-2 bg-white rounded-xl p-3 border border-slate-100">
              <Star size={16} className="text-blue-500 shrink-0" />
              <div>
                <p className="font-bold text-slate-700">Marks / SGPA</p>
                <p className="text-slate-400">Up to 350 XP</p>
              </div>
            </div>
            <div className="flex items-center gap-2 bg-white rounded-xl p-3 border border-orange-100 bg-orange-50/30">
              <ClipboardList size={16} className="text-orange-500 shrink-0" />
              <div>
                <p className="font-bold text-slate-700">IAT Marks</p>
                <p className="text-slate-400">Up to 250 XP</p>
              </div>
            </div>
            <div className="flex items-center gap-2 bg-white rounded-xl p-3 border border-slate-100">
              <Flame size={16} className="text-amber-500 shrink-0" />
              <div>
                <p className="font-bold text-slate-700">Bonuses</p>
                <p className="text-slate-400">Up to 150 XP</p>
              </div>
            </div>
            <div className="flex items-center gap-2 bg-white rounded-xl p-3 border border-slate-100">
              <Shield size={16} className="text-red-500 shrink-0" />
              <div>
                <p className="font-bold text-slate-700">Fails Penalty</p>
                <p className="text-slate-400">-50 XP each</p>
              </div>
            </div>
          </div>
        </motion.div>

        {/* ─── Empty / No Mentor ─── */}
        {!isLoading && !profile?.mentor_id && (
          <div className="text-center py-12">
            <Trophy size={48} className="mx-auto text-slate-300 mb-3" />
            <p className="text-slate-600 font-semibold">No mentor assigned yet</p>
            <p className="text-sm text-slate-400 mt-1">Ask your mentor to add you to their cohort to see the leaderboard.</p>
          </div>
        )}

        {!isLoading && profile?.mentor_id && rankedStudents.length === 0 && (
          <div className="text-center py-12">
            <Trophy size={48} className="mx-auto text-slate-300 mb-3" />
            <p className="text-slate-600 font-semibold">No classmates found</p>
            <p className="text-sm text-slate-400 mt-1">The leaderboard will populate once your mentor adds more students.</p>
          </div>
        )}
      </div>
    </AppShell>
  )
}
