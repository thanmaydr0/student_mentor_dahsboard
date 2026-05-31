import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const BASE_URL = 'https://results.vtu.ac.in/D25J26Ecbcs/'
const MAX_CAPTCHA_RETRIES = 3
const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36'

// VTU's server only sends its leaf certificate without the intermediate chain.
// Deno (unlike browsers) cannot auto-discover missing intermediates, so we
// provide the full Sectigo chain here.
const SECTIGO_INTERMEDIATE_CA = `-----BEGIN CERTIFICATE-----
MIIGTDCCBDSgAwIBAgIQOXpmzCdWNi4NqofKbqvjsTANBgkqhkiG9w0BAQwFADBf
MQswCQYDVQQGEwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMTYwNAYDVQQD
Ey1TZWN0aWdvIFB1YmxpYyBTZXJ2ZXIgQXV0aGVudGljYXRpb24gUm9vdCBSNDYw
HhcNMjEwMzIyMDAwMDAwWhcNMzYwMzIxMjM1OTU5WjBgMQswCQYDVQQGEwJHQjEY
MBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMTcwNQYDVQQDEy5TZWN0aWdvIFB1Ymxp
YyBTZXJ2ZXIgQXV0aGVudGljYXRpb24gQ0EgRFYgUjM2MIIBojANBgkqhkiG9w0B
AQEFAAOCAY8AMIIBigKCAYEAljZf2HIz7+SPUPQCQObZYcrxLTHYdf1ZtMRe7Yeq
RPSwygz16qJ9cAWtWNTcuICc++p8Dct7zNGxCpqmEtqifO7NvuB5dEVexXn9RFFH
12Hm+NtPRQgXIFjx6MSJcNWuVO3XGE57L1mHlcQYj+g4hny90aFh2SCZCDEVkAja
EMMfYPKuCjHuuF+bzHFb/9gV8P9+ekcHENF2nR1efGWSKwnfG5RawlkaQDpRtZTm
M64TIsv/r7cyFO4nSjs1jLdXYdz5q3a4L0NoabZfbdxVb+CUEHfB0bpulZQtH1Rv
38e/lIdP7OTTIlZh6OYL6NhxP8So0/sht/4J9mqIGxRFc0/pC8suja+wcIUna0HB
pXKfXTKpzgis+zmXDL06ASJf5E4A2/m+Hp6b84sfPAwQ766rI65mh50S0Di9E3Pn
2WcaJc+PILsBmYpgtmgWTR9eV9otfKRUBfzHUHcVgarub/XluEpRlTtZudU5xbFN
xx/DgMrXLUAPaI60fZ6wA+PTAgMBAAGjggGBMIIBfTAfBgNVHSMEGDAWgBRWc1hk
lfmSGrASKgRieaFAFYghSTAdBgNVHQ4EFgQUaMASFhgOr872h6YyV6NGUV3LBycw
DgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYI
KwYBBQUHAwEGCCsGAQUFBwMCMBsGA1UdIAQUMBIwBgYEVR0gADAIBgZngQwBAgEw
VAYDVR0fBE0wSzBJoEegRYZDaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
UHVibGljU2VydmVyQXV0aGVudGljYXRpb25Sb290UjQ2LmNybDCBhAYIKwYBBQUH
AQEEeDB2ME8GCCsGAQUFBzAChkNodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3Rp
Z29QdWJsaWNTZXJ2ZXJBdXRoZW50aWNhdGlvblJvb3RSNDYucDdjMCMGCCsGAQUF
BzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
YtOC9Fy+TqECFw40IospI92kLGgoSZGPOSQXMBqmsGWZUQ7rux7cj1du6d9rD6C8
ze1B2eQjkrGkIL/OF1s7vSmgYVafsRoZd/IHUrkoQvX8FZwUsmPu7amgBfaY3g+d
q1x0jNGKb6I6Bzdl6LgMD9qxp+3i7GQOnd9J8LFSietY6Z4jUBzVoOoz8iAU84OF
h2HhAuiPw1ai0VnY38RTI+8kepGWVfGxfBWzwH9uIjeooIeaosVFvE8cmYUB4TSH
5dUyD0jHct2+8ceKEtIoFU/FfHq/mDaVnvcDCZXtIgitdMFQdMZaVehmObyhRdDD
4NQCs0gaI9AAgFj4L9QtkARzhQLNyRf87Kln+YU0lgCGr9HLg3rGO8q+Y4ppLsOd
unQZ6ZxPNGIfOApbPVf5hCe58EZwiWdHIMn9lPP6+F404y8NNugbQixBber+x536
WrZhFZLjEkhp7fFXf9r32rNPfb74X/U90Bdy4lzp3+X1ukh1BuMxA/EEhDoTOS3l
7ABvc7BYSQubQ2490OcdkIzUh3ZwDrakMVrbaTxUM2p24N6dB+ns2zptWCva6jzW
r8IWKIMxzxLPv5Kt3ePKcUdvkBU/smqujSczTzzSjIoR5QqQA6lN1ZRSnuHIWCvh
JEltkYnTAH41QJ6SAWO66GrrUESwN/cgZzL4JLEqz1Y=
-----END CERTIFICATE-----`

