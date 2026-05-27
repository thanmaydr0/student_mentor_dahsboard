import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const FIRECRAWL_API_KEY = Deno.env.get('FIRECRAWL_API_KEY') ?? ''
const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') ?? ''

// All known ERP student profile tab URLs
// The JUNO ERP loads tabs via JS, but each tab also has a direct URL endpoint
const ERP_TAB_URLS = [
  { name: 'Personal Details', url: 'https://erp.cmrit.ac.in/stu_studentProfile.htm' },
  { name: 'Parent Details', url: 'https://erp.cmrit.ac.in/stu_parentDetails.htm' },
  { name: 'Guardian Details', url: 'https://erp.cmrit.ac.in/stu_guardianDetails.htm' },
  { name: 'Contact Details', url: 'https://erp.cmrit.ac.in/stu_contactDetails.htm' },
  { name: '10th Details', url: 'https://erp.cmrit.ac.in/stu_xDetails.htm' },
  { name: '12th Details', url: 'https://erp.cmrit.ac.in/stu_xiiDetails.htm' },
  { name: 'Diploma Details', url: 'https://erp.cmrit.ac.in/stu_diplomaDetails.htm' },
  { name: 'UG Details', url: 'https://erp.cmrit.ac.in/stu_ugDetails.htm' },
  { name: 'Certificates', url: 'https://erp.cmrit.ac.in/stu_certificates.htm' },
  { name: 'Projects Details', url: 'https://erp.cmrit.ac.in/stu_projectsDetails.htm' },
  { name: 'Work Experience', url: 'https://erp.cmrit.ac.in/stu_workExpDetails.htm' },
  { name: 'Technical Details', url: 'https://erp.cmrit.ac.in/stu_technicalDetails.htm' },
  { name: 'Training Details', url: 'https://erp.cmrit.ac.in/stu_trainingDetails.htm' },
  { name: 'Achievement', url: 'https://erp.cmrit.ac.in/stu_achievement.htm' },
  { name: 'Career Objectives', url: 'https://erp.cmrit.ac.in/stu_careerObjectives.htm' },
  { name: 'Entrance Details', url: 'https://erp.cmrit.ac.in/stu_entranceDetails.htm' },
  { name: 'Extra-curricular Activities', url: 'https://erp.cmrit.ac.in/stu_extraCurricularActivities.htm' },
  { name: 'Student Other Details', url: 'https://erp.cmrit.ac.in/stu_studentOtherDetails.htm' },
]

async function scrapeTab(url: string, cookie: string): Promise<string> {
  try {
    const res = await fetch('https://api.firecrawl.dev/v1/scrape', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${FIRECRAWL_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        url,
        formats: ['markdown'],
        headers: { 'Cookie': cookie },
        waitFor: 3000,
        timeout: 30000
      })
    })
    const data = await res.json()
    return data.data?.markdown || ''
  } catch (e) {
    console.warn(`Failed to scrape ${url}:`, e)
    return ''
  }
}

