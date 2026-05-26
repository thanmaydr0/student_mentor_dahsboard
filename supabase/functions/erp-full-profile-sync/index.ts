import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const FIRECRAWL_API_KEY = Deno.env.get('FIRECRAWL_API_KEY') ?? ''
const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') ?? ''
const ERP_PROFILE_URL = 'https://erp.cmrit.ac.in/stu_studentProfile.htm'
const ERP_DASHBOARD_URL = 'https://erp.cmrit.ac.in/dashboard.htm'

async function cleanDataWithAI(rawMarkdown: string, studentName: string) {
  const systemPrompt = `You are an expert data extraction AI.
You are given a raw, messy Markdown dump scraped from a university ERP system for a student named ${studentName}.
The data contains a lot of empty form fields, dropdown options (like lists of countries/years), and navigation menus which you MUST ignore.

Your job is to extract ONLY the actual filled-in information and organize it into a beautiful, highly professional Markdown report.
Use the following structure (if the data exists):
# Comprehensive ERP Profile: ${studentName}

## 👤 Personal Details
(Extract Name, Email, Phone, DOB, Blood Group, Category, etc.)

## 🏡 Address & Contact
(Extract Current & Permanent Address, Guardian details)

## 📚 Academic History
### 10th (SSC)
(Extract School, Board, Year, Marks/Percentage)

### 12th (HSC) / Diploma
(Extract School, Board, Stream, Year, Marks for Physics, Chemistry, Math, Biology, etc.)

## 🎯 Entrance Exams
(Extract Exam Name, Rank, Score, Percentile)

If any section has absolutely no data, omit it. Do not invent data. 
Format it cleanly using Markdown tables or bullet points where appropriate. Make it look like an official university document.`

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
        { role: 'user', content: `Here is the raw ERP markdown dump. Extract the real data:\n\n${rawMarkdown}` }
      ],
      temperature: 0.1
    })
  });

  if (!res.ok) {
    console.error('OpenAI Error', await res.text());
    return rawMarkdown; // fallback to raw if AI fails
  }

  const json = await res.json();
  return json.choices[0].message.content;
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!FIRECRAWL_API_KEY) throw new Error('FIRECRAWL_API_KEY is not configured.')
    if (!OPENAI_API_KEY) throw new Error('OPENAI_API_KEY is not configured.')

    const { student_id } = await req.json()
    if (!student_id) throw new Error('student_id is required.')

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Authenticate mentor
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (userError || !user) throw new Error('Unauthorized')

    // Verify student belongs to mentor
    const { data: studentCheck } = await supabaseClient
      .from('profiles')
      .select('id, full_name')
      .eq('id', student_id)
      .eq('mentor_id', user.id)
      .single()

    if (!studentCheck) throw new Error('Student not found or not in your cohort.')

    // Get ERP credentials
    const { data: cred } = await supabaseClient
      .from('erp_credentials')
      .select('username, password')
      .eq('student_id', student_id)
      .single()

    if (!cred) throw new Error('Student has not entered their ERP credentials.')

    // Step 1: Login natively
    const params = new URLSearchParams()
    params.append('j_username', cred.username)
    params.append('j_password', cred.password)

    const loginRes = await fetch('https://erp.cmrit.ac.in/j_spring_security_check', {
      method: 'POST',
      body: params,
      redirect: 'manual'
    })
    
    const cookieHeader = loginRes.headers.get('set-cookie') || ''
    const cookieMatch = cookieHeader.match(/JSESSIONID=([^;]+)/)
    
    if (!cookieMatch) throw new Error('Failed to authenticate with ERP (No session cookie). Check if credentials are correct.')
    const jsessionid = cookieMatch[0]

    // Step 2: Use Firecrawl to scrape the profile page
    // We scrape both Dashboard and Profile to get maximum data
    const firecrawlResponse = await fetch('https://api.firecrawl.dev/v1/scrape', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${FIRECRAWL_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        url: ERP_PROFILE_URL,
        formats: ['markdown'],
        headers: { 'Cookie': jsessionid },
        waitFor: 3000,
        timeout: 60000
      })
    })

    const firecrawlData = await firecrawlResponse.json()
    if (!firecrawlData.success) {
      throw new Error(`Firecrawl scraping failed: ${firecrawlData.error || JSON.stringify(firecrawlData)}`)
    }

    const rawMarkdown = firecrawlData.data?.markdown || ''
    if (rawMarkdown.length < 100) {
      throw new Error('Scraped content is too short, the ERP login might have expired.')
    }

    // Step 3: Use OpenAI to clean and format the messy data
    const cleanMarkdown = await cleanDataWithAI(rawMarkdown, studentCheck.full_name)

    return new Response(JSON.stringify({ 
      success: true, 
      markdown: cleanMarkdown,
      student_name: studentCheck.full_name 
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('ERP Scraper Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
