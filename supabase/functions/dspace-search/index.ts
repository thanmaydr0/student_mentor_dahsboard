import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const BASE_URL = 'http://203.201.63.46:8080';
const OPENAI_API_URL = 'https://api.openai.com/v1/chat/completions';

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const { query, useAi } = await req.json();

    if (!query) {
      throw new Error('Query is required');
    }

    // 1. If NOT using AI, just do a basic search
    if (!useAi) {
      const searchUrl = `${BASE_URL}/jspui/simple-search?query=${encodeURIComponent(query)}`;
      const dspaceRes = await fetch(searchUrl);
      const html = await dspaceRes.text();
      const results = extractLinks(html);
      return sendResponse({ ok: true, searchQuery: query, results, isDeepScan: false });
    }

    const openAiKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAiKey) {
      throw new Error("OpenAI API Key is missing");
    }

    console.log(`[DeepScan] Starting analysis for: "${query}"`);

    // --- STAGE 1: AI Query Expansion ---
    let expandedQueries = [query];
    try {
      const expandRes = await fetch(OPENAI_API_URL, {
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
              content: `Generate 2 broad search keywords for a college repository. Return a JSON array of strings. Example for "dbms papers": ["DBMS", "Database Management"]`
            },
            { role: 'user', content: query }
          ],
          temperature: 0.3,
          max_tokens: 50,
        })
      });
      
      if (expandRes.ok) {
        const expandData = await expandRes.json();
        const content = expandData.choices[0].message.content.trim();
        // Clean markdown if AI accidentally included it
        const cleanContent = content.replace(/```json/g, '').replace(/```/g, '').trim();
        expandedQueries = JSON.parse(cleanContent);
        console.log(`[DeepScan] Expanded to:`, expandedQueries);
      }
    } catch (e) {
      console.error("[DeepScan] Query expansion failed, using original query.", e);
    }

    // --- STAGE 2: Deep Parallel Scraping ---
    console.log(`[DeepScan] Scraping DSpace for expanded queries...`);
    const allRawResults = new Map<string, string>(); // url -> title
    
    const fetchWithTimeout = async (url: string, timeoutMs: number = 4000) => {
      const controller = new AbortController();
      const id = setTimeout(() => controller.abort(), timeoutMs);
      try {
        const res = await fetch(url, { signal: controller.signal });
        clearTimeout(id);
        if (!res.ok) return "";
        return await res.text();
      } catch (e) {
        clearTimeout(id);
        return "";
      }
    };

    // 2A: Classic Search (finds historical indexed items)
    const fetchPromises = [];
    const queriesToFetch = expandedQueries.slice(0, 3);
    for (const q of queriesToFetch) {
      const url1 = `${BASE_URL}/jspui/simple-search?query=${encodeURIComponent(q)}&rpp=100`;
      fetchPromises.push(fetchWithTimeout(url1));
    }

    const htmlPages = await Promise.all(fetchPromises);
    for (const html of htmlPages) {
      if (!html) continue;
      const links = extractLinks(html);
      for (const link of links) {
        allRawResults.set(link.url, link.title);
      }
    }

    // 2B: EXTREME BRUTE FORCE RECENT ITEMS (Bypass broken DSpace Index!)
    console.log(`[DeepScan] Running EXTREME Brute Force Scrape...`);
    // The user wants absolute depth. We scan 500 items.
    const bruteStart = 7300;
    const bruteCount = 500;
    
    // Create lowercase matchers
    const matchers = expandedQueries.map(q => q.toLowerCase());
    
    // Batch the brute force to NOT crash the college server (15 at a time)
    // and give each request a huge 10 second timeout so it doesn't abort silently
    const batchSize = 15;
    for (let i = 0; i < bruteCount; i += batchSize) {
      const batchPromises = [];
      for (let j = 0; j < batchSize; j++) {
        const handleId = bruteStart - (i + j);
        const url = `${BASE_URL}/jspui/handle/123456789/${handleId}`;
        batchPromises.push(
          fetchWithTimeout(url, 10000).then(html => {
            if (!html) return;
            const lowerHtml = html.toLowerCase();
            // If the raw HTML of the item page contains any of our expanded queries
            const hasMatch = matchers.some(m => lowerHtml.includes(m));
            if (hasMatch) {
              const titleMatch = html.match(/<title>(.*?)<\/title>/i);
              let title = titleMatch ? titleMatch[1] : `Unknown Paper (${handleId})`;
              title = title.replace("DSpace at My University: ", "").trim();
              
              // Extract the PDF filename too if possible, to give AI more context
              const pdfMatch = html.match(/>([^<]+\.pdf)<\/a>/i);
              if (pdfMatch) {
                 title = `${title} (Contains: ${pdfMatch[1]})`;
              }
              
              allRawResults.set(url, title);
            }
          })
        );
      }
      await Promise.all(batchPromises);
    }

    const rawList = Array.from(allRawResults.entries()).map(([url, title]) => ({ url, title }));
    console.log(`[DeepScan] Gathered ${rawList.length} unique raw resources.`);

    if (rawList.length === 0) {
      return sendResponse({ ok: true, results: [], isDeepScan: true });
    }

    // --- STAGE 3: Smart AI Analysis & Ranking ---
    console.log(`[DeepScan] Sending ${rawList.length} items to AI for ranking...`);
    
    let finalCuratedResults = [];

    // Limit to top 100 to maximize deep search without crashing OpenAI
    const candidates = rawList.slice(0, 100);

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
              content: `You are a librarian. Find the BEST matches for the user's request from the JSON list. 
CRITICAL RULE: If the user searches for a specific subject (like DBMS, SQL), DO NOT discard broad semester bundles (like 'Computer Science IV Sem' or 'MCA III Sem'). These bundles contain all subjects for that semester, so they are HIGHLY RELEVANT and should be kept with high confidence.
Return a JSON array of objects: [{"url": "url", "title": "title", "reason": "1-sentence reason", "confidence": 95}]. Max 8 results.`
            },
            {
              role: 'user',
              content: `Request: "${query}"\n\nDocs:\n${JSON.stringify(candidates)}`
            }
          ],
          temperature: 0.2,
          max_tokens: 1500,
        })
      });

      if (rankRes.ok) {
        const rankData = await rankRes.json();
        const content = rankData.choices[0].message.content.trim();
        const cleanContent = content.replace(/```json/g, '').replace(/```/g, '').trim();
        finalCuratedResults = JSON.parse(cleanContent);
        console.log(`[DeepScan] AI returned ${finalCuratedResults.length} curated results.`);
      } else {
        const errorText = await rankRes.text();
        console.error("[DeepScan] OpenAI Ranking failed", errorText);
        // Fallback to returning top 10 raw results
        finalCuratedResults = candidates.slice(0, 10).map(c => ({...c, reason: "Fallback (AI offline)", confidence: 50}));
      }
    } catch (e) {
      console.error("[DeepScan] Error during AI ranking", e);
      finalCuratedResults = candidates.slice(0, 10).map(c => ({...c, reason: "Fallback (Error)", confidence: 50}));
    }

    return sendResponse({ 
      ok: true, 
      searchQuery: query,
      isDeepScan: true,
      rawCount: rawList.length,
      results: finalCuratedResults 
    });

  } catch (error) {
    console.error(error);
    return new Response(JSON.stringify({ ok: false, error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

// Helper functions

function extractLinks(html: string) {
  const results = [];
  const linkRegex = /<a\s+href="(\/jspui\/handle\/[^"]+)"[^>]*>([\s\S]*?)<\/a>/gi;
  const seenUrls = new Set();
  
  let match;
  while ((match = linkRegex.exec(html)) !== null) {
    const rawUrl = match[1];
    let title = match[2].trim().replace(/<[^>]*>?/gm, '').trim();

    if (!title || title.toLowerCase() === 'view' || title.toLowerCase() === 'open') {
      continue;
    }

    if (!seenUrls.has(rawUrl)) {
      seenUrls.add(rawUrl);
      results.push({
        title,
        url: `${BASE_URL}${rawUrl}`
      });
    }
  }
  return results;
}

function sendResponse(data: any) {
  return new Response(JSON.stringify(data), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}