async function cleanDataWithAI(rawMarkdown: string, studentName: string) {
  const systemPrompt = `You are an expert data extraction AI.
You are given a MASSIVE raw Markdown dump scraped from EVERY tab of a university ERP system for a student named ${studentName}.
The data contains a lot of empty form fields, dropdown options (like lists of countries/years), and navigation menus which you MUST ignore.

Your job is to extract ONLY the actual filled-in information and organize it into a comprehensive, beautifully formatted Markdown report.
Use the following structure (include ONLY sections where actual data exists):

# Comprehensive ERP Profile: ${studentName}

## 👤 Personal Details
(Name, Email, Personal Email, Phone, DOB, Blood Group, Category, Gender, Nationality, Religion, Caste, Mother Tongue, etc.)

## 👨‍👩‍👦 Family Details
### Mother
(Name, Occupation, Phone, Email, Income)
### Father
(Name, Occupation, Phone, Email, Income)
### Guardian
(Name, Relation, Phone, Address)

## 🏡 Address & Contact
(Current Address, Permanent Address, Phone numbers)

## 📚 Academic History
### 10th (SSLC/SSC)
(School Name, Board, Year of Passing, Marks/Percentage, Register Number)

### 12th (PUC/HSC) / Diploma
(College Name, Board, Stream, Year, Individual Subject Marks for Physics, Chemistry, Math, Biology, etc., Percentage)

### UG Details
(University, College, Branch, Year of Admission, USN)

## 🎯 Entrance Exams
(KCET Rank, COMEDK Rank, JEE Score, or any other exam data)

## 🏆 Achievements & Activities
(Competitions won, Awards, Scholarships, Extra-curricular activities)

## 💼 Projects & Work Experience
(Project titles, descriptions, technologies, internships, work experience)

## 🎓 Certificates & Training
(Certifications, Training programs attended, Online courses)

## 💻 Technical Skills
(Programming languages, Tools, Frameworks, Technologies)

## 🎯 Career Objectives
(Career goals, Objectives stated by the student)

## 📋 Other Details
(Medical details, Gap details, Passport info, Bank details — ONLY if filled in)

CRITICAL RULES:
- Do NOT include any empty or "N/A" fields
- Do NOT include dropdown option lists (countries, years, etc.)
- Do NOT include navigation menu items
- Do NOT invent any data
- Use Markdown tables where structured data fits well
- Make it look like an official, premium university document
- If an entire section has no real data, OMIT it entirely`

  const res = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model: 'gpt-4o',
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: `Here is the raw ERP markdown dump from ALL tabs. Extract every piece of real data:\n\n${rawMarkdown.substring(0, 120000)}` }
      ],
      temperature: 0.1,
      max_tokens: 4096
    })
  });

  if (!res.ok) {
    console.error('OpenAI Error', await res.text());
    return rawMarkdown;
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

    // ============================
    // Step 1: Login to ERP
    // ============================
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

    console.log(`[ERP Deep Scraper] Logged in. Scraping ${ERP_TAB_URLS.length} tabs for ${studentCheck.full_name}...`)

    // ============================
    // Step 2: Scrape ALL tabs in parallel batches
    // ============================
    // Scrape in batches of 6 to avoid rate limiting
    const allMarkdown: string[] = []
    const BATCH_SIZE = 6
    
    for (let i = 0; i < ERP_TAB_URLS.length; i += BATCH_SIZE) {
      const batch = ERP_TAB_URLS.slice(i, i + BATCH_SIZE)
      const results = await Promise.all(
        batch.map(tab => scrapeTab(tab.url, jsessionid))
      )
      results.forEach((md, idx) => {
        if (md && md.length > 50) {
          allMarkdown.push(`\n\n--- TAB: ${batch[idx].name} ---\n\n${md}`)
        }
      })
      console.log(`[ERP Deep Scraper] Batch ${Math.floor(i / BATCH_SIZE) + 1} done. Got ${results.filter(r => r.length > 50).length}/${batch.length} tabs with data.`)
    }

    const combinedMarkdown = allMarkdown.join('\n\n')
    
    if (combinedMarkdown.length < 200) {
      throw new Error('Scraped content is too short across all tabs. The ERP session might have expired.')
    }

    console.log(`[ERP Deep Scraper] Total scraped: ${combinedMarkdown.length} chars from ${allMarkdown.length} tabs. Sending to AI...`)

    // ============================
    // Step 3: Use GPT-4o to clean and structure ALL the data
    // ============================
    const cleanMarkdown = await cleanDataWithAI(combinedMarkdown, studentCheck.full_name)

    return new Response(JSON.stringify({ 
      success: true, 
      markdown: cleanMarkdown,
      student_name: studentCheck.full_name,
      tabs_scraped: allMarkdown.length
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    console.error('ERP Deep Scraper Error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
