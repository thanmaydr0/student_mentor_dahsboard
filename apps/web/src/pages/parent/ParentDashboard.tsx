import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import AppShell from '../../components/layout/AppShell'
import ProfileCard from '../../components/student/ProfileCard'
import AttendanceChart from '../../components/student/AttendanceChart'
import MarksTable from '../../components/student/MarksTable'
import DirectChat from '../../components/chat/DirectChat'
import { useStudentProfile } from '../../hooks/student/useStudentProfile'
import { useAttendanceSummary } from '../../hooks/student/useAttendanceSummary'
import { useGradesSummary } from '../../hooks/student/useGradesSummary'
import { MessageSquare, Phone } from 'lucide-react'

export default function ParentDashboard() {
  const { user } = useAuth()
  const [studentId, setStudentId] = useState<string | null>(null)
  const [mentorId, setMentorId] = useState<string | null>(null)
  const [isChatOpen, setIsChatOpen] = useState(false)
  
  useEffect(() => {
    async function loadLink() {
      if (!user) return
      const { data, error } = await supabase
        .from('parent_student_links')
        .select('student_id, profiles!parent_student_links_student_id_fkey(mentor_id)')
        .eq('parent_id', user.id)
        .single()
        
      if (data) {
        setStudentId(data.student_id)
        // @ts-ignore
        setMentorId(data.profiles?.mentor_id || null)
      }
    }
    loadLink()
  }, [user])

  const profileQuery = useStudentProfile(studentId || undefined)
  const attendanceQuery = useAttendanceSummary(studentId || undefined)
  const gradesQuery = useGradesSummary(studentId || undefined)

  return (
    <AppShell role="parent">
      <motion.div className="flex flex-col gap-6" initial={{opacity:0}} animate={{opacity:1}}>
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold text-brand-900 dark:text-white">
            Parent Dashboard
          </h1>
          {mentorId && (
             <button onClick={() => setIsChatOpen(true)} className="flex items-center gap-2 px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white rounded-lg shadow transition">
                <MessageSquare size={18} />
                Contact Mentor
             </button>
          )}
        </div>

        {!studentId ? (
          <div className="p-8 text-center bg-white dark:bg-[#13151a] rounded-2xl border border-slate-200 dark:border-white/10">
            <h3 className="text-lg font-bold text-slate-700 dark:text-slate-300">No Student Linked</h3>
            <p className="text-slate-500 mt-2">Please contact the administration to link your child to your account.</p>
          </div>
        ) : (
          <>
            <ProfileCard profile={profileQuery.data} loading={profileQuery.isLoading} />
            
            <div className="grid grid-cols-1 xl:grid-cols-2 gap-6">
              <AttendanceChart data={attendanceQuery.data} isLoading={attendanceQuery.isLoading} />
              <MarksTable data={gradesQuery.data} isLoading={gradesQuery.isLoading} />
            </div>
          </>
        )}

        {isChatOpen && mentorId && user && (
           <DirectChat 
             isOpen={isChatOpen} 
             onClose={() => setIsChatOpen(false)} 
             currentUserId={user.id} 
             peerId={mentorId} 
             peerRole="Mentor"
           />
        )}
      </motion.div>
    </AppShell>
  )
}
