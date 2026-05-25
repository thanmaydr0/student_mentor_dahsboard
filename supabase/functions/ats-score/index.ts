import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { resumeData } = await req.json()

    if (!resumeData) {
      throw new Error('Missing resumeData')
    }

    const systemPrompt = `You are an expert ATS (Applicant Tracking System) parser and technical recruiter. 
You will be given a JSON representation of a resume. Analyze it and provide:
1. An overall ATS compatibility score (0-100) based on standard ATS rules (keywords, structure, missing crucial info).
2. A brief analysis of strengths and weaknesses.
3. 3-5 actionable tips to improve it.

Return ONLY a valid JSON object in this exact format:
{
  "score": 85,
  "analysis": "Brief analysis text...",
  "tips": ["Tip 1", "Tip 2", "Tip 3"]
}`

    const userPrompt = `Resume Data:\n${JSON.stringify(resumeData, null, 2)}`

    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o',
        temperature: 0.1,
        response_format: { type: "json_object" },
        messages: [
           { role: 'system', content: systemPrompt },
           { role: 'user', content: userPrompt }
        ]
      })
    })

    if (!openaiRes.ok) {
       throw new Error(`OpenAI Request Failed: ${await openaiRes.text()}`)
    }

    const openaiData = await openaiRes.json()
    const content = openaiData.choices?.[0]?.message?.content?.trim()
    const result = JSON.parse(content)

    return new Response(JSON.stringify(result), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
