import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const OPENAI_API_URL = 'https://api.openai.com/v1/chat/completions';

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const { query } = await req.json();

    if (!query) {
      throw new Error('Query is required');
    }

    const openAiKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAiKey) {
      throw new Error("OpenAI API Key is missing");
    }

    console.log(`[AISearch] Performing semantic expansion for query: "${query}"`);

    let semanticPayload = {
        core_subjects: [],
        context_filters: [],
        is_specific_subject: false
    };

    try {
      const rankRes = await fetch(OPENAI_API_URL, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${openAiKey}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          model: 'gpt-4o-mini',
          messages: [
            {
              role: 'system',
              content: `You are an NLP semantic search parser for a university library. Your job is to deeply understand a user's raw query and expand it into semantic components to filter a CSV database.

Rules:
1. Extract "core_subjects": The main topic/subject the user wants (e.g. "dbms", "machine learning"). Expand acronyms to their full forms, and add relevant subject codes if known (e.g. "dbms" -> ["dbms", "database management system", "sql", "relational database"]). Keep them lowercase.
2. Extract "context_filters": Other constraints like semester, year, or paper type (e.g. "4th sem" -> ["4th sem", "iv sem", "fourth semester", "4"]). Keep them lowercase.
3. Determine "is_specific_subject": Boolean true if the user asked for a specific topic (e.g. DBMS). False if they just asked generally (e.g. "4th sem question papers").

Respond strictly with a JSON object:
{
  "core_subjects": ["subject1", "subject2"],
  "context_filters": ["filter1", "filter2"],
  "is_specific_subject": true
}
`
            },
            {
              role: 'user',
              content: `Raw Query: "${query}"`
            }
          ],
          temperature: 0.1,
          max_tokens: 500,
        })
      });

      if (rankRes.ok) {
        const rankData = await rankRes.json();
        const content = rankData.choices[0].message.content.trim();
        const cleanContent = content.replace(/```json/g, '').replace(/```/g, '').trim();
        semanticPayload = JSON.parse(cleanContent);
        console.log(`[AISearch] Semantic expansion successful:`, semanticPayload);
      } else {
        const errorText = await rankRes.text();
        console.error("[AISearch] OpenAI Expansion failed", errorText);
        throw new Error("OpenAI failed");
      }
    } catch (e) {
      console.error("[AISearch] Error during AI expansion", e);
      // Fallback: manually parse
      const terms = query.toLowerCase().split(' ').filter((t: string) => t.length > 2);
      semanticPayload = {
          core_subjects: terms,
          context_filters: [],
          is_specific_subject: terms.length > 0
      };
    }

    return sendResponse({ 
      ok: true, 
      searchQuery: query,
      semanticPayload
    });

  } catch (error: any) {
    console.error(error);
    return new Response(JSON.stringify({ ok: false, error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

function sendResponse(data: any) {
  return new Response(JSON.stringify(data), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}
