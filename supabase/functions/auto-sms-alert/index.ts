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
    const payload = await req.json()
    const { student_id, class_id, subject_name, status, current_percentage, date } = payload

    if (!student_id || !class_id) {
      throw new Error('Missing required payload fields')
    }

    const supabaseUrl = Deno.env.get('SUPABASE_URL')
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')
    
    // We can proceed even if DB client fails to init (for mock logging), but ideally we fetch the student's name
    let studentName = 'Student'
    
    if (supabaseUrl && supabaseKey) {
      const supabase = createClient(supabaseUrl, supabaseKey)
      const { data: profile } = await supabase
        .from('profiles')
        .select('full_name')
        .eq('id', student_id)
        .single()
        
      if (profile?.full_name) {
        studentName = profile.full_name
      }
    }

    // 1. Format the SMS Message based on the trigger condition
    let smsBody = ''
    let alertType = ''

    if (current_percentage !== null && current_percentage < 75) {
      alertType = 'LOW_ATTENDANCE_WARNING'
      smsBody = `CRITICAL ALERT: ${studentName}'s attendance in ${subject_name} has fallen to ${current_percentage}%. Minimum required by the university is 75%. Please meet the mentor immediately.`
    } else if (status === 'Absent') {
      alertType = 'DAILY_ABSENT_NOTICE'
      smsBody = `Notice: ${studentName} was marked ABSENT for ${subject_name} on ${date}. Current attendance for this subject stands at ${current_percentage}%.`
    } else {
      // If the webhook fired for 'Present' and attendance is >= 75, we do nothing.
      return new Response(JSON.stringify({ ok: true, message: 'No alert required.' }), {
        headers: { ...corsHeaders, 'content-type': 'application/json' },
      })
    }

    // 2. Dispatch the SMS
    // NOTE: In a real production environment, you would call the Twilio REST API or similar here:
    // await fetch(`https://api.twilio.com/2010-04-01/Accounts/${TWILIO_SID}/Messages.json`, { ... })
    
    console.log('\n=========================================')
    console.log(`🚀 AUTOMATED SMS DISPATCH TRIGGERED`)
    console.log(`Type: ${alertType}`)
    console.log(`To: Parent of ${studentName}`)
    console.log(`Message: "${smsBody}"`)
    console.log('=========================================\n')

    return new Response(JSON.stringify({ 
      ok: true, 
      dispatched: true,
      alertType,
      messageSent: smsBody 
    }), {
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })

  } catch (error: any) {
    console.error('Error processing auto-sms-alert:', error.message)
    return new Response(JSON.stringify({ ok: false, error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })
  }
})
