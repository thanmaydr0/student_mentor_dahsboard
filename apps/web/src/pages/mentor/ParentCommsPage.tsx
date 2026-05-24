import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import AppShell from '../../components/layout/AppShell'
import DirectChat from '../../components/chat/DirectChat'
import { MessageSquare, Phone, UserCircle } from 'lucide-react'
import toast from 'react-hot-toast'

interface ParentLink {
  parent_id: string
  student_id: string
  parent: {
    full_name: string
  }
  student: {
    full_name: string
  }
}

export default function ParentCommsPage() {
  const { user } = useAuth()
  const [links, setLinks] = useState<ParentLink[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedParentId, setSelectedParentId] = useState<string | null>(null)

  useEffect(() => {
    async function loadParents() {
      if (!user) return
      
      // 1. Get all students assigned to this mentor
      const { data: students, error: studentErr } = await supabase
        .from('profiles')
        .select('id')
        .eq('mentor_id', user.id)

      if (studentErr || !students) {
        toast.error('Failed to load students')
        setLoading(false)
        return
      }

      const studentIds = students.map(s => s.id)
      
      if (studentIds.length === 0) {
        setLoading(false)
        return
      }

      // 2. Get parent links for these students
      const { data: linkData, error: linkErr } = await supabase
        .from('parent_student_links')
        .select(`
          parent_id,
          student_id,
          parent:profiles!parent_student_links_parent_id_fkey(full_name),
          student:profiles!parent_student_links_student_id_fkey(full_name)
        `)
        .in('student_id', studentIds)

      if (linkErr) {
        toast.error('Failed to load parents')
      } else if (linkData) {
        // @ts-ignore
        setLinks(linkData as ParentLink[])
      }
      setLoading(false)
    }

    loadParents()
  }, [user])

  return (
    <AppShell role="mentor">
      <motion.div className="flex flex-col gap-6" initial={{opacity:0}} animate={{opacity:1}}>
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold text-brand-900 dark:text-white">
            Parent Communications
          </h1>
        </div>

        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {loading ? (
            <p className="text-slate-500">Loading parents...</p>
          ) : links.length === 0 ? (
            <p className="text-slate-500 col-span-full">No parents found for your assigned students.</p>
          ) : (
            links.map((link, idx) => (
              <div key={`${link.parent_id}-${idx}`} className="p-6 bg-white dark:bg-[#13151a] rounded-2xl border border-slate-200 dark:border-white/10 shadow-sm flex flex-col gap-4">
                <div className="flex items-center gap-3 border-b border-slate-100 dark:border-white/5 pb-4">
                  <div className="w-10 h-10 rounded-full bg-brand-100 dark:bg-brand-900/40 text-brand-700 dark:text-brand-300 flex items-center justify-center shrink-0">
                    <UserCircle size={24} />
                  </div>
                  <div>
                    <h3 className="font-semibold text-brand-900 dark:text-white">{link.parent.full_name}</h3>
                    <p className="text-xs text-brand-500">Parent of {link.student.full_name}</p>
                  </div>
                </div>
                
                <div className="flex gap-2 mt-auto">
                  <button 
                    onClick={() => setSelectedParentId(link.parent_id)}
                    className="flex-1 flex justify-center items-center gap-2 bg-brand-600 hover:bg-brand-700 text-white py-2 rounded-xl text-sm font-medium transition"
                  >
                    <MessageSquare size={16} />
                    Message
                  </button>
                  <button 
                    onClick={() => setSelectedParentId(link.parent_id)}
                    className="flex-1 flex justify-center items-center gap-2 bg-slate-100 hover:bg-slate-200 dark:bg-white/5 dark:hover:bg-white/10 text-brand-700 dark:text-white py-2 rounded-xl text-sm font-medium transition"
                  >
                    <Phone size={16} />
                    Call
                  </button>
                </div>
              </div>
            ))
          )}
        </div>

        {selectedParentId && user && (
          <DirectChat 
            isOpen={!!selectedParentId}
            onClose={() => setSelectedParentId(null)}
            currentUserId={user.id}
            peerId={selectedParentId}
            peerRole="Parent"
          />
        )}
      </motion.div>
    </AppShell>
  )
}
