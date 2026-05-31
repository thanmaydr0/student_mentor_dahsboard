import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const FIRECRAWL_API_KEY = Deno.env.get('FIRECRAWL_API_KEY') ?? ''
const ERP_ATTENDANCE_URL = 'https://erp.cmrit.ac.in/studentCourses.htm?shwA=%2700A%27'
const ERP_LOGIN_URL = 'https://erp.cmrit.ac.in/'

// Subject matching patterns for the 4 subjects (mapped to ERP course names)
// IMPORTANT: Avoid short patterns like 'ada', 'dbms', 'dms' — they match as substrings
// of other words in the Firecrawl markdown, causing false extractions.
const SUBJECT_PATTERNS: Record<string, string[]> = {
  'dbms': ['database management', 'bcs403', 'bcs304'],
  'ai': ['artificial intelligence', 'bai402'],
  'dms': ['discrete mathematical', 'bcs405a'],
  'ada': ['analysis & design', 'analysis and design', 'design of algorithm', 'algorithm design', 'bcs401', 'bcsl404'],
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!FIRECRAWL_API_KEY) {
      throw new Error('FIRECRAWL_API_KEY is not configured. Please set it in your Supabase Edge Function secrets.')
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Authenticate the calling user (mentor)
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    
    if (userError || !user) {
      throw new Error('Unauthorized')
    }

    // Get mentor's students
    const { data: students, error: studentsErr } = await supabaseClient
      .from('profiles')
      .select('id, full_name')
      .eq('mentor_id', user.id)
      .eq('role', 'student')

    if (studentsErr || !students || students.length === 0) {
      return new Response(JSON.stringify({ message: 'No students found for this mentor.' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    const studentIds = students.map(s => s.id)

    // Get ERP credentials for those students
    const { data: credentials, error: credErr } = await supabaseClient
      .rpc('get_decrypted_erp_credentials', { p_student_ids: studentIds })

    if (credErr || !credentials || credentials.length === 0) {
      return new Response(JSON.stringify({ message: 'No ERP credentials found for your students. Ask them to update their profile.' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    let successCount = 0
    const errors: string[] = []

    // Process each student
    for (const cred of credentials) {
      try {
        const studentName = students.find(s => s.id === cred.student_id)?.full_name || 'Unknown'
        console.log(`Processing student: ${studentName} (${cred.username})`)

        // Step 1: Login natively via HTTP POST to get the JSESSIONID cookie
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
        
        if (!cookieMatch) {
          errors.push(`${studentName}: Failed to authenticate with ERP (No session cookie)`)
          continue
        }
        const jsessionid = cookieMatch[0]

        // Step 2: Use Firecrawl to scrape the attendance page, passing the session cookie!
        const firecrawlResponse = await fetch('https://api.firecrawl.dev/v1/scrape', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${FIRECRAWL_API_KEY}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            url: ERP_ATTENDANCE_URL,
            formats: ['markdown'],
            headers: {
              'Cookie': jsessionid
            },
            waitFor: 3000,
            timeout: 60000
          })
        })


        const firecrawlData = await firecrawlResponse.json()
        
        if (!firecrawlData.success) {
          console.error(`Firecrawl failed for ${studentName}:`, firecrawlData)
          const errMsg = firecrawlData.error || JSON.stringify(firecrawlData)
          errors.push(`${studentName}: Firecrawl failed - ${errMsg}`)
          continue
        }

        const markdown = firecrawlData.data?.markdown || ''
        console.log(`Got markdown for ${studentName}, length: ${markdown.length}`)

        if (markdown.length < 100) {
          errors.push(`${studentName}: Page content too short, login may have failed`)
          continue
        }

        // Step 2: Parse the markdown to extract attendance data
        // The ERP attendance page typically shows a table with columns like:
        // Subject | Classes Held | Classes Attended | Percentage
        // We need to find rows matching our 4 subjects and extract Theory + Lab separately

        // Get enrollments to find class_ids for each subject
        const { data: enrollments } = await supabaseClient
          .from('enrollments')
          .select('class_id, classes(subject_id, subjects(name))')
          .eq('student_id', cred.student_id)

        if (!enrollments || enrollments.length === 0) {
          errors.push(`${studentName}: No enrollments found`)
          continue
        }

        // IMPORTANT: Delete ALL old attendance records for this student first
        // This prevents stale duplicates from previous syncs
        await supabaseClient
          .from('erp_attendance_summary')
          .delete()
          .eq('student_id', cred.student_id)

        // Parse attendance from the markdown
        const lines = markdown.split('\n')

        // Iterate by SUBJECT_PATTERNS (not by enrollments) to guarantee one record per subject
        for (const [patternKey, patterns] of Object.entries(SUBJECT_PATTERNS)) {
          // Find the THEORY class_id for this subject from enrollments
          // Prefer the non-lab enrollment; fall back to any matching enrollment
          let theoryClassId = ''
          let anyClassId = ''
          for (const enrollment of enrollments) {
            const name = ((enrollment as any).classes?.subjects?.name || '').toLowerCase()
            const matchesPattern = patterns.some(p => name.includes(p))
            if (!matchesPattern) continue
            anyClassId = enrollment.class_id
            // Pick the non-lab class as the "theory" class_id
            if (!name.includes('lab') && !name.includes('practical') && !name.includes('laboratory')) {
              theoryClassId = enrollment.class_id
            }
          }
          const classId = theoryClassId || anyClassId
          if (!classId) continue // Student not enrolled in this subject

          // Search the markdown for lines matching this subject
          let theoryHeld = 0, theoryAttended = 0, theoryPercentage = 0
          let labHeld = 0, labAttended = 0, labPercentage = 0

          for (let i = 0; i < lines.length; i++) {
            const line = lines[i].toLowerCase()
            
            // Check if this line contains any of our subject patterns
            const matchesSubject = patterns.some(p => line.includes(p))
            if (!matchesSubject) continue

            // Only extract from lines that contain an attendance fraction (e.g. 33/37)
            const attendanceMatch = line.match(/(\d+)\s*\/\s*(\d+)/)
            if (!attendanceMatch) continue

            const attended = parseInt(attendanceMatch[1], 10)
            const held = parseInt(attendanceMatch[2], 10)
            let percentage = 0
            if (held > 0) {
              percentage = parseFloat(((attended / held) * 100).toFixed(2))
            }

            // Check if this line indicates a lab
            const isLab = line.includes('lab') || line.includes('practical') || line.includes('laboratory') || /bcsl|bds/i.test(line)

            // FIRST-WIN: Only set values if not already set.
            // The real attendance table rows appear first in the markdown;
            // later false matches from other sections must not overwrite.
            if (isLab) {
              if (labHeld === 0) {
                labHeld = held
                labAttended = attended
                labPercentage = percentage
              }
            } else {
              if (theoryHeld === 0) {
                theoryHeld = held
                theoryAttended = attended
                theoryPercentage = percentage
              }
            }
          }

          // Insert into erp_attendance_summary (we deleted old records above, so just insert)
          const { error: upsertErr } = await supabaseClient
            .from('erp_attendance_summary')
            .upsert({
              student_id: cred.student_id,
              class_id: classId,
              theory_held: theoryHeld,
              theory_attended: theoryAttended,
              theory_percentage: theoryPercentage,
              lab_held: labHeld,
              lab_attended: labAttended,
              lab_percentage: labPercentage,
              updated_at: new Date().toISOString()
            }, { onConflict: 'student_id,class_id' })

          if (upsertErr) {
            console.error(`Upsert error for ${studentName}/${patternKey}:`, upsertErr)
          }

          // DEBUG: If everything is 0, output a snippet
          if (theoryHeld === 0 && labHeld === 0) {
            const pattern = patterns[0]
            const idx = markdown.toLowerCase().indexOf(pattern)
            let snippet = ''
            if (idx !== -1) {
              const start = Math.max(0, idx - 100)
              const end = Math.min(markdown.length, idx + 300)
              snippet = markdown.substring(start, end).replace(/\n/g, ' || ')
            } else {
              snippet = 'SUBJECT NOT FOUND IN MARKDOWN: ' + markdown.substring(0, 200).replace(/\n/g, ' ')
            }
            errors.push(`${studentName} ${patternKey} was 0/0. Debug: ${snippet}`)
          }
        }

        successCount++
      } catch (err) {
        const studentName = students.find(s => s.id === cred.student_id)?.full_name || 'Unknown'
        console.error(`Error processing student ${studentName}:`, err)
        errors.push(`${studentName}: ${(err as Error).message}`)
      }
    }

    const message = errors.length > 0
      ? `Synced ${successCount}/${credentials.length}. Errors: ${errors.join(' | ')}`
      : `Successfully synced ERP attendance for ${successCount} students.`

    return new Response(JSON.stringify({ message, successCount, errors, debug: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err: any) {
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
