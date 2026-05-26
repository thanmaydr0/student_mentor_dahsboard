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

    const { text, role, company } = await req.json()
    
    if (!text) {
      throw new Error('Text is required to enhance.')
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Authenticate user
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    
    if (userError || !user) {
      throw new Error('Unauthorized')
    }

    const systemPrompt = `You are an expert resume writer and career coach.
You are given a draft bullet point from a resume for a "${role}" role at "${company}".
Your task is to rewrite it to be highly professional, impactful, and ATS-optimized.
Use the XYZ formula: "Accomplished [X] as measured by [Y], by doing [Z]".
Start with a strong action verb (e.g., Spearheaded, Engineered, Orchestrated, Optimized).
Quantify results where possible (if no numbers exist, make the impact sound significant but plausible).
Return ONLY the rewritten text, without quotes, bullet characters, or conversational filler.`

    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: `Draft text: ${text}` }
        ],
        temperature: 0.7,
        max_tokens: 100
      })
    })

    if (!res.ok) {
      const errorText = await res.text()
      console.error('OpenAI Error', errorText)
      throw new Error('AI generation failed')
    }

    const json = await res.json()
    const enhancedText = json.choices[0].message.content.trim()

    return new Response(JSON.stringify({ 
      success: true, 
      enhancedText 
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('Enhance Bullet Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
