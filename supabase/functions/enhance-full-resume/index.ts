import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') ?? ''

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!OPENAI_API_KEY) {
      throw new Error('OPENAI_API_KEY is not configured.')
    }

    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      throw new Error('Missing Authorization header')
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )

    // Authenticate user
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (userError || !user) {
      throw new Error('Unauthorized: ' + (userError?.message || 'No user found'))
    }

    const { resumeData } = await req.json()
    if (!resumeData) {
      throw new Error('Resume data is required.')
    }

    const systemPrompt = `You are an expert resume writer and career coach.
You are given a JSON object representing a student's resume.
Your task is to significantly enhance the following fields:
- "summary": Rewrite to be highly professional, impactful, and ATS-optimized.
- "experience[].description": Rewrite using the XYZ formula: "Accomplished [X] as measured by [Y], by doing [Z]". Start with strong action verbs. Quantify results where possible. Keep it concise but powerful.
- "projects[].description": Rewrite to highlight technical complexity and impact.
- "skills": Reorder or refine them to be more industry-standard if needed.

CRITICAL INSTRUCTIONS:
1. You must return a valid JSON object matching the exact structure you received.
2. DO NOT modify any 'id', 'name', 'email', 'phone', 'linkedin', 'github', 'school', 'degree', 'year', 'gpa', 'company', 'role', 'startDate', 'endDate', or 'link' fields. Leave them EXACTLY as they are.
3. Only enhance the text of 'summary', 'description' in experience and projects, and refine 'skills'.`

    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: JSON.stringify(resumeData) }
        ],
        temperature: 0.7,
      })
    })

    if (!res.ok) {
      const errorText = await res.text()
      console.error('OpenAI Error', errorText)
      throw new Error('AI enhancement failed')
    }

    const json = await res.json()
    const enhancedResume = JSON.parse(json.choices[0].message.content.trim())

    return new Response(JSON.stringify({ 
      success: true, 
      enhancedResume 
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('Enhance Resume Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
