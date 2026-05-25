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
    const { text } = await req.json()

    if (!text) {
      throw new Error('Missing text')
    }

    const systemPrompt = `You are an expert ATS (Applicant Tracking System) parser and recruiter. 
Your goal is to aggressively extract information from the raw resume text provided, even if the text is messy, unformatted, or missing labels.

Extract the information and return a pure JSON object in this EXACT format:
{
  "name": "Full Name",
  "email": "Email Address",
  "summary": "Professional Summary (combine and summarize the best professional introduction you can find)",
  "experience": [{ "company": "", "role": "", "description": "Combine the bullet points" }],
  "education": [{ "school": "", "degree": "", "year": "" }]
}
If a field is missing, try to infer it. If it absolutely cannot be found, leave it as an empty string. Do NOT wrap the output in markdown code blocks. Return only raw JSON.`

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
           { role: 'user', content: text }
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
