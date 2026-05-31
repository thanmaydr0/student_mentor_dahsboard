import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { parse } from "https://deno.land/std@0.224.0/csv/mod.ts";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

Deno.serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: corsHeaders })
    
    const { createClient } = await import('https://esm.sh/@supabase/supabase-js@2.39.3')
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    const { data: { user }, error: authErr } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authErr || !user) return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: corsHeaders })

    const { subjectName = '' } = await req.json().catch(() => ({}));

    // Map subject to the correct Google Sheet URL
    const name = subjectName.toLowerCase();
    let sheetUrl = '';

    if (name.includes('dbms') || name.includes('database')) {
      sheetUrl = 'https://docs.google.com/spreadsheets/d/12F0G2TvKIjyu20RaD6KsoW8cL-Y3vIL-nsOWTOw2bEI/edit?usp=sharing';
    } else if (name.includes('ai') || name.includes('artificial intelligence') || name.includes('intelligent')) {
      sheetUrl = 'https://docs.google.com/spreadsheets/d/1I0JQV1tkREDBHHO8OrpIS96APP11BubHFKidM5TWCLM/edit?usp=sharing';
    } else if (name.includes('dms') || name.includes('discrete')) {
      sheetUrl = 'https://docs.google.com/spreadsheets/d/1_A66F2R5nHmBpY91etJSEyo0vDmcbAitS958cVMQyMY/edit?usp=sharing';
    } else if (name.includes('ada') || name.includes('algorithm')) {
      sheetUrl = 'https://docs.google.com/spreadsheets/d/1I1spF0fO6-0DRupjmb6LiN8fQ9JV8qlZnUF9Qq_KSYY/edit?usp=sharing';
    } else {
      return new Response(JSON.stringify({ error: `No sheet linked for subject: ${subjectName || 'Unknown'}` }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Extract the sheet ID from the URL
    // Format: https://docs.google.com/spreadsheets/d/1Xy.../edit
    const match = sheetUrl.match(/\/d\/([a-zA-Z0-9-_]+)/);
    if (!match || !match[1]) {
      return new Response(JSON.stringify({ error: 'Invalid Google Sheets URL' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }
    const sheetId = match[1];

    // Fetch the CSV export
    const exportUrl = `https://docs.google.com/spreadsheets/d/${sheetId}/export?format=csv`;
    const response = await fetch(exportUrl);
    
    if (!response.ok) {
      return new Response(
        JSON.stringify({ error: `Failed to fetch sheet: ${response.statusText}. Make sure it is 'Anyone with the link can view'.` }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      );
    }

    const csvText = await response.text();

    // Parse the CSV
    const records = parse(csvText, {
      skipFirstRow: true, // Uses the first row as object keys
      strip: true, // Trim whitespace
    });

    return new Response(
      JSON.stringify({
        data: records,
        sheetId,
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
