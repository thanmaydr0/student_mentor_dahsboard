import React, { useState, useEffect, useMemo, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { 
  Users, Calendar, Check, X, ClipboardCheck, 
  AlertTriangle, ArrowLeft, Loader2, Info, CloudDownload
} from 'lucide-react'
import { useAuth } from '../../hooks/useAuth'
import AppShell from '../../components/layout/AppShell'
import { supabase } from '../../lib/supabase'
import { Skeleton } from '../../components/ui/Skeleton'
import { cn } from '../../lib/utils'
import toast from 'react-hot-toast'

interface MentorClass {
  id: string
  semester: number
  subjects: { name: string; code: string }
}

interface ErpAttendance {
  student_id: string
  class_id: string
  theory_held: number
  theory_attended: number
  theory_percentage: number
  lab_held: number
  lab_attended: number
  lab_percentage: number
  updated_at: string
}

export default function BulkAttendancePage() {
  const { user } = useAuth()
  
  // Step 1 State
  const [classes, setClasses] = useState<MentorClass[]>([])
  const [isLoadingClasses, setIsLoadingClasses] = useState(true)
  const [formClassId, setFormClassId] = useState<string>('all')
  
  const [activeQuery, setActiveQuery] = useState<{classId: string} | null>(null)

  const [erpData, setErpData] = useState<ErpAttendance[]>([])
  const [studentsData, setStudentsData] = useState<any[]>([])
  const [isLoadingErp, setIsLoadingErp] = useState(false)
  const [isSyncing, setIsSyncing] = useState(false)

  // Fetch Mentor Classes
  useEffect(() => {
    async function loadClasses() {
      if (!user) return
      setIsLoadingClasses(true)
      const { data, error } = await supabase
        .from('classes')
        .select(`
          id,
          semester,
          subjects ( name, code )
        `)
        .eq('mentor_id', user.id)
        
      if (!error && data) {
        setClasses(data as unknown as MentorClass[])
      }
      setIsLoadingClasses(false)
    }
    loadClasses()
  }, [user])

  const fetchErpData = async (classId: string) => {
    if (!user) return
    setIsLoadingErp(true)
    
    // Fetch students assigned to mentor
    const { data: students } = await supabase
      .from('profiles')
      .select('id, full_name')
      .eq('mentor_id', user.id)
      .eq('role', 'student')

    if (students) setStudentsData(students)

    let query = supabase.from('erp_attendance_summary').select('*')
    if (classId !== 'all') {
      query = query.eq('class_id', classId)
    } else {
      // Filter by classes owned by mentor
      const classIds = classes.map(c => c.id)
      query = query.in('class_id', classIds)
    }

    const { data, error } = await query
    
    if (error) {
      toast.error('Failed to load ERP attendance')
    } else if (data) {
      setErpData(data)
    }
    setIsLoadingErp(false)
  }

  const handleLoadStudents = () => {
    setActiveQuery({ classId: formClassId })
    fetchErpData(formClassId)
  }

  const handleSyncErp = async () => {
    setIsSyncing(true)
    toast.loading('Syncing ERP attendance...', { id: 'sync' })
    try {
      const { data, error } = await supabase.functions.invoke('erp-attendance-sync')
      if (error) throw new Error(error.message || 'Failed to sync')
      if (data?.error) throw new Error(data.error)
      
      toast.success(data?.message || 'Synced successfully', { id: 'sync' })
      if (activeQuery) fetchErpData(activeQuery.classId)
    } catch (err: any) {
      toast.error(err.message || 'Failed to sync ERP attendance', { id: 'sync' })
    }
    setIsSyncing(false)
  }

  return (
    <AppShell role="mentor">
      <div className="flex flex-col gap-6 max-w-6xl mx-auto w-full pb-10">
        
        {/* Header */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <h1 className="text-2xl font-bold text-slate-900 flex items-center gap-2">
              <ClipboardCheck className="text-brand-600" /> ERP Attendance
            </h1>
            <p className="text-sm text-slate-500 mt-1">Automatically sync and view attendance for Theory and Lab from the college ERP.</p>
          </div>
          
          <button 
            onClick={handleSyncErp}
            disabled={isSyncing}
            className="flex items-center gap-2 px-5 py-2.5 rounded-xl font-semibold bg-indigo-600 text-white hover:bg-indigo-700 shadow flex-shrink-0 transition disabled:opacity-70"
          >
            {isSyncing ? <Loader2 size={18} className="animate-spin" /> : <CloudDownload size={18} />}
            Sync ERP Attendance
          </button>
        </div>

        {/* Step 1: Configuration */}
        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-5">
          <div className="flex flex-col sm:flex-row gap-4 items-end">
             <div className="w-full sm:w-1/2">
                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Select Class</label>
                {isLoadingClasses ? (
                  <Skeleton className="h-10 w-full rounded-xl" />
                ) : (
                  <select 
                    value={formClassId} 
                    onChange={(e) => setFormClassId(e.target.value)}
                    disabled={!!activeQuery}
                    className="w-full rounded-xl border-slate-200 bg-slate-50 py-2.5 text-sm focus:ring-brand-500 focus:border-brand-500 disabled:opacity-60"
                  >
                    <option value="all">All Subjects</option>
                    {classes.map(c => (
                      <option key={c.id} value={c.id}>
                        {c.subjects?.name} ({c.subjects?.code}) — Semester {c.semester}
                      </option>
                    ))}
                  </select>
                )}
             </div>

             <div className="w-full sm:w-auto">
               {activeQuery ? (
                 <button 
                   onClick={() => setActiveQuery(null)}
                   className="w-full py-2.5 px-6 rounded-xl font-semibold border-2 border-slate-200 text-slate-600 hover:bg-slate-50 transition"
                 >
                   Change Selection
                 </button>
               ) : (
                 <button 
                   onClick={handleLoadStudents}
                   disabled={isLoadingClasses}
                   className="w-full py-2.5 px-6 rounded-xl font-semibold bg-brand-600 text-white hover:bg-brand-700 transition disabled:opacity-50"
                 >
                   View Attendance
                 </button>
               )}
             </div>
          </div>
        </div>

        {/* Step 2: Grid */}
        {activeQuery && (
          <motion.div 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex flex-col gap-4"
          >
            {/* Table */}
            <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-sm whitespace-nowrap">
                  <thead className="bg-slate-50 border-b border-slate-200">
                    <tr>
                      <th className="px-6 py-4 font-semibold text-slate-500 sticky left-0 bg-slate-50 z-10 border-r border-slate-200 shadow-[1px_0_0_rgba(0,0,0,0.05)] min-w-[200px]">Student</th>
                      <th className="px-6 py-4 font-semibold text-slate-500 border-r border-slate-200">Subject</th>
                      <th colSpan={3} className="px-6 py-3 font-semibold text-slate-500 text-center bg-blue-50/50 border-r border-blue-100">Theory Attendance</th>
                      <th colSpan={3} className="px-6 py-3 font-semibold text-slate-500 text-center bg-purple-50/50">Lab Attendance</th>
                    </tr>
                    <tr className="border-t border-slate-200 text-xs text-slate-400">
                      <th className="sticky left-0 bg-slate-50 z-10 border-r border-slate-200 shadow-[1px_0_0_rgba(0,0,0,0.05)]"></th>
                      <th className="border-r border-slate-200"></th>
                      <th className="px-4 py-2 text-center bg-blue-50/50">Held</th>
                      <th className="px-4 py-2 text-center bg-blue-50/50">Attended</th>
                      <th className="px-4 py-2 text-center bg-blue-50/50 border-r border-blue-100">%</th>
                      <th className="px-4 py-2 text-center bg-purple-50/50">Held</th>
                      <th className="px-4 py-2 text-center bg-purple-50/50">Attended</th>
                      <th className="px-4 py-2 text-center bg-purple-50/50">%</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {isLoadingErp ? (
                      Array.from({length: 5}).map((_,i) => (
                        <tr key={i}>
                          <td className="px-6 py-4 sticky left-0 bg-white z-10 border-r border-slate-100"><Skeleton className="h-6 w-32 rounded" /></td>
                          <td className="px-6 py-4 border-r border-slate-100"><Skeleton className="h-6 w-24 rounded" /></td>
                          <td colSpan={6} className="px-6 py-4"><Skeleton className="h-6 w-full rounded" /></td>
                        </tr>
                      ))
                    ) : erpData?.length === 0 ? (
                      <tr><td colSpan={8} className="px-6 py-10 text-center text-slate-500 font-medium">No ERP attendance data found. Try syncing.</td></tr>
                    ) : (
                      erpData?.map((record, idx) => {
                        const student = studentsData.find(s => s.id === record.student_id)
                        const cls = classes.find(c => c.id === record.class_id)
                        
                        return (
                          <tr key={record.id} className="hover:bg-slate-50 transition-colors">
                             <td className="px-6 py-3 sticky left-0 bg-white z-10 border-r border-slate-100 shadow-[1px_0_0_rgba(0,0,0,0.05)]">
                               <div className="flex items-center gap-3">
                                 <div className="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center font-bold text-slate-600 text-xs shrink-0">
                                   {student?.full_name?.charAt(0) || '?'}
                                 </div>
                                 <span className="font-semibold text-slate-800">{student?.full_name || 'Unknown'}</span>
                               </div>
                             </td>
                             <td className="px-6 py-3 font-medium text-slate-700 border-r border-slate-100">
                               {cls?.subjects?.name || 'Unknown Subject'}
                             </td>
                             <td className="px-4 py-3 text-center font-mono">{record.theory_held}</td>
                             <td className="px-4 py-3 text-center font-mono">{record.theory_attended}</td>
                             <td className={cn("px-4 py-3 text-center font-bold border-r border-blue-50", record.theory_percentage < 75 ? "text-red-500" : "text-green-600")}>
                               {record.theory_percentage}%
                             </td>
                             <td className="px-4 py-3 text-center font-mono">{record.lab_held}</td>
                             <td className="px-4 py-3 text-center font-mono">{record.lab_attended}</td>
                             <td className={cn("px-4 py-3 text-center font-bold", record.lab_percentage < 75 ? "text-red-500" : "text-green-600")}>
                               {record.lab_percentage}%
                             </td>
                          </tr>
                        )
                      })
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          </motion.div>
        )}

      </div>
    </AppShell>
  )
}
