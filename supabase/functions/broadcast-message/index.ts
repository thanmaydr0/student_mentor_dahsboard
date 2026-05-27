import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Content-Type': 'application/json'
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(JSON.stringify({ ok: false, error: 'Missing Authorization header' }), { headers: corsHeaders })
    }

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    
    // Client for auth check
    const supabaseClient = createClient(
      supabaseUrl,
      Deno.env.get('SUPABASE_ANON_KEY')!
    )

    // Admin client for DB inserts
    const supabaseAdmin = createClient(
      supabaseUrl,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    )

    const { data: { user }, error: authError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authError || !user) {
      return new Response(JSON.stringify({ ok: false, error: 'Unauthorized: ' + (authError?.message || 'No user') }), { headers: corsHeaders })
    }

    const { data: profile } = await supabaseAdmin.from('profiles').select('role, full_name').eq('id', user.id).single()
    if (profile?.role !== 'mentor' && profile?.role !== 'admin') {
      return new Response(JSON.stringify({ ok: false, error: 'Forbidden: Only mentors can broadcast.' }), { headers: corsHeaders })
    }

    let reqBody: any
    try { reqBody = await req.json() } catch (e) {
      return new Response(JSON.stringify({ ok: false, error: 'Invalid JSON body' }), { headers: corsHeaders })
    }

    const { studentIds, message, channels, includeAiSummary, includeVtuResult, includeAttendance, includeIatMarks, vtuData } = reqBody
    if (!studentIds || !Array.isArray(studentIds) || studentIds.length === 0) {
      return new Response(JSON.stringify({ ok: false, error: 'No students selected' }), { headers: corsHeaders })
    }

    let title = 'Announcement from Mentor'
    let baseBody = message || ''
    
    const attachments: string[] = []
    if (includeVtuResult) attachments.push('VTU Results')
    if (includeAiSummary) attachments.push('AI Summary')
    if (includeAttendance) attachments.push('Attendance')
    if (includeIatMarks) attachments.push('IAT Marks')

    let dbBody = baseBody
    if (attachments.length > 0) {
      dbBody += `\n\n[Attached: ${attachments.join(', ')}]`
      if (vtuData?.sgpa) dbBody += `\nSGPA: ${vtuData.sgpa}`
    }

    // ── Insert Notification (Generic DB copy) ──
    const { data: msgData, error: msgError } = await supabaseAdmin
      .from('notification_messages')
      .insert({ title, body: dbBody, type: 'info', deep_link: '/student/notifications' })
      .select('id').single()

    if (msgError) {
      return new Response(JSON.stringify({ ok: false, error: `notification_messages insert failed: ${msgError.message}` }), { headers: corsHeaders })
    }

    // ── Link to Students ──
    const userNotifications = studentIds.map((studentId: string) => ({ user_id: studentId, message_id: msgData.id, is_read: false }))
    const { error: linkError } = await supabaseAdmin.from('user_notifications').insert(userNotifications)
    if (linkError) console.error("Link error:", linkError);

    // ── Parse Channels ──
    let channelsList: string[] = []
    try {
      if (Array.isArray(channels)) channelsList = channels
      else if (typeof channels === 'object' && channels !== null) channelsList = Object.keys(channels).filter(k => channels[k])
    } catch (_) {}
    const channelsStr = channelsList.length > 0 ? channelsList.join(', ') : 'In-App'

    // ── Fetch Parent Contacts ──
    let studentProfiles: any[] = []
    try {
      const { data: profilesData } = await supabaseAdmin.from('profiles').select('id, full_name, parent_email, parent_phone').in('id', studentIds);
      if (profilesData) studentProfiles = profilesData;
    } catch (e) {
      console.warn("Could not fetch parent contacts", e);
    }

    // ── Fetch Detailed Payload Data ──
    let allAttendance: any[] = [];
    let allGrades: any[] = [];

    if (includeAttendance) {
      try {
        const attPromises = studentIds.map((id: string) => 
          supabaseAdmin.rpc('get_attendance_summary', { p_student_id: id }).then(res => ({ id, data: res.data }))
        );
        allAttendance = await Promise.all(attPromises);
      } catch (e) { console.error("Attendance fetch error:", e); }
    }

    if (includeIatMarks) {
      try {
        const { data: gData } = await supabaseAdmin
          .from('grades')
          .select('student_id, internal_marks, classes(subjects(name))')
          .in('student_id', studentIds);
        if (gData) allGrades = gData;
      } catch (e) { console.error("Grades fetch error:", e); }
    }

    const RESEND_API_KEY = 're_L4VYLNiH_G8aSTwHSkj76PBoE5kZJt19M';
    const TWILIO_ACCOUNT_SID = Deno.env.get('TWILIO_ACCOUNT_SID');
    const TWILIO_AUTH_TOKEN = Deno.env.get('TWILIO_AUTH_TOKEN');
    const TWILIO_PHONE_NUMBER = Deno.env.get('TWILIO_PHONE_NUMBER');
    
    const dateString = new Date().toISOString().split('T')[0]

    for (const studentId of studentIds) {
      const sp = studentProfiles.find(p => p.id === studentId) || {};
      
      // Construct dynamic body per student
      let customBody = baseBody;

      if (includeAttendance) {
        const studentAtt = allAttendance.find(a => a.id === studentId)?.data;
        if (studentAtt && studentAtt.length > 0) {
          customBody += '\n\n📊 ATTENDANCE SUMMARY:';
          studentAtt.forEach((s: any) => {
            customBody += `\n- ${s.subject_name || 'Subject'}: ${s.percentage}% (${s.present_count}/${s.total_count})`;
          });
        } else {
          customBody += '\n\n📊 ATTENDANCE SUMMARY:\nNo records found.';
        }
      }

      if (includeIatMarks) {
        const studentGrades = allGrades.filter(g => g.student_id === studentId);
        if (studentGrades && studentGrades.length > 0) {
          customBody += '\n\n📝 IAT / INTERNAL MARKS:';
          studentGrades.forEach((g: any) => {
            const subjName = g.classes?.subjects?.name || 'Unknown Subject';
            customBody += `\n- ${subjName}: ${g.internal_marks} / 50`;
          });
        } else {
          customBody += '\n\n📝 IAT / INTERNAL MARKS:\nNo records found.';
        }
      }
      
      if (includeVtuResult && vtuData?.sgpa) {
        customBody += `\n\n🎓 VTU Result SGPA: ${vtuData.sgpa}`;
      }

      // 1. Log intervention
      try {
        await supabaseAdmin.from('interventions').insert({
          student_id: studentId,
          mentor_id: user.id,
          type: 'Message',
          notes: `Broadcast via [${channelsStr}]:\n${customBody}`,
          date: dateString
        })
      } catch (_) {}

      // 2. Email (Resend)
      if (channelsList.some(c => c.toLowerCase() === 'email') && sp.parent_email) {
        try {
          await fetch('https://api.resend.com/emails', {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${RESEND_API_KEY}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({
              from: 'EduPredict <onboarding@resend.dev>',
              to: sp.parent_email,
              subject: `EduPredict Update for ${sp.full_name || 'Student'}`,
              text: customBody
            })
          })
        } catch (e) { console.error("Resend error:", e) }
      }

      // 3. SMS (Twilio)
      if (channelsList.some(c => c.toLowerCase() === 'sms') && sp.parent_phone && TWILIO_ACCOUNT_SID && TWILIO_AUTH_TOKEN && TWILIO_PHONE_NUMBER) {
        try {
          const params = new URLSearchParams({
            To: sp.parent_phone,
            From: TWILIO_PHONE_NUMBER,
            Body: `EduPredict Update for ${sp.full_name || 'Student'}:\n${customBody}`
          });
          
          await fetch(`https://api.twilio.com/2010-04-01/Accounts/${TWILIO_ACCOUNT_SID}/Messages.json`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': `Basic ${btoa(`${TWILIO_ACCOUNT_SID}:${TWILIO_AUTH_TOKEN}`)}`
            },
            body: params.toString()
          });
        } catch (e) { console.error("Twilio SMS error:", e) }
      }

      // 4. WhatsApp (Twilio)
      if (channelsList.some(c => c.toLowerCase() === 'whatsapp') && sp.parent_phone && TWILIO_ACCOUNT_SID && TWILIO_AUTH_TOKEN && TWILIO_PHONE_NUMBER) {
        try {
          const params = new URLSearchParams({
            To: `whatsapp:${sp.parent_phone}`,
            From: `whatsapp:${TWILIO_PHONE_NUMBER}`,
            Body: `EduPredict Update for ${sp.full_name || 'Student'}:\n${customBody}`
          });
          
          await fetch(`https://api.twilio.com/2010-04-01/Accounts/${TWILIO_ACCOUNT_SID}/Messages.json`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': `Basic ${btoa(`${TWILIO_ACCOUNT_SID}:${TWILIO_AUTH_TOKEN}`)}`
            },
            body: params.toString()
          });
        } catch (e) { console.error("Twilio WhatsApp error:", e) }
      }
    }

    return new Response(JSON.stringify({
      ok: true,
      message: `Broadcast sent to ${studentIds.length} student(s) via ${channelsStr}.`,
      message_id: msgData.id
    }), { headers: corsHeaders })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ ok: false, error: `Unexpected Error: ${error.message}` }),
      { headers: corsHeaders }
    )
  }
})