const SECTIGO_ROOT_CA = `-----BEGIN CERTIFICATE-----
MIIFijCCA3KgAwIBAgIQdY39i658BwD6qSWn4cetFDANBgkqhkiG9w0BAQwFADBf
MQswCQYDVQQGEwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMTYwNAYDVQQD
Ey1TZWN0aWdvIFB1YmxpYyBTZXJ2ZXIgQXV0aGVudGljYXRpb24gUm9vdCBSNDYw
HhcNMjEwMzIyMDAwMDAwWhcNNDYwMzIxMjM1OTU5WjBfMQswCQYDVQQGEwJHQjEY
MBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMTYwNAYDVQQDEy1TZWN0aWdvIFB1Ymxp
YyBTZXJ2ZXIgQXV0aGVudGljYXRpb24gUm9vdCBSNDYwggIiMA0GCSqGSIb3DQEB
AQUAA4ICDwAwggIKAoICAQCTvtU2UnXYASOgHEdCSe5jtrch/cSV1UgrJnwUUxDa
ef0rty2k1Cz66jLdScK5vQ9IPXtamFSvnl0xdE8H/FAh3aTPaE8bEmNtJZlMKpnz
SDBh+oF8HqcIStw+KxwfGExxqjWMrfhu6DtK2eWUAtaJhBOqbchPM8xQljeSM9xf
iOefVNlI8JhD1mb9nxc4Q8UBUQvX4yMPFF1bFOdLvt30yNoDN9HWOaEhUTCDsG3X
ME6WW5HwcCSrv0WBZEMNvSE6Lzzpng3LILVCJ8zab5vuZDCQOc2TZYEhMbUjUDM3
IuM47fgxMMxF/mL50V0yeUKH32rMVhlATc6qu/m1dkmU8Sf4kaWD5QazYw6A3OAS
VYCmO2a0OYctyPDQ0RTp5A1NDvZdV3LFOxxHVp3i1fuBYYzMTYCQNFu31xR13NgE
SJ/AwSiItOkcyqex8Va3e0lMWeUgFaiEAin6OJRpmkkGj80feRQXEgyDet4fsZfu
+Zd4KKTIRJLpfSYFplhym3kT2BFfrsU4YjRosoYwjviQYZ4ybPUHNs2iTG7sijbt
8uaZFURww3y8nDnAtOFr94MlI1fZEoDlSfB1D++N6xybVCi0ITz8fAr/73trdf+L
HaAZBav6+CuBQug4urv7qv094PPK306Xlynt8xhW6aWWrL3DkJiy4Pmi1KZHQ3xt
zwIDAQABo0IwQDAdBgNVHQ4EFgQUVnNYZJX5khqwEioEYnmhQBWIIUkwDgYDVR0P
AQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEMBQADggIBAC9c
mTz8Bl6MlC5w6tIyMY208FHVvArzZJ8HXtXBc2hkeqK5Duj5XYUtqDdFqij0lgVQ
YKlJfp/imTYpE0RHap1VIDzYm/EDMrraQKFz6oOht0SmDpkBm+S8f74TlH7Kph52
gDY9hAaLMyZlbcp+nv4fjFg4exqDsQ+8FxG75gbMY/qB8oFM2gsQa6H61SilzwZA
Fv97fRheORKkU55+MkIQpiGRqRxOF3yEvJ+M0ejf5lG5Nkc/kLnHvALcWxxPDkjB
JYOcCj+esQMzEhonrPcibCTRAUH4WAP+JWgiH5paPHxsnnVI84HxZmduTILA7rpX
DhjvLpr3Etiga+kFpaHpaPi8TD8SHkXoUsCjvxInebnMMTzD9joiFgOgyY9mpFui
TdaBJQbpdqQACj7LzTWb4OE4y2BThihCQRxEV+ioratF4yUQvNs+ZUH7G6aXD+u5
dHn5HrwdVw1Hr8Mvn4dGp+smWg9WY7ViYG4A++MnESLn/pmPNPW56MORcr3Ywx65
LvKRRFHQV80MNNVIIb/bE/FmJUNS0nAiNs2fxBx1IK1jcmMGDw4nztJqDby1ORrp
0XZ60Vzk50lJLVU3aPAaOpg+VBeHVOmmJ1CJeyAvP/+/oYtKR5j/K3tJPsMpRmAY
QqszKbrAKbkTidOIijlBO8n9pu0f9GBj39ItVQGL
-----END CERTIFICATE-----`

