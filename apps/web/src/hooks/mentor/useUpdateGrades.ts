import { useMutation, useQueryClient } from '@tanstack/react-query'
import { supabase } from '../../lib/supabase'
import toast from 'react-hot-toast'
import { useAuth } from '../useAuth'

interface UpdateGradesPayload {
  student_id: string
  class_id: string
  internal_marks: number
  external_marks: number
}

export function useUpdateGrades() {
  const queryClient = useQueryClient()
  const { user } = useAuth()

  return useMutation({
    mutationFn: async (record: UpdateGradesPayload) => {
      if (!user) throw new Error('User is not authenticated')

      const { data, error } = await supabase
        .from('grades')
        .upsert({
          student_id: record.student_id,
          class_id: record.class_id,
          internal_marks: record.internal_marks,
          external_marks: record.external_marks,
          mentor_id: user.id
          // Handle potential missing created_at by using updated_at only, but usually handled by DB
        }, { onConflict: 'student_id,class_id' })
        
      if (error) throw new Error(error.message)
      return data
    },
    onSuccess: () => {
      toast.success('Grades updated successfully')
      queryClient.invalidateQueries({ queryKey: ['student-detail'] })
    },
    onError: (error: Error) => {
      toast.error(`Failed to update grades: ${error.message}`)
    }
  })
}
