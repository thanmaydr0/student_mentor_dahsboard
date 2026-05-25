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
    const { messages } = await req.json()

    if (!messages || !Array.isArray(messages)) {
      throw new Error('Missing or invalid messages array')
    }

    const systemPrompt = {
      role: 'system',
      content: `You are a specialized Career Assistant AI on the EduPredict platform.
Your goal is to help students with resume building, interview preparation, salary negotiation, and job search strategies.
Do NOT answer general knowledge questions outside of career/academic advice. Politely redirect them back to career topics.`
    }

    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o',
        temperature: 0.7,
        messages: [systemPrompt, ...messages]
      })
    })

    if (!openaiRes.ok) {
       throw new Error(`OpenAI Request Failed: ${await openaiRes.text()}`)
    }

    const openaiData = await openaiRes.json()
    const reply = openaiData.choices?.[0]?.message?.content?.trim()

    return new Response(JSON.stringify({ reply }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