// @ts-ignore Deno-specific API
const vtuClient = Deno.createHttpClient({
  caCerts: [SECTIGO_INTERMEDIATE_CA, SECTIGO_ROOT_CA],
})

// Wrapper around fetch that uses the custom client for VTU requests
function vtuFetch(url: string | URL, init?: RequestInit): Promise<Response> {
  return fetch(url, { ...init, client: vtuClient } as any)
}

// ── Helpers ──────────────────────────────────────────────────────────────────

function extractHiddenToken(html: string): string {
  const tokenMatch = html.match(/name=["']Token["']\s+value=["']([^"']+)["']/i)
  return tokenMatch?.[1] || ''
}

function decodeHtmlEntities(str: string): string {
  return str
    .replace(/&amp;amp;/g, '&')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
}

function extractCaptchaImageUrl(html: string): string | null {
  // VTU actual format (May 2026):
  //   <img src="/captcha/vtu_captcha.php?_CAPTCHA&amp;amp;t=0.01594900+1778606664" alt="CAPTCHA code">
  // The src can use single or double quotes, and contains HTML-encoded ampersands.
  const patterns = [
    // Match img with src containing "captcha" and .php
    /<\s*img[^>]+src\s*=\s*["']([^"']*captcha[^"']*\.php[^"']*)["']/i,
    // Match img with alt containing "captcha"
    /<\s*img[^>]+alt\s*=\s*["'][^"']*captcha[^"']*["'][^>]*src\s*=\s*["']([^"']+)["']/i,
    // Match img with src before alt, alt containing "captcha"
    /<\s*img[^>]+src\s*=\s*["']([^"']+)["'][^>]*alt\s*=\s*["'][^"']*captcha[^"']*["']/i,
    // Broadest: any img src containing "captcha"
    /<\s*img[^>]+src\s*=\s*["']([^"']*captcha[^"']*)["']/i,
  ]

  for (const pattern of patterns) {
    const match = html.match(pattern)
    if (match?.[1]) {
      // Decode HTML entities in the URL (VTU uses &amp;amp; for &)
      return decodeHtmlEntities(match[1])
    }
  }

  return null
}

function stripTags(value: string): string {
  return value
    .replace(/<br\s*\/?>/gi, ' ')
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/\s+/g, ' ')
    .trim()
}

function normalizeText(value: string): string {
  return stripTags(value).replace(/\s+/g, ' ').trim()
}

interface SubjectResult {
  code: string
  name: string
  internal: number | null
  external: number | null
  total: number | null
  result: string  // P, F, A, W, X, NE
  passed: boolean
}

interface ResultSummary {
  usn?: string
  name?: string
  branch?: string
  semester?: string
  result?: string
  sgpa?: string
  cgpa?: string
  subjects?: SubjectResult[]
  totalSubjects?: number
  passedSubjects?: number
  failedSubjects?: number
  [key: string]: any
}

// Clean leading ": " prefix that VTU adds to values
function cleanValue(val: string): string {
  return val.replace(/^\s*:\s*/, '').trim()
}

function extractSummaryFromHtml(html: string): ResultSummary {
  const summary: ResultSummary = {}

  // ── Phase 1: Extract metadata from <tr>/<td> rows (USN, Name, etc.) ──
  const trRows = [...html.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)]
  for (const row of trRows) {
    const cells = [...row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)]
      .map((match) => normalizeText(match[1]))
      .filter(Boolean)

    if (cells.length < 2) continue

    const label = cells[0].toLowerCase()
    const value = cleanValue(cells.slice(1).join(' ').trim())

    if (!summary.usn && /usn|university\s*seat/i.test(label)) summary.usn = value
    if (!summary.name && /(student\s*)?name|candidate/i.test(label)) summary.name = value
    if (!summary.branch && /branch|programme|program/i.test(label)) summary.branch = value
    if (!summary.sgpa && /sgpa/i.test(label)) summary.sgpa = value
    if (!summary.cgpa && /cgpa/i.test(label)) summary.cgpa = value
  }

  // ── Phase 1b: Extract semester from standalone div ──
  // VTU puts "Semester : 3" in a standalone <div>, not a table
  const semMatch = html.match(/Semester\s*:\s*(\d+)/i)
  if (semMatch) summary.semester = semMatch[1]

  // ── Phase 2: Extract subject data from div-based table ──
  // VTU uses: <div class="divTableRow"> containing <div class="divTableCell">
  // Columns: Code | Name | Internal | External | Total | Result (P/F/A) | Date
  const subjects: SubjectResult[] = []

  // Match each divTableCell content
  const divRowPattern = /class\s*=\s*"divTableRow"[^>]*>([\s\S]*?)(?=<div\s[^>]*class\s*=\s*"divTableRow"|<\/div>\s*<\/div>\s*<\/div>)/gi
  const divRowMatches = [...html.matchAll(divRowPattern)]

  for (const rowMatch of divRowMatches) {
    const rowContent = rowMatch[1]
    const cellMatches = [...rowContent.matchAll(/class\s*=\s*"divTableCell"[^>]*>([\s\S]*?)<\/div>/gi)]
    const cells = cellMatches.map((m) => normalizeText(m[1]))

    if (cells.length < 5) continue

    const firstCell = cells[0].trim()
    // VTU subject codes: BCS301, BCSL305, BSCK307, BNSK359, BCS358A, BCS306A
    if (!/^[A-Z]{1,5}[A-Z0-9]{2,8}$/i.test(firstCell)) continue
    // Skip header row ("Subject Code")
    if (/subject\s*code/i.test(firstCell)) continue

    const subjectCode = firstCell
    const subjectName = cells[1] || ''
    const internal = parseInt(cells[2], 10)
    const external = parseInt(cells[3], 10)
    const total = parseInt(cells[4], 10)
    const resultCode = (cells[5] || '').toUpperCase().trim()

    // P = Pass, F = Fail, A = Absent, W = Withheld, X/NE = Not Eligible
    const passed = resultCode === 'P'

    subjects.push({
      code: subjectCode,
      name: subjectName,
      internal: isNaN(internal) ? null : internal,
      external: isNaN(external) ? null : external,
      total: isNaN(total) ? null : total,
      result: resultCode,
      passed,
    })
  }

  summary.subjects = subjects

  if (subjects.length > 0) {
    const passedCount = subjects.filter((s) => s.passed).length
    const failedCount = subjects.length - passedCount

    summary.totalSubjects = subjects.length
    summary.passedSubjects = passedCount
    summary.failedSubjects = failedCount

    // Overall result: FAIL if ANY subject is not P
    summary.result = failedCount > 0 ? 'FAIL' : 'PASS'
  }

  return summary
}

function isCaptchaError(html: string): boolean {
  const text = html.toLowerCase()
  return (
    text.includes('captcha') && (
      text.includes('invalid') ||
      text.includes('wrong') ||
      text.includes('incorrect') ||
      text.includes('enter captcha')
    )
  )
}

function extractSessionCookie(res: Response): string {
  const cookieHeader = res.headers.get('set-cookie')
  if (!cookieHeader) return ''
  const cookiePair = cookieHeader.split(';')[0]
  return cookiePair || ''
}

// ── AI Captcha Solver ────────────────────────────────────────────────────────

async function solveCaptchaWithAI(imageBase64: string, mimeType: string): Promise<string> {
  const apiKey = Deno.env.get('OPENAI_API_KEY')
  if (!apiKey) throw new Error('OPENAI_API_KEY is not configured on the server')

  const res = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: 'gpt-4o-mini',
      temperature: 0,
      max_tokens: 50,
      messages: [
        {
          role: 'system',
          content:
            'You are a captcha reader. The user will send you an image of a captcha. ' +
            'Your ONLY job is to read the exact characters shown in the captcha image and return them. ' +
            'Return ONLY the captcha text — no quotes, no explanation, no extra whitespace. ' +
            'The captcha is typically 6 alphanumeric characters.',
        },
        {
          role: 'user',
          content: [
            {
              type: 'text',
              text: 'Read this captcha image and return ONLY the characters you see. No other text.',
            },
            {
              type: 'image_url',
              image_url: {
                url: `data:${mimeType};base64,${imageBase64}`,
                detail: 'high',
              },
            },
          ],
        },
      ],
    }),
  })

  if (!res.ok) {
    const errText = await res.text()
    throw new Error(`OpenAI vision error (${res.status}): ${errText}`)
  }

  const data = await res.json()
  const raw = data.choices?.[0]?.message?.content || ''
  // Clean up any accidental whitespace or quotes from the model
  return raw.replace(/['"` \n\r\t]/g, '').trim()
}

// ── Single Attempt (one session) ─────────────────────────────────────────────
// All steps use the SAME cookies so the captcha stays valid.

async function attemptFetch(normalizedUsn: string, baseUrl: string, manualCaptcha?: string): Promise<{
  ok: boolean
  html: string
  summary: ResultSummary
  message: string
  captchaUsed: string
}> {
  const commonHeaders = {
    'user-agent': UA,
    'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  }

  // 1. Fetch the VTU form page → get token + session cookie
  const initialRes = await vtuFetch(baseUrl, { headers: commonHeaders })
  if (!initialRes.ok) throw new Error(`Failed to load VTU form (${initialRes.status})`)

  const initialHtml = await initialRes.text()
  const token = extractHiddenToken(initialHtml)
  if (!token) throw new Error('Could not find VTU form token')

  const sessionCookie = extractSessionCookie(initialRes)

  // 2. Determine captcha text
  let captchaText: string

  if (manualCaptcha) {
    // Caller provided a manual override (backwards compatible)
    captchaText = manualCaptcha.trim()
  } else {
    // Auto-solve: find captcha image URL, download it, send to AI
    const captchaRelUrl = extractCaptchaImageUrl(initialHtml)
    if (!captchaRelUrl) {
      throw new Error(
        'Could not locate the captcha image on the VTU page. ' +
        'VTU may have changed their page layout.'
      )
    }

    const captchaFullUrl = new URL(captchaRelUrl, baseUrl).toString()

    // Download captcha image with the SAME session cookie
    const captchaHeaders: Record<string, string> = {
      ...commonHeaders,
      'referer': baseUrl,
    }
    if (sessionCookie) captchaHeaders['cookie'] = sessionCookie

    const imgRes = await vtuFetch(captchaFullUrl, { headers: captchaHeaders })
    if (!imgRes.ok) throw new Error(`Failed to download captcha image (${imgRes.status})`)

    const imgBuffer = await imgRes.arrayBuffer()
    const imgBytes = new Uint8Array(imgBuffer)

    // Convert to base64
    let binary = ''
    for (let i = 0; i < imgBytes.length; i++) {
      binary += String.fromCharCode(imgBytes[i])
    }
    const imageBase64 = btoa(binary)

    const contentType = imgRes.headers.get('content-type') || 'image/png'

    // Ask AI to read the captcha
    captchaText = await solveCaptchaWithAI(imageBase64, contentType)
    if (!captchaText || captchaText.length < 3) {
      throw new Error(`AI returned an implausible captcha reading: "${captchaText}"`)
    }
  }

  // 3. Submit the form with the SAME session cookie
  const submitHeaders: Record<string, string> = {
    'content-type': 'application/x-www-form-urlencoded',
    'user-agent': UA,
    'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'origin': baseUrl.replace(/\/$/, ''),
    'referer': baseUrl,
  }
  if (sessionCookie) submitHeaders['cookie'] = sessionCookie

  const body = new URLSearchParams({
    Token: token,
    lns: normalizedUsn,
    captchacode: captchaText,
  })

  const resultRes = await vtuFetch(new URL('resultpage.php', baseUrl).toString(), {
    method: 'POST',
    headers: submitHeaders,
    body,
  })

  const html = await resultRes.text()
  const summary = extractSummaryFromHtml(html)

  // Add debug info about the HTML structure
  const allRows = [...html.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)]
  const debugRows: { cellCount: number; cells: string[] }[] = []
  for (const row of allRows.slice(0, 20)) {
    const cells = [...row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)]
      .map((m) => normalizeText(m[1]))
    debugRows.push({ cellCount: cells.length, cells: cells.slice(0, 4) })
  }
  summary._debug = {
    totalRows: allRows.length,
    htmlLength: html.length,
    sampleRows: debugRows,
    subjectsFound: summary.subjects?.length ?? 0,
  }

  const captchaFailed = isCaptchaError(html)
  const ok = resultRes.ok && !captchaFailed && html.length > 0

  const message = captchaFailed
    ? `Captcha rejected by VTU (tried: "${captchaText}").`
    : ok
      ? 'Result fetched successfully.'
      : 'VTU did not return a valid result page.'

  return { ok, html, summary, message, captchaUsed: captchaText }
}

