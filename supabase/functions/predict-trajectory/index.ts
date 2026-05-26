import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) throw new Error('No authorization header')

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    )

    const { data: { user }, error: authError } =
      await supabase.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authError || !user) throw new Error('Unauthorized')

    const body = await req.json()
    const studentId = body.student_id

    if (!studentId) throw new Error('student_id is required')

    // Fetch historical CGPA from the new RPC
    const { data: historicalData, error: histErr } = await supabase.rpc('get_historical_cgpa', {
      p_student_id: studentId
    })
    
    if (histErr) throw histErr

    // Mock an AI prediction for the next 4 semesters based on the last known semester
    // In a real app, this would call OpenAI (like predict-performance)
    let lastSem = 0
    let lastCGPA = 7.5
    
    const formattedData = (historicalData || []).map((row: any) => {
      lastSem = row.semester
      lastCGPA = Number(row.cgpa)
      return {
        semester: `Sem ${row.semester}`,
        cgpa: lastCGPA,
        predicted: null,
        required: 7.5
      }
    })

    // Project future semesters (up to Sem 8)
    const predictions = []
    let currentCGPA = lastCGPA
    for (let i = lastSem + 1; i <= 8; i++) {
      // Simulate upward/downward trajectory based on random walk leaning slightly positive
      const change = (Math.random() * 0.4) - 0.1 // -0.1 to +0.3
      currentCGPA = Math.min(10, Math.max(0, currentCGPA + change))
      predictions.push({
        semester: `Sem ${i}`,
        cgpa: null,
        predicted: Number(currentCGPA.toFixed(2)),
        required: 7.5
      })
    }

    const finalData = [...formattedData, ...predictions]

    // Generate insights
    const insights = {
      positive: [
        "Consistent performance above the required threshold.",
        "Projected to graduate with Tier-1 placement eligibility."
      ],
      attention: [
        "Slight dip expected in core subjects if current attendance trend continues.",
      ]
    }

    return new Response(JSON.stringify({ data: finalData, insights }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
