import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const SUBJECT_CREDITS: Record<string, number> = {
  // Semester 1
  'BMATS101': 4, 'BPHYS102': 4, 'BPOPS103': 3,
  'BESCK104': 3, 'BETCK105': 3, 'BPLCK105': 3,
  'BENGK106': 1, 'BPWSK106': 1, 'BKSKK107': 1, 'BKBKK107': 1, 'BICOK107': 1,
  'BIDTK158': 1, 'BSFHK158': 1,

  // Semester 2
  'BMATS201': 4, 'BCHES202': 4, 'BCEDK203': 3,
  'BESCK204': 3, 'BETCK205': 3, 'BPLCK205': 3,
  'BPWSK206': 1, 'BENGK206': 1, 'BICOK207': 1, 'BKSKK207': 1, 'BKBKK207': 1,
  'BSFHK258': 1, 'KIDTK258': 1,

  // Semester 3
  'BMATS301': 4, 'BCS301': 4, 'BCS302': 4, 'BCS303': 4,
  'BCS304': 3, 'BCSL305': 1,
  'BCS306': 3, 'BCS306A': 3, 'BCS306B': 3,
  'BSCK307': 1, 'BSCK307A': 1, 'BSCK307B': 1,
  'BNSK359': 0, 'BNSK358': 0,
  'BCS358A': 1, 'BCS358B': 1, 'BCS358C': 1,
}

function getCreditsForSubject(code: string): number | null {
  const upper = code.toUpperCase().trim()

  if (upper in SUBJECT_CREDITS) return SUBJECT_CREDITS[upper]

  const stripped = upper.replace(/[A-Z]$/, '')
  if (stripped !== upper && stripped in SUBJECT_CREDITS) return SUBJECT_CREDITS[stripped]

  const numMatch = upper.match(/(\d{3})[A-Z]?$/)
  if (numMatch) {
    const num = parseInt(numMatch[1])
    const lastTwo = num % 100
    if (lastTwo >= 1 && lastTwo <= 2) return 4
    if (lastTwo >= 3 && lastTwo <= 5) return 3
    if (lastTwo >= 6 && lastTwo <= 7) return 1
    if (lastTwo >= 50 && lastTwo <= 59) return 1
  }

  return null
}

function getGradePoint(total: number | null): number {
  if (total === null || total < 0) return 0
  if (total >= 90) return 10
  if (total >= 80) return 9
  if (total >= 70) return 8
  if (total >= 60) return 7
  if (total >= 55) return 6
  if (total >= 50) return 5
  if (total >= 40) return 4
  return 0
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { studentId, semester, subjects } = await req.json()

    if (!subjects || !Array.isArray(subjects)) {
      throw new Error('Subjects array is required')
    }

    let totalCredits = 0
    let totalWeighted = 0

    for (const subj of subjects) {
      if (!subj.code) continue
      const credits = getCreditsForSubject(subj.code)
      if (credits === null || credits === 0) continue

      const gp = getGradePoint(subj.total)
      totalCredits += credits
      totalWeighted += credits * gp
    }

    const sgpa = totalCredits > 0 ? (totalWeighted / totalCredits).toFixed(2) : null

    return new Response(JSON.stringify({ ok: true, sgpa }), {
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })

  } catch (error: any) {
    return new Response(JSON.stringify({ ok: false, error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })
  }
})
