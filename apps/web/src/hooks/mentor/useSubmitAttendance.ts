import { useMutation, useQueryClient } from '@tanstack/react-query'
import { supabase } from '../../lib/supabase'
import toast from 'react-hot-toast'
import { useAuth } from '../useAuth'

interface SubmitAttendancePayload {
  student_id: string
  class_id: string
  date: string
  status: 'Present' | 'Absent' | 'Excused'
}

export function useSubmitAttendance() {
  const queryClient = useQueryClient()
  const { user } = useAuth()

  return useMutation({
    mutationFn: async (records: SubmitAttendancePayload[]) => {
      if (!records || records.length === 0) return
      if (!user) throw new Error('User is not authenticated')

      const recordsWithMentor = records.map(r => ({
        ...r,
        mentor_id: user.id
      }))

      const { data, error } = await supabase
        .from('attendance')
        .upsert(recordsWithMentor, { onConflict: 'student_id,class_id,date' })
        
      if (error) throw new Error(error.message)
      
      return data
    },
    onSuccess: () => {
      toast.success('Attendance updated successfully')
      queryClient.invalidateQueries({ queryKey: ['attendance-log'] })
      queryClient.invalidateQueries({ queryKey: ['cohort-summary'] })
    },
    onError: (error: Error) => {
      toast.error(`Failed to update attendance: ${error.message}`)
    }
  })
}
