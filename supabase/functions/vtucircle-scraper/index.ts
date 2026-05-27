import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const FIRECRAWL_API_KEY = Deno.env.get('FIRECRAWL_API_KEY') ?? ''
const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') ?? ''

async function callOpenAI(systemPrompt: string, userContent: string) {
  const res = await fetch('https://api.openai.com/v1/chat/completions', {
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
        { role: 'user', content: userContent }
      ],
      temperature: 0.1
    })
  })

  if (!res.ok) {
    const errText = await res.text()
    console.error('OpenAI raw error:', errText)
    throw new Error(`OpenAI Error: ${errText}`)
  }
  const data = await res.json()
  return JSON.parse(data.choices[0].message.content)
}

async function scrapeWithFirecrawl(url: string) {
  console.log(`  Firecrawl: Scraping ${url}...`)
  const res = await fetch('https://api.firecrawl.dev/v1/scrape', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${FIRECRAWL_API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      url: url,
      formats: ['markdown', 'links'],
      waitFor: 5000
    })
  })

  if (!res.ok) {
    const errText = await res.text()
    console.error('Firecrawl raw error:', errText)
    throw new Error(`Firecrawl Error scraping ${url}: ${errText}`)
  }
  const data = await res.json()
  const markdown = data.data?.markdown || ''
  const links = data.data?.links || []
  console.log(`  Firecrawl: Got ${markdown.length} chars of markdown, ${links.length} links`)
  return { markdown, links }
}

function getSemesterUrl(semester: string): string {
  const num = parseInt(semester)
  const suffixes: Record<number, string> = {
    1: '1st', 2: '2nd', 3: '3rd', 4: '4th',
    5: '5th', 6: '6th', 7: '7th', 8: '8th'
  }
  const suffix = suffixes[num] || `${num}th`
  return `https://vtucircle.com/${suffix}-semester-2022-scheme-aiml-ds/`
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!FIRECRAWL_API_KEY) throw new Error('FIRECRAWL_API_KEY is not configured.')
    if (!OPENAI_API_KEY) throw new Error('OPENAI_API_KEY is not configured.')

    const { semester, subject } = await req.json()
    
    if (!semester || !subject) {
      throw new Error('Semester and subject are required')
    }

    // Authenticate User
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (userError || !user) throw new Error('Unauthorized')

    // ==========================================
    // STEP 1: Scrape the SEMESTER page directly
    // ==========================================
    // URL pattern: https://vtucircle.com/3rd-semester-2022-scheme-aiml-ds/
    const semesterUrl = getSemesterUrl(semester)
    console.log(`[Step 1] Scraping semester page: ${semesterUrl}`)
    
    const { markdown: semMarkdown, links: semLinks } = await scrapeWithFirecrawl(semesterUrl)

    if (semMarkdown.length < 50) {
      throw new Error(`Failed to scrape semester ${semester} page. The page might not exist.`)
    }

    // ==========================================
    // STEP 2: AI Router - find the subject URL
    // ==========================================
    // Build a link context string for the AI to pick from
    const linkContext = semLinks.length > 0
      ? `\n\nHere are all links found on the page:\n${semLinks.map((l: string) => `- ${l}`).join('\n')}`
      : ''

    const routerPrompt = `You are a semantic URL router for VTU engineering subjects.
You are given a markdown scrape + list of links from a VTU Circle semester page.
The user wants notes for a subject they described as: "${subject}"

Analyze the page content and the links to find the URL that leads to the dedicated notes page for this subject.
Be FUZZY: "math" matches "Mathematics for Computer Science", "dsa" matches "Data Structures", "ddco" matches "Digital Design and Computer Organisation", etc.

Return a JSON object:
{
  "matchedUrl": "https://vtucircle.com/exact-url-to-subject-page/",
  "subjectName": "Full formal subject name as shown on the page"
}

If you truly cannot find any reasonable match, set matchedUrl to null.`

    console.log(`[Step 2] AI routing "${subject}" to exact URL...`)
    const routeResult = await callOpenAI(routerPrompt, `Page markdown:\n${semMarkdown}${linkContext}`)
    console.log(`[Step 2] AI result: ${JSON.stringify(routeResult)}`)

    if (!routeResult.matchedUrl) {
      return new Response(JSON.stringify({ 
        success: false, 
        error: `Could not find a subject matching "${subject}" for Semester ${semester}. Try using the full subject name.`,
        notes: []
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // ==========================================
    // STEP 3: Deep scrape the subject page
    // ==========================================
    console.log(`[Step 3] Deep scraping subject page: ${routeResult.matchedUrl}`)
    const { markdown: subjectMarkdown, links: subjectLinks } = await scrapeWithFirecrawl(routeResult.matchedUrl)

    const subjectLinkContext = subjectLinks.length > 0
      ? `\n\nHere are all links found on the subject page:\n${subjectLinks.map((l: string) => `- ${l}`).join('\n')}`
      : ''

    // ==========================================
    // STEP 4: Extract PDF / Drive download links
    // ==========================================
    const extractorPrompt = `You are an expert data extraction AI.
You are given a markdown scrape + links list from the VTU Circle notes page for the subject "${routeResult.subjectName}".

Your goal is to extract ALL download links for study materials. These could be:
- Direct PDF download links
- Google Drive links
- Module-wise notes links
- Question paper links
- Any other study resource links

Look carefully at both the markdown content AND the links list. Extract every relevant study material link you can find.

Return a JSON object:
{
  "notes": [
    {
      "title": "Descriptive title (e.g. 'Module 1 Notes', 'Previous Year Question Paper')",
      "url": "The full URL"
    }
  ]
}

If a link looks like a study resource (PDF, Google Drive, module notes), INCLUDE IT. Be generous, not strict.`

    console.log(`[Step 4] Extracting download links...`)
    const extractResult = await callOpenAI(extractorPrompt, `Subject page markdown:\n${subjectMarkdown}${subjectLinkContext}`)
    console.log(`[Step 4] Found ${extractResult.notes?.length || 0} downloadable resources.`)

    return new Response(JSON.stringify({ 
      success: true, 
      notes: extractResult.notes || [],
      matchedSubject: routeResult.subjectName
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('VTU Circle Scraper Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
