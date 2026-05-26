import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const FIRECRAWL_API_KEY = Deno.env.get('FIRECRAWL_API_KEY') ?? ''
const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') ?? ''

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!FIRECRAWL_API_KEY) throw new Error('FIRECRAWL_API_KEY is not configured.')
    if (!OPENAI_API_KEY) throw new Error('OPENAI_API_KEY is not configured.')

    const { type, domain, skills } = await req.json()
    
    if (!type) {
      throw new Error('Type is required')
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (userError || !user) throw new Error('Unauthorized')

    const targetUrl = type === 'internship' ? 'https://unstop.com/internships' : 'https://unstop.com/jobs'
    console.log(`Starting Firecrawl scrape for ${targetUrl}...`)

    // Step 1: Scrape raw markdown with a delay to let React render the job cards
    const firecrawlRes = await fetch('https://api.firecrawl.dev/v1/scrape', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${FIRECRAWL_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        url: targetUrl,
        formats: ['markdown'],
        waitFor: 5000 // Unstop takes time to load listings
      })
    })

    if (!firecrawlRes.ok) {
      throw new Error(`Firecrawl scraping failed: ${await firecrawlRes.text()}`)
    }

    const firecrawlData = await firecrawlRes.json()
    const rawMarkdown = firecrawlData.data?.markdown || ''
    
    if (rawMarkdown.length < 100) {
      throw new Error('Scraped content is too short. Unstop might be blocking or taking too long to load.')
    }

    // Step 2: Use OpenAI to extract jobs. Be highly lenient!
    const systemPrompt = `You are an expert data extraction AI. You are given a raw markdown scrape of the Unstop.com opportunities page.
The user's domain is "${domain}" and their skills are: "${skills.join(', ')}".

Your goal is to extract a list of 10-20 job/internship opportunities from this markdown.
CRITICAL INSTRUCTION: Try to prioritize opportunities that vaguely match the user's domain or skills. HOWEVER, if there are no exact matches, DO NOT RETURN EMPTY. You MUST extract WHATEVER opportunities are visible on the page (even if they are completely unrelated). The user would rather see unrelated jobs than an empty page.

Output the data as a JSON object strictly matching this schema:
{
  "opportunities": [
    {
      "company": "Company Name",
      "role": "Job Title",
      "location": "Location (e.g. Remote, Bangalore)",
      "stipend": "Salary or Stipend (if mentioned)",
      "description": "A very brief 1-sentence summary of the role",
      "link": "The URL link to apply (must be a valid URL starting with https://unstop.com)",
      "deadline": "Deadline (if mentioned)"
    }
  ]
}`

    console.log("Sending to OpenAI for extraction...")
    const aiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        response_format: { type: "json_object" },
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: `Here is the raw markdown. Extract the opportunities as JSON.\n\n${rawMarkdown}` }
        ],
        temperature: 0.2
      })
    })

    if (!aiRes.ok) {
      throw new Error(`OpenAI extraction failed: ${await aiRes.text()}`)
    }

    const aiData = await aiRes.json()
    const extractedContent = JSON.parse(aiData.choices[0].message.content)
    
    console.log(`Extraction complete. Found ${extractedContent.opportunities?.length || 0} matches.`)

    return new Response(JSON.stringify({ 
      success: true, 
      opportunities: extractedContent.opportunities || []
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('Unstop Scraper Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
