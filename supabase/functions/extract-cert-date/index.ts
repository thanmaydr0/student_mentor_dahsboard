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
    if (!OPENAI_API_KEY) throw new Error('OPENAI_API_KEY is not configured.')

    const bodyText = await req.text()
    if (!bodyText) throw new Error('Request body is empty')
    
    const body = JSON.parse(bodyText)
    const { cert_url } = body
    
    if (!cert_url) {
      throw new Error('cert_url is required in the request body')
    }

    const authHeader = req.headers.get('Authorization')
    if (!authHeader) throw new Error('Missing Authorization header')

    // Authenticate User
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (userError || !user) throw new Error('Unauthorized or invalid token')

    console.log(`Starting extraction for cert: ${cert_url}`)

    const systemPrompt = `You are a strict data extraction AI. 
Analyze the provided certificate or event image and extract:
1. "title": The name of the event, competition, or hackathon (e.g., "HackCMRIT", "Web Dev Workshop").
2. "event_date": The date of the event in "YYYY-MM-DD" format. If a range is given, use the final date. If the year is missing, assume the current year. If no date is visible, return null.
3. "event_time": The time of the event if visible (e.g., "10:00 AM"). If not, return null.

Return ONLY a JSON object matching this schema:
{
  "title": "Event Name",
  "event_date": "YYYY-MM-DD" | null,
  "event_time": "10:00 AM" | null
}`

    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4o', // Switched to gpt-4o for robust vision parsing
        response_format: { type: "json_object" },
        messages: [
          { role: 'system', content: systemPrompt },
          { 
            role: 'user', 
            content: [
              { type: "text", text: "Extract details from this certificate. Output JSON." },
              { type: "image_url", image_url: { url: cert_url } }
            ]
          }
        ],
        temperature: 0.1
      })
    })

    if (!res.ok) {
      const errText = await res.text()
      console.error('OpenAI raw error:', errText)
      throw new Error(`OpenAI API failed: ${errText}`)
    }

    const data = await res.json()
    const extractedData = JSON.parse(data.choices[0].message.content)
    
    console.log(`Extraction complete:`, extractedData)

    return new Response(JSON.stringify({ 
      success: true, 
      data: extractedData
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })

  } catch (err: any) {
    console.error('Extract Cert Date Error:', err.message)
    return new Response(JSON.stringify({ error: err.message, success: false }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
