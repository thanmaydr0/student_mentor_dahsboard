import { useState, useMemo, useRef, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import { 
  Search, Eye, ClipboardCheck, MessageSquare, 
  AlertTriangle, Users, GraduationCap, BookOpen, 
  ArrowUpDown, ArrowDown, ArrowUp, UserX, Sparkles, X, FileText
} from 'lucide-react'
import { useAuth } from '../../hooks/useAuth'
import AppShell from '../../components/layout/AppShell'
import { useCohortSummary } from '../../hooks/mentor/useCohortSummary'
import { Skeleton } from '../../components/ui/Skeleton'
import { cn } from '../../lib/utils'
import CohortChatPanel from '../../components/mentor/CohortChatPanel'
import MenteeLeaderboard from '../../components/mentor/MenteeLeaderboard'
import MessageComposer from '../../components/mentor/MessageComposer'
import ThemeToggle from '../../components/ui/ThemeToggle'

// Risk Level specific Badge mapping
function RiskBadge({ level }: { level: string | null }) {
  const normalizedLevel = level || 'Low'
  if (normalizedLevel === 'High') {
    return <span className="inline-flex items-center gap-1 rounded-full bg-red-100 dark:bg-red-950/40 px-2 py-1 text-xs font-semibold text-red-700 dark:text-red-400 border border-red-200 dark:border-red-900/50"><AlertTriangle size={12} /> High Risk</span>
  }
  if (normalizedLevel === 'Medium') {
    return <span className="inline-flex items-center gap-1 rounded-full bg-amber-100 dark:bg-amber-950/40 px-2 py-1 text-xs font-semibold text-amber-700 dark:text-amber-400 border border-amber-200 dark:border-amber-900/50">Medium</span>
  }
  return <span className="inline-flex items-center gap-1 rounded-full bg-emerald-100 dark:bg-emerald-950/40 px-2 py-1 text-xs font-semibold text-emerald-700 dark:text-emerald-400 border border-emerald-200 dark:border-emerald-900/50">Low</span>
}

type SortField = 'full_name' | 'branch' | 'semester' | 'avg_attendance' | 'avg_total_score' | 'cgpa' | 'failing_subjects' | 'risk_level'
type SortOrder = 'asc' | 'desc'
const riskWeight: Record<string, number> = { High: 3, Medium: 2, Low: 1 }

// VTU 10-point CGPA from avg score (0-100)
function scoreToCGPA(avgScore: number | null | undefined): string {
  if (avgScore == null) return '-'
  if (avgScore >= 85) return '10.00'
  if (avgScore >= 70) return '8.00'
  if (avgScore >= 55) return '6.00'
  if (avgScore >= 40) return '4.00'
  return '0.00'
}
function scoreToCGPANum(avgScore: number | null | undefined): number {
  if (avgScore == null) return 0
  if (avgScore >= 85) return 10
  if (avgScore >= 70) return 8
  if (avgScore >= 55) return 6
  if (avgScore >= 40) return 4
  return 0
}

export default function MentorDashboard() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const { data: cohortData, isLoading } = useCohortSummary(user?.id)

  const [searchQuery, setSearchQuery] = useState('')
  const [selectedSemesters, setSelectedSemesters] = useState<number[]>([])
  const [activeTab, setActiveTab] = useState<'All' | 'High Risk' | 'Medium Risk' | 'Low Risk'>('All')
  
  const [sortField, setSortField] = useState<SortField>('risk_level')
  const [sortOrder, setSortOrder] = useState<SortOrder>('desc') // High risk first

  const [isChatOpen, setIsChatOpen] = useState(false)
  const aiButtonRef = useRef<HTMLButtonElement>(null)

  const [selectedStudents, setSelectedStudents] = useState<Set<string>>(new Set())
  const [showMessageComposer, setShowMessageComposer] = useState(false)

  // One time pulse animation
  useEffect(() => {
    const btn = aiButtonRef.current
    if (btn) {
      btn.animate([
        { transform: 'scale(1)', boxShadow: '0 0 0 0 rgba(79, 70, 229, 0.7)' },
        { transform: 'scale(1.05)', boxShadow: '0 0 0 10px rgba(79, 70, 229, 0)' },
        { transform: 'scale(1)', boxShadow: '0 0 0 0 rgba(79, 70, 229, 0)' }
      ], { duration: 1500, easing: 'ease-out', delay: 500 })
    }
  }, [])

  // Unique semesters available in cohort
  const availableSemesters = useMemo(() => {
    if (!cohortData) return []
    const sems = new Set(cohortData.map((s: any) => s.semester))
    return Array.from(sems).sort((a, b) => a - b)
  }, [cohortData])

  const toggleSemester = (sem: number) => {
    setSelectedSemesters(prev => 
      prev.includes(sem) ? prev.filter(s => s !== sem) : [...prev, sem]
    )
  }

  // Handle Sort
  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc')
    } else {
      setSortField(field)
      setSortOrder('desc') // default to desc on new field
    }
  }

  const RenderSortIcon = ({ field }: { field: SortField }) => {
    if (sortField !== field) return <ArrowUpDown size={14} className="text-slate-300 dark:text-slate-600 group-hover:text-slate-400 dark:group-hover:text-slate-500 opacity-0 group-hover:opacity-100 transition-opacity" />
    return sortOrder === 'asc' ? <ArrowUp size={14} className="text-brand-600 dark:text-amber-400" /> : <ArrowDown size={14} className="text-brand-600 dark:text-amber-400" />
  }

  // Filter and sort Data
  const filteredAndSortedData = useMemo(() => {
    if (!cohortData) return []

    let result = cohortData.filter((student: any) => {
      // 1. Search Query
      if (searchQuery && !student.full_name.toLowerCase().includes(searchQuery.toLowerCase())) return false
      // 2. Semesters
      if (selectedSemesters.length > 0 && !selectedSemesters.includes(student.semester)) return false
      // 3. Tab State
      const risk = student.risk_level || 'Low'
      if (activeTab === 'High Risk' && risk !== 'High') return false
      if (activeTab === 'Medium Risk' && risk !== 'Medium') return false
      if (activeTab === 'Low Risk' && risk !== 'Low') return false
      return true
    })

    // Sort
    result = result.sort((a: any, b: any) => {
      let aVal = a[sortField]
      let bVal = b[sortField]

      if (sortField === 'risk_level') {
        aVal = riskWeight[a.risk_level || 'Low'] || 0
        bVal = riskWeight[b.risk_level || 'Low'] || 0
      }

      if (aVal == null) aVal = aVal === null ? -Infinity : aVal
      if (bVal == null) bVal = bVal === null ? -Infinity : bVal

      if (aVal < bVal) return sortOrder === 'asc' ? -1 : 1
      if (aVal > bVal) return sortOrder === 'asc' ? 1 : -1
      return 0
    })

    return result
  }, [cohortData, searchQuery, selectedSemesters, activeTab, sortField, sortOrder])

  // Select Handlers
  const toggleSelectAll = () => {
    if (selectedStudents.size === filteredAndSortedData.length) {
      setSelectedStudents(new Set())
    } else {
      setSelectedStudents(new Set(filteredAndSortedData.map((s: any) => s.student_id)))
    }
  }

  const toggleSelectStudent = (id: string) => {
    const next = new Set(selectedStudents)
    if (next.has(id)) next.delete(id)
    else next.add(id)
    setSelectedStudents(next)
  }

  const handleComposeForSelected = () => {
    setShowMessageComposer(true)
  }

  // Aggregated Stats
  const stats = useMemo(() => {
    if (!cohortData || cohortData.length === 0) return { total: 0, highRisk: 0, avgAtt: 0, avgScore: 0, avgCGPA: '0.00' }
    
    const total = cohortData.length
    const highRisk = cohortData.filter((s: any) => s.risk_level === 'High').length
    
    const validAtts = cohortData.filter((s: any) => s.avg_attendance != null)
    const avgAtt = validAtts.length ? validAtts.reduce((sum: number, s: any) => sum + Number(s.avg_attendance), 0) / validAtts.length : 0
    
    const validScores = cohortData.filter((s: any) => s.avg_total_score != null)
    const avgScore = validScores.length ? validScores.reduce((sum: number, s: any) => sum + Number(s.avg_total_score), 0) / validScores.length : 0

    const avgCGPA = validScores.length 
      ? (validScores.reduce((sum: number, s: any) => sum + scoreToCGPANum(Number(s.avg_total_score)), 0) / validScores.length).toFixed(2)
      : '0.00'

    return { total, highRisk, avgAtt: Math.round(avgAtt), avgScore: Math.round(avgScore), avgCGPA }
  }, [cohortData])

  return (
    <AppShell role="mentor">
      <div className="flex flex-col gap-8 max-w-7xl mx-auto w-full pb-10">
        <div className="flex justify-between items-center gap-4">
          <div></div>
          <div className="flex items-center gap-3">
            <ThemeToggle />
            <button
              onClick={() => navigate('/mentor/results')}
              className="inline-flex items-center gap-2 rounded-xl border border-brand-200 bg-brand-50 dark:border-white/10 dark:bg-white/5 px-4 py-2 text-sm font-semibold text-brand-700 dark:text-slate-300 transition hover:bg-brand-100 dark:hover:bg-white/10"
            >
              <FileText size={16} /> Open Result Fetch
            </button>
          </div>
        </div>
        
        {/* Header Section */}
        <div className="flex flex-col gap-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div>
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Your Cohort</h1>
              <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">Manage and track your assigned students</p>
            </div>
            
            <div className="relative w-full sm:w-72">
              <div className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                <Search size={16} className="text-slate-400" />
              </div>
              <input
                type="text"
                placeholder="Search students..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="block w-full rounded-xl border-slate-200 dark:border-white/5 bg-white dark:bg-[#13151a]/80 py-2.5 pl-10 pr-3 text-sm placeholder:text-slate-400 dark:text-white focus:border-brand-500 dark:focus:border-amber-500 focus:ring-brand-500 dark:focus:ring-amber-500 shadow-sm"
              />
            </div>
          </div>

          {/* Semester Filter Pills */}
          {availableSemesters.length > 0 && (
            <div className="flex items-center gap-2 flex-wrap text-sm">
              <span className="text-slate-500 font-medium mr-2">Filters:</span>
              {availableSemesters.map(sem => (
                <button
                  key={sem}
                  onClick={() => toggleSemester(sem as number)}
                  className={cn(
                    "px-3 py-1 rounded-full font-medium transition-colors border",
                    selectedSemesters.includes(sem as number) 
                      ? "bg-brand-100 dark:bg-amber-400 text-brand-700 dark:text-black border-brand-200 dark:border-amber-500"
                      : "bg-white dark:bg-white/5 text-slate-600 dark:text-slate-300 border-slate-200 dark:border-white/10 hover:bg-slate-50 dark:hover:bg-white/10"
                  )}
                >
                  Sem {sem}
                </button>
              ))}
              {selectedSemesters.length > 0 && (
                <button onClick={() => setSelectedSemesters([])} className="text-xs text-brand-600 hover:text-brand-700 ml-2 font-medium underline-offset-2 hover:underline">
                  Clear
                </button>
              )}
            </div>
          )}
        </div>

        {/* Stats Row */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.0 }} className="bg-white dark:bg-[#13151a]/80 rounded-2xl border border-slate-200 dark:border-white/5 p-5 shadow-sm relative overflow-hidden dark:backdrop-blur-md">
            <div className="flex justify-between items-start">
               <div>
                 <p className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Total Students</p>
                 <p className="text-3xl font-bold text-slate-900 dark:text-white mt-2">{isLoading ? '-' : stats.total}</p>
               </div>
               <div className="p-2 bg-blue-50 dark:bg-blue-950/40 text-blue-600 dark:text-blue-400 rounded-lg"><Users size={20} /></div>
            </div>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="bg-white dark:bg-[#13151a]/80 rounded-2xl border border-slate-200 dark:border-white/5 p-5 shadow-sm relative overflow-hidden dark:backdrop-blur-md">
            <div className="flex justify-between items-start">
               <div>
                 <p className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">High Risk</p>
                 <div className="flex items-center gap-2 mt-2">
                    <p className="text-3xl font-bold text-slate-900 dark:text-white">{isLoading ? '-' : stats.highRisk}</p>
                    {!isLoading && stats.highRisk > 0 && <span className="bg-red-100 dark:bg-red-950/40 text-red-600 dark:text-red-400 text-[10px] font-bold px-1.5 py-0.5 rounded-full flex items-center gap-1"><AlertTriangle size={10} /> Action Req</span>}
                 </div>
               </div>
               <div className="p-2 bg-red-50 dark:bg-red-950/40 text-red-600 dark:text-red-400 rounded-lg"><UserX size={20} /></div>
            </div>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="bg-white dark:bg-[#13151a]/80 rounded-2xl border border-slate-200 dark:border-white/5 p-5 shadow-sm relative overflow-hidden dark:backdrop-blur-md">
            <div className="flex justify-between items-start">
               <div>
                 <p className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Avg Attendance</p>
                 <p className="text-3xl font-bold text-slate-900 dark:text-white mt-2">{isLoading ? '-' : `${stats.avgAtt}%`}</p>
               </div>
               <div className="p-2 bg-emerald-50 dark:bg-emerald-950/40 text-emerald-600 dark:text-emerald-400 rounded-lg"><BookOpen size={20} /></div>
            </div>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }} className="bg-white dark:bg-[#13151a]/80 rounded-2xl border border-slate-200 dark:border-white/5 p-5 shadow-sm relative overflow-hidden dark:backdrop-blur-md">
            <div className="flex justify-between items-start">
               <div>
                 <p className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Avg CGPA</p>
                 <div className="flex items-baseline gap-1 mt-2">
                   <p className="text-3xl font-bold text-slate-900 dark:text-white">{isLoading ? '-' : stats.avgCGPA}</p>
                   <span className="text-xs font-semibold text-slate-400 dark:text-slate-500">/ 10</span>
                 </div>
               </div>
               <div className="p-2 bg-purple-50 dark:bg-purple-950/40 text-purple-600 dark:text-purple-400 rounded-lg"><GraduationCap size={20} /></div>
            </div>
          </motion.div>
        </div>

        {/* Mentee Leaderboard */}
        <MenteeLeaderboard 
          cohortData={cohortData} 
          isLoading={isLoading}
          onStudentClick={(id) => navigate(`/mentor/student/${id}`)}
        />

        {/* Tab Filters */}
        <div className="flex gap-6 border-b border-slate-200 dark:border-white/5 relative">
          {(['All', 'High Risk', 'Medium Risk', 'Low Risk'] as const).map(tab => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={cn(
                "pb-3 text-sm font-semibold transition-colors relative",
                activeTab === tab ? "text-brand-600 dark:text-amber-400" : "text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-slate-200"
              )}
            >
              {tab}
              {activeTab === tab && (
                <motion.div
                  layoutId="activeTabUnderline"
                  className="absolute bottom-[-1px] left-0 right-0 h-0.5 bg-brand-600 dark:bg-amber-400"
                  initial={false}
                  transition={{ type: "spring", stiffness: 300, damping: 30 }}
                />
              )}
            </button>
          ))}
        </div>

        {/* Cohort Table */}
        <div className="bg-white dark:bg-[#13151a]/80 rounded-2xl shadow-sm border border-slate-200 dark:border-white/5 overflow-hidden dark:backdrop-blur-md">
           <div className="overflow-x-auto">
             <table className="w-full text-left text-sm whitespace-nowrap">
               <thead className="bg-slate-50 dark:bg-white/5 border-b border-slate-200 dark:border-white/5 text-xs uppercase font-semibold text-slate-500 dark:text-slate-400 tracking-wider">
                 <tr>
                   <th className="px-6 py-4 w-12">
                     <input 
                       type="checkbox" 
                       className="rounded border-slate-300 dark:border-white/10 dark:bg-black/50 text-brand-600 dark:text-amber-500 focus:ring-brand-500 dark:focus:ring-amber-500 cursor-pointer"
                       checked={filteredAndSortedData.length > 0 && selectedStudents.size === filteredAndSortedData.length}
                       onChange={toggleSelectAll}
                     />
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition" onClick={() => handleSort('full_name')}>
                     <div className="flex items-center gap-2">Name <RenderSortIcon field="full_name" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition hidden sm:table-cell" onClick={() => handleSort('branch')}>
                     <div className="flex items-center gap-2">Branch & Sem <RenderSortIcon field="branch" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition" onClick={() => handleSort('avg_attendance')}>
                     <div className="flex items-center gap-2">Attendance <RenderSortIcon field="avg_attendance" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition hidden md:table-cell" onClick={() => handleSort('avg_total_score')}>
                     <div className="flex items-center gap-2">Avg Score <RenderSortIcon field="avg_total_score" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition" onClick={() => handleSort('avg_total_score')}>
                     <div className="flex items-center gap-2">CGPA <RenderSortIcon field="avg_total_score" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition" onClick={() => handleSort('failing_subjects')}>
                     <div className="flex items-center gap-2">Failing <RenderSortIcon field="failing_subjects" /></div>
                   </th>
                   <th className="px-6 py-4 cursor-pointer group hover:bg-slate-100 dark:hover:bg-white/5 transition" onClick={() => handleSort('risk_level')}>
                     <div className="flex items-center gap-2">Risk Level <RenderSortIcon field="risk_level" /></div>
                   </th>
                   <th className="px-6 py-4 text-right">Actions</th>
                 </tr>
               </thead>
               <tbody className="divide-y divide-slate-100 dark:divide-white/5">
                 {isLoading ? (
                   Array.from({ length: 5 }).map((_, i) => (
                     <tr key={i}>
                       <td className="px-6 py-4"><Skeleton className="h-5 w-32 rounded" /></td>
                       <td className="px-6 py-4 hidden sm:table-cell"><Skeleton className="h-5 w-24 rounded" /></td>
                       <td className="px-6 py-4"><Skeleton className="h-5 w-16 rounded" /></td>
                       <td className="px-6 py-4 hidden md:table-cell"><Skeleton className="h-5 w-12 rounded" /></td>
                       <td className="px-6 py-4"><Skeleton className="h-5 w-12 rounded" /></td>
                       <td className="px-6 py-4"><Skeleton className="h-5 w-10 rounded" /></td>
                       <td className="px-6 py-4"><Skeleton className="h-6 w-20 rounded-full" /></td>
                       <td className="px-6 py-4"><div className="flex justify-end gap-2"><Skeleton className="h-8 w-8 rounded-full" /><Skeleton className="h-8 w-8 rounded-full" /></div></td>
                     </tr>
                   ))
                 ) : filteredAndSortedData.length === 0 ? (
                   <tr>
                     <td colSpan={8} className="px-6 py-10 text-center">
                        <Users size={32} className="mx-auto text-slate-300 mb-2" />
                        <p className="text-slate-600 font-medium">No students match your filters</p>
                        <p className="text-sm text-slate-400 mt-1">Try clearing your search or semester filters.</p>
                     </td>
                   </tr>
                 ) : (
                   <AnimatePresence>
                     {filteredAndSortedData.map((student: any) => (
                       <motion.tr 
                          key={student.student_id}
                          layout
                          initial={{ opacity: 0 }}
                          animate={{ opacity: 1 }}
                          exit={{ opacity: 0 }}
                          onClick={() => navigate(`/mentor/student/${student.student_id}`)}
                          className="hover:bg-brand-50/30 dark:hover:bg-white/5 cursor-pointer transition-colors group"
                       >
                          <td className="px-6 py-4" onClick={(e) => e.stopPropagation()}>
                            <input 
                              type="checkbox" 
                              className="rounded border-slate-300 dark:border-white/10 dark:bg-black/50 text-brand-600 dark:text-amber-500 focus:ring-brand-500 dark:focus:ring-amber-500 cursor-pointer"
                              checked={selectedStudents.has(student.student_id)}
                              onChange={() => toggleSelectStudent(student.student_id)}
                            />
                          </td>
                          <td className="px-6 py-4 font-semibold text-slate-900 dark:text-white group-hover:text-brand-700 dark:group-hover:text-amber-400 transition">
                            {student.full_name}
                          </td>
                          <td className="px-6 py-4 hidden sm:table-cell">
                             <div className="flex flex-col">
                                <span className="font-medium text-slate-700 dark:text-slate-300">{student.branch}</span>
                                <span className="text-xs text-slate-500 dark:text-slate-400 mt-0.5">Semester {student.semester}</span>
                             </div>
                          </td>
                          <td className="px-6 py-4">
                             <span className={cn("font-semibold", 
                               (student.avg_attendance ?? 100) < 75 ? "text-amber-600 dark:text-amber-400" : "text-slate-700 dark:text-slate-300"
                             )}>
                                {student.avg_attendance ?? '-'}%
                             </span>
                          </td>
                          <td className="px-6 py-4 font-medium text-slate-700 dark:text-slate-300 hidden md:table-cell">
                             {student.avg_total_score ?? '-'}
                          </td>
                          <td className="px-6 py-4">
                             <span className="font-bold text-indigo-700 dark:text-indigo-300 bg-indigo-50 dark:bg-indigo-950/40 px-2.5 py-1 rounded-lg text-sm">
                               {scoreToCGPA(student.avg_total_score)}
                             </span>
                          </td>
                          <td className="px-6 py-4 font-bold">
                             <span className={student.failing_subjects > 0 ? "text-red-500 dark:text-red-400 bg-red-50 dark:bg-red-950/40 px-2 py-0.5 rounded" : "text-slate-400 dark:text-slate-500"}>
                               {student.failing_subjects}
                             </span>
                          </td>
                          <td className="px-6 py-4">
                             <RiskBadge level={student.risk_level} />
                          </td>
                          <td className="px-6 py-4">
                             <div className="flex items-center justify-end gap-2" onClick={(e) => e.stopPropagation()}>
                               <button 
                                 onClick={() => navigate(`/mentor/student/${student.student_id}`)}
                                 className="p-1.5 text-slate-400 dark:text-slate-500 hover:text-brand-600 dark:hover:text-amber-400 hover:bg-brand-50 dark:hover:bg-white/5 rounded-lg transition"
                                 title="View Details"
                               >
                                 <Eye size={18} />
                               </button>
                               <button 
                                 onClick={() => navigate(`/mentor/attendance?student=${student.student_id}`)}
                                 className="p-1.5 text-slate-400 dark:text-slate-500 hover:text-emerald-600 dark:hover:text-emerald-400 hover:bg-emerald-50 dark:hover:bg-emerald-950/40 rounded-lg transition"
                                 title="Log Attendance"
                               >
                                 <ClipboardCheck size={18} />
                               </button>
                               <button 
                                 onClick={() => {
                                   setSelectedStudents(new Set([student.student_id]))
                                   setShowMessageComposer(true)
                                 }}
                                 className="p-1.5 text-slate-400 dark:text-slate-500 hover:text-brand-600 dark:hover:text-amber-400 hover:bg-brand-50 dark:hover:bg-white/5 rounded-lg transition"
                                 title="Message"
                               >
                                 <MessageSquare size={18} />
                               </button>
                             </div>
                          </td>
                       </motion.tr>
                     ))}
                   </AnimatePresence>
                 )}
               </tbody>
             </table>
           </div>
        </div>
      </div>

      {/* Floating Ask AI Button */}
      <button
        ref={aiButtonRef}
        onClick={() => setIsChatOpen(true)}
        className={cn(
          "fixed bottom-6 right-6 z-40 flex items-center gap-2 px-5 py-3 rounded-full shadow-lg shadow-brand-500/20 text-white font-semibold tracking-wide transition-all",
          "bg-gradient-to-r from-brand-600 to-brand-700 hover:from-brand-500 hover:to-brand-600 hover:scale-105 active:scale-95 border border-brand-500/50"
        )}
      >
        <span className="text-brand-200">✦</span> Ask AI
      </button>

      {/* Floating Bulk Action Bar */}
      <AnimatePresence>
        {selectedStudents.size > 0 && (
          <motion.div 
            initial={{ y: 100, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            exit={{ y: 100, opacity: 0 }}
            className="fixed bottom-6 left-1/2 -translate-x-1/2 z-40 bg-slate-900 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-6 border border-slate-700 font-sans"
          >
            <div className="flex items-center gap-3 font-semibold text-sm">
              <span className="flex h-6 w-6 items-center justify-center rounded-full bg-brand-500 text-xs">
                {selectedStudents.size}
              </span> 
              students selected
            </div>
            <div className="h-6 w-px bg-slate-700"></div>
            <div className="flex items-center gap-3">
               <button onClick={handleComposeForSelected} className="flex items-center gap-2 px-4 py-2 bg-brand-600 hover:bg-brand-500 text-white rounded-lg text-sm font-bold shadow-sm transition">
                  <Sparkles size={16}/> Compose AI Message
               </button>
               <button onClick={() => setSelectedStudents(new Set())} className="px-3 py-2 text-slate-400 hover:text-white transition flex items-center gap-2 text-sm font-medium">
                  <X size={16}/> Clear selection
               </button>
            </div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Integrated Chat Panel */}
      <CohortChatPanel isOpen={isChatOpen} onClose={() => setIsChatOpen(false)} />
      
      {/* Integrated Message Composer Payload Contexts dynamically generated */}
      {filteredAndSortedData && (
        <MessageComposer 
          isOpen={showMessageComposer}
          onClose={() => setShowMessageComposer(false)}
          initialRecipients={Array.from(selectedStudents).map(id => {
            const s = (filteredAndSortedData as any[]).find((r: any) => r.student_id === id)
            return { id: id, name: s?.full_name || 'Unknown' }
          })}
        />
      )}
    </AppShell>
  )
}
