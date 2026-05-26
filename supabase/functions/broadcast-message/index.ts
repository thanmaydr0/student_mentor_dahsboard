import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) throw new Error('Unauthorized')

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Verify user
    const { data: { user }, error: authError } = await supabase.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authError || !user) throw new Error('Unauthorized')

    const { data: profile } = await supabase
      .from('profiles')
      .select('role, full_name')
      .eq('id', user.id)
      .single()

    if (profile?.role !== 'mentor' && profile?.role !== 'admin') {
      throw new Error('Forbidden: Only Mentors can broadcast messages.')
    }

    const { studentIds, message, channels, includeAiSummary, includeVtuResult, includeAttendance, includeIatMarks, vtuData } = await req.json()

    if (!studentIds || !Array.isArray(studentIds) || studentIds.length === 0) {
      throw new Error('No students selected')
    }

    // 1. Create a notification_message
    let title = 'Announcement from Mentor'
    let body = message || ''
    
    // Append attachments info to body
    let attachments = []
    if (includeVtuResult) attachments.push('VTU Results')
    if (includeAiSummary) attachments.push('AI Summary')
    if (includeAttendance) attachments.push('Attendance')
    if (includeIatMarks) attachments.push('IAT Marks')

    if (attachments.length > 0) {
      body += `\n\n[Attached: ${attachments.join(', ')}]`
      if (vtuData?.sgpa) {
        body += `\nSGPA: ${vtuData.sgpa}`
      }
    }

    // Insert into notification_messages
    const { data: msgData, error: msgError } = await supabase
      .from('notification_messages')
      .insert({
        title,
        body,
        type: 'info',
        deep_link: '/student/notifications'
      })
      .select('id')
      .single()

    if (msgError) throw msgError

    // 2. Link to all selected students
    const userNotifications = studentIds.map(studentId => ({
      user_id: studentId,
      message_id: msgData.id,
      is_read: false
    }))

    const { error: linkError } = await supabase
      .from('user_notifications')
      .insert(userNotifications)

    if (linkError) throw linkError

    // Simulate sending via requested channels (Email, WhatsApp, SMS)
    console.log(`Dispatched to channels: ${JSON.stringify(channels)} for ${studentIds.length} students.`)

    return new Response(JSON.stringify({ ok: true, message: 'Broadcast successful', message_id: msgData.id }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ ok: false, error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
