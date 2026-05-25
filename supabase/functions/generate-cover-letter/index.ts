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
    const { resumeData, jobTitle, companyName, jobDescription } = await req.json()

    if (!resumeData || !jobTitle || !companyName) {
      throw new Error('Missing required fields')
    }

    const systemPrompt = `You are a world-class career coach and professional copywriter. 
Write a highly compelling, ATS-friendly cover letter for a job application.
Tone should be confident, professional, and tailored to the job.
Do not include placeholders like "[Your Address]" or "[Date]" at the top unless the user provided them in resumeData, just start with "Dear Hiring Manager," or similar.
Keep it between 250-400 words. Focus on matching the user's experience to the job.`

    const userPrompt = `
Job Details:
Title: ${jobTitle}
Company: ${companyName}
Description (if any): ${jobDescription || 'N/A'}

Applicant Resume Data:
${JSON.stringify(resumeData, null, 2)}

Please write the cover letter now in plain text (with basic markdown for paragraphs).
`

    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o',
        temperature: 0.7,
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

    return new Response(JSON.stringify({ coverLetter: content }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