// ── Main Handler ─────────────────────────────────────────────────────────────

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) return new Response(JSON.stringify({ ok: false, message: 'Unauthorized' }), { status: 401, headers: corsHeaders })
    
    const { createClient } = await import('https://esm.sh/@supabase/supabase-js@2.39.3')
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    const { data: { user }, error: authErr } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authErr || !user) return new Response(JSON.stringify({ ok: false, message: 'Unauthorized' }), { status: 401, headers: corsHeaders })

    const { usn, captcha, resultUrl } = await req.json()

    if (!usn || typeof usn !== 'string') {
      throw new Error('USN is required')
    }

    const normalizedUsn = usn.trim().toUpperCase()
    const manualCaptcha = captcha && typeof captcha === 'string' ? captcha.trim() : undefined
    // Allow caller to specify which VTU result URL to scrape (for multi-semester support)
    // Strip trailing filenames like index.php so URL resolution of resultpage.php works correctly
    let effectiveBaseUrl = BASE_URL
    if (resultUrl && typeof resultUrl === 'string') {
      let cleaned = resultUrl.trim()
      // Remove trailing filename (e.g. index.php) to get just the directory
      cleaned = cleaned.replace(/\/[^\/]*\.[a-z]+$/i, '/')
      if (!cleaned.endsWith('/')) cleaned += '/'
      effectiveBaseUrl = cleaned
    }

    // Retry loop — each attempt starts a fresh VTU session so the captcha
    // image and session cookie are always in sync.
    let lastResult: Awaited<ReturnType<typeof attemptFetch>> | null = null
    const maxAttempts = manualCaptcha ? 1 : MAX_CAPTCHA_RETRIES

    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
      lastResult = await attemptFetch(normalizedUsn, effectiveBaseUrl, manualCaptcha)

      if (lastResult.ok) {
        return new Response(JSON.stringify({
          ok: true,
          usn: normalizedUsn,
          message: lastResult.message,
          summary: lastResult.summary,
          html: lastResult.html,
          captchaUsed: lastResult.captchaUsed,
          attempts: attempt,
        }), {
          headers: { ...corsHeaders, 'content-type': 'application/json' },
        })
      }

      // If captcha was manually provided, don't retry
      if (manualCaptcha) break

      // Small delay before retry to avoid hammering VTU
      if (attempt < maxAttempts) {
        await new Promise((r) => setTimeout(r, 1000))
      }
    }

    // All attempts failed
    return new Response(JSON.stringify({
      ok: false,
      usn: normalizedUsn,
      message: lastResult?.message || 'All captcha attempts failed.',
      captchaUsed: lastResult?.captchaUsed,
      attempts: maxAttempts,
    }), {
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })
  } catch (error: any) {
    // Include detailed diagnostics so we can debug
    const debugInfo: Record<string, any> = {}
    try {
      const res = await vtuFetch(BASE_URL, {
        headers: { 'user-agent': UA, 'accept': 'text/html' },
      })
      const html = await res.text()
      debugInfo.vtuStatus = res.status
      debugInfo.vtuHtmlLength = html.length
      debugInfo.vtuHtmlSnippet = html.substring(0, 500)
      debugInfo.tokenFound = !!extractHiddenToken(html)
      debugInfo.captchaUrlFound = extractCaptchaImageUrl(html)
    } catch (debugErr: any) {
      debugInfo.debugFetchError = debugErr?.message
    }

    return new Response(JSON.stringify({
      ok: false,
      message: error?.message || 'Unexpected VTU fetch error',
      error_stack: error?.stack?.substring(0, 300),
      debug: debugInfo,
    }), {
      status: 400,
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })
  }
})

