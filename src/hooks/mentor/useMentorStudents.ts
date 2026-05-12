import { useQuery } from '@tanstack/react-query'
import { supabase } from '../../lib/supabase'

export interface MentorStudentRow {
  id: string
  full_name: string
  branch: string
  semester: number
}

export function useMentorStudents(mentorId: string | undefined) {
  return useQuery({
    queryKey: ['mentor-students', mentorId],
    queryFn: async () => {
      if (!mentorId) throw new Error('Mentor ID is required')

      const { data, error } = await supabase
        .from('profiles')
        .select('id, full_name, branch, semester')
        .eq('mentor_id', mentorId)
        .eq('role', 'student')
        .order('full_name', { ascending: true })

      if (error) throw error
      return (data || []) as MentorStudentRow[]
    },
    enabled: !!mentorId,
  })
}
