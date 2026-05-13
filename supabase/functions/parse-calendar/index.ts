import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) throw new Error('No authorization header')

    const body = await req.json()
    const { calendar_text, images } = body
    // images: Array<{ data: string (base64), mime_type: string }>

    if (!calendar_text && (!images || images.length === 0)) {
      throw new Error('Either calendar_text or at least one image/document is required')
    }

    const systemPrompt = `You are an AI academic calendar parser. The student has uploaded their college/university "Calendar of Events" or "Academic Calendar" as text and/or images.

Your task is to extract EVERY event, holiday, exam period, and significant academic date from the document.

For each event, determine:
1. The event name/title
2. The date or date range (use ISO format YYYY-MM-DD when possible, otherwise use descriptive text)
3. How many working days are affected (classes lost)
4. The category: one of "national", "religious", "regional", "academic", "exam", "cultural"
5. Whether it's a holiday (no classes) or a reduced-schedule day

Return ONLY a JSON object with this exact schema:
{
  "institution_name": "Name of the institution if visible in the document",
  "academic_year": "e.g. 2025-2026",
  "semester": "Odd/Even/Full Year if determinable",
  "events": [
    {
      "name": "Event or Holiday Name",
      "start_date": "YYYY-MM-DD or descriptive like 'Feb/Mar'",
      "end_date": "YYYY-MM-DD or null if single day",
      "days_off": 1,
      "category": "national|religious|regional|academic|exam|cultural",
      "is_holiday": true,
      "description": "Brief note if relevant"
    }
  ],
  "total_holidays": 0,
  "total_working_days_lost": 0,
  "semester_start": "YYYY-MM-DD or descriptive",
  "semester_end": "YYYY-MM-DD or descriptive",
  "summary": "A brief 2-3 sentence summary of the academic calendar"
}

Be thorough — extract EVERY event, even minor ones. Include exam periods, fests, workshops, orientations, etc.
Do not include any markdown formatting like \`\`\`json. Return raw JSON.`

    // Build user content parts (multi-modal)
    const userParts: any[] = []

    let textContent = ''
    if (calendar_text) {
      textContent += `Academic Calendar / Calendar of Events:\n${calendar_text}`
    }
    if (textContent) {
      userParts.push({ type: 'text', text: textContent })
    }

    // Add image content — only actual image MIME types (OpenAI rejects PDFs as image_url)
    const SUPPORTED_IMAGE_MIMES = ['image/jpeg', 'image/png', 'image/gif', 'image/webp']
    if (images && images.length > 0) {
      if (!textContent) {
        userParts.push({ type: 'text', text: 'Please parse this academic calendar document/image and extract all events and holidays.' })
      }
      const validImages = images.filter((img: any) => SUPPORTED_IMAGE_MIMES.includes(img.mime_type))
      const skippedPdfs = images.filter((img: any) => img.mime_type === 'application/pdf')

      for (const img of validImages) {
        userParts.push({
          type: 'image_url',
          image_url: {
            url: `data:${img.mime_type};base64,${img.data}`,
            detail: 'high'
          }
        })
      }

      // If only PDFs were uploaded (no images, no text), return a helpful error
      if (validImages.length === 0 && !textContent) {
        throw new Error('PDF files cannot be processed directly. Please upload the calendar as an image (JPG/PNG) — take a screenshot of the PDF or convert it to an image.')
      }

      // Note skipped PDFs in the text context
      if (skippedPdfs.length > 0 && validImages.length > 0) {
        userParts.push({ type: 'text', text: `Note: ${skippedPdfs.length} PDF file(s) were skipped. Only images are processed.` })
      }
    }

    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        temperature: 0.1,
        max_tokens: 4000,
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userParts }
        ]
      })
    })

    if (!openaiRes.ok) {
      const errText = await openaiRes.text()
      throw new Error(`OpenAI error: ${errText}`)
    }

    const openaiData = await openaiRes.json()
    const rawContent = openaiData.choices?.[0]?.message?.content
    if (!rawContent) throw new Error('Empty response from OpenAI')

    const parsed = JSON.parse(rawContent)

    return new Response(JSON.stringify(parsed), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
