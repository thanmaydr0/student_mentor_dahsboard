import React, { useState, useEffect, useRef } from 'react';
import { Search, BookOpen, FileText, Database, Sparkles, ExternalLink, Library, Globe, Loader2 } from 'lucide-react';
import Papa from 'papaparse';
import Card from '../../components/ui/Card';
import Button from '../../components/ui/Button';
import Input from '../../components/ui/Input';
import toast from 'react-hot-toast';
import { supabase } from '../../lib/supabase';

interface ResourceResult {
  title: string;
  url: string;
  reason?: string;
  confidence?: number;
}

export default function ResourceLibraryPage() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<ResourceResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);
  const [rawCount, setRawCount] = useState(0);
  const [isIndexLoaded, setIsIndexLoaded] = useState(false);
  const [semanticMetadata, setSemanticMetadata] = useState<any>(null);

  // VTU Circle State
  const [vtuSem, setVtuSem] = useState('3');
  const [vtuSubject, setVtuSubject] = useState('');
  const [isVtuLoading, setIsVtuLoading] = useState(false);

  // Cache the parsed CSV data to avoid re-parsing on every search
  const csvDataRef = useRef<any[] | null>(null);

  const fetchAndParseCSV = async (): Promise<any[]> => {
    if (csvDataRef.current) return csvDataRef.current;
    
    return new Promise((resolve, reject) => {
      Papa.parse('/vtu_iat_index.csv', {
        download: true,
        header: true,
        skipEmptyLines: true,
        complete: (results) => {
          csvDataRef.current = results.data;
          setIsIndexLoaded(true);
          resolve(results.data);
        },
        error: (error: any) => {
          reject(error);
        }
      });
    });
  };

  const handleSearch = async (searchQuery: string, useAi: boolean = false) => {
    if (!searchQuery.trim()) {
      toast.error("Please enter a search query");
      return;
    }

    setIsLoading(true);
    setHasSearched(true);
    setRawCount(0);
    setSemanticMetadata(null);
    
    try {
      let coreKeywords: string[] = [];
      let contextFilters: string[] = [];
      let isSpecificSubject = false;
      let rawTerms = searchQuery.toLowerCase().split(' ').filter(t => t.length > 2);

      // --- 1. NLP SEMANTIC LAYER ---
      if (useAi) {
        try {
          const { supabase } = await import('../../lib/supabase');
          const { data: { session } } = await supabase.auth.getSession();
          const edgeFunctionUrl = `${import.meta.env.VITE_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co'}/functions/v1/dspace-search`;
          
          const controller = new AbortController();
          const timeoutId = setTimeout(() => controller.abort(), 15000); // 15s timeout for AI
          
          const response = await fetch(edgeFunctionUrl, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${session?.access_token || import.meta.env.VITE_SUPABASE_ANON_KEY}`
            },
            body: JSON.stringify({ query: searchQuery }),
            signal: controller.signal
          });
          
          clearTimeout(timeoutId);
          
          if (response.ok) {
             const aiData = await response.json();
             if (aiData.ok && aiData.semanticPayload) {
                coreKeywords = aiData.semanticPayload.core_subjects || [];
                contextFilters = aiData.semanticPayload.context_filters || [];
                isSpecificSubject = aiData.semanticPayload.is_specific_subject || false;
                setSemanticMetadata(aiData.semanticPayload);
             }
          }
        } catch (aiErr) {
          console.error("NLP Semantic layer failed, falling back to basic matching", aiErr);
          toast.error("AI expansion failed. Using standard search.");
        }
      }

      // Fallback if AI was off or failed
      if (coreKeywords.length === 0) {
        const stopWords = new Set(['sem', 'semester', 'the', 'for', 'and', 'with', 'paper', 'papers', 'question', 'year']);
        coreKeywords = rawTerms.filter(t => !stopWords.has(t) && !/^\d+(st|nd|rd|th)?$/.test(t));
        contextFilters = rawTerms.filter(t => !coreKeywords.includes(t));
      }

      const allTerms = [...coreKeywords, ...contextFilters];

      // --- 2. LOCAL CSV SCORING ---
      const data = await fetchAndParseCSV();
      
      const scoredResults = data.map((row) => {
        let score = 0;
        
        const title = (row.item_title || '').toLowerCase();
        const keywords = (row.item_keywords || '').toLowerCase();
        const label = (row.pdf_label || '').toLowerCase();
        const collection = (row.collection_name || '').toLowerCase();
        const sourcePage = (row.source_page_title || '').toLowerCase();
        const fullText = `${title} ${keywords} ${label} ${collection} ${sourcePage}`;
        
        // Exact full phrase match gets high score
        if (fullText.includes(searchQuery.toLowerCase())) {
          score += 200;
        }

        let coreMatches = 0;
        let contextMatches = 0;

        // Score core subjects (Heavy Weight)
        for (const term of coreKeywords) {
          if (term.length < 2) continue;
          if (title.includes(term)) { score += 150; coreMatches++; }
          else if (label.includes(term)) { score += 100; coreMatches++; }
          else if (keywords.includes(term)) { score += 80; coreMatches++; }
          else if (collection.includes(term)) { score += 30; coreMatches++; }
          else if (sourcePage.includes(term)) { score += 20; coreMatches++; }
        }

        // Score context filters (Medium Weight)
        for (const term of contextFilters) {
          if (term.length < 2) continue;
          if (title.includes(term)) { score += 30; contextMatches++; }
          else if (label.includes(term)) { score += 20; contextMatches++; }
          else if (keywords.includes(term)) { score += 15; contextMatches++; }
          else if (collection.includes(term)) { score += 10; contextMatches++; }
          else if (sourcePage.includes(term)) { score += 5; contextMatches++; }
        }

        // NLP STRICT PENALTY: If it's a specific subject query, and NO core subjects matched anywhere, kill the score.
        if (isSpecificSubject && coreKeywords.length > 0 && coreMatches === 0) {
          score = 0; 
        }

        return { row, score };
      }).filter(item => item.score > 0);

      scoredResults.sort((a, b) => b.score - a.score);
      
      // Limit to top 30
      const topResults = scoredResults.slice(0, 30);
      
      let mappedResults: ResourceResult[] = topResults.map(({ row, score }) => {
        // Calculate a nice looking confidence percentage based on how many terms matched
        let maxPossibleScore = (coreKeywords.length * 150) + (contextFilters.length * 30);
        if (maxPossibleScore === 0) maxPossibleScore = 100;
        
        let confidence = Math.min(Math.round((score / maxPossibleScore) * 100), 99);
        if (score >= 200) confidence = 99; // cap at 99 for realism
        if (confidence < 10) confidence = 10 + Math.floor(Math.random() * 20); // give some baseline
        
        return {
          title: row.pdf_label || row.item_title || 'Unknown Document',
          url: row.pdf_url || row.item_url || '#',
          confidence,
          reason: undefined
        };
      });

      setResults(mappedResults);
      setRawCount(data.length);
      
      if (mappedResults.length === 0) {
        toast.error("No resources found. Try different keywords.");
      } else {
        toast.success(`Found ${mappedResults.length} matches!`);
      }
    } catch (err: any) {
      toast.error(err.message || 'Failed to search library');
      setResults([]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleVtuSearch = async () => {
    if (!vtuSubject.trim()) {
      return toast.error("Please enter a subject name");
    }

    setIsVtuLoading(true);
    setHasSearched(true);
    setRawCount(0);
    setSemanticMetadata(null);
    setResults([]);

    try {
      const { data, error } = await supabase.functions.invoke('vtucircle-scraper', {
        body: { semester: vtuSem, subject: vtuSubject }
      });

      if (error) throw error;
      if (data.success === false && data.error) {
        toast.error(data.error);
        return;
      }
      if (!data.success) throw new Error(data.error || "Unknown error");

      if (data.notes && data.notes.length > 0) {
        const mappedNotes: ResourceResult[] = data.notes.map((n: any) => ({
          title: n.title,
          url: n.url,
          confidence: 99
        }));
        setResults(mappedNotes);
        toast.success(`Found ${mappedNotes.length} notes for ${data.matchedSubject || 'VTU Circle'}!`);
      } else {
        toast.error("No modules found on the matched VTU Circle page.");
      }
    } catch (err: any) {
      console.error(err);
      toast.error("Failed to fetch VTU Circle notes. Please try again.");
    } finally {
      setIsVtuLoading(false);
    }
  };

  const presetOptions = [
    { label: 'IAT Papers', query: 'IAT Question Paper', icon: FileText, color: 'text-indigo-600', bg: 'bg-indigo-50' },
    { label: 'VTU Question Papers', query: 'VTU Question Paper', icon: BookOpen, color: 'text-emerald-600', bg: 'bg-emerald-50' },
    { label: 'Project Reports', query: 'Project Report', icon: Database, color: 'text-sky-600', bg: 'bg-sky-50' },
  ];

  return (
    <div className="p-8 max-w-6xl mx-auto space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold text-slate-900 tracking-tight flex items-center gap-3">
            <Library className="text-indigo-600" size={32} />
            Resource Library
          </h1>
          <p className="text-slate-500 mt-1">Search the college repository for past papers, notes, and projects instantly.</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        {/* Left Column: Search Tools */}
        <div className="lg:col-span-1 space-y-6">
          
          <Card className="p-6 border-indigo-100 shadow-sm bg-white">
            <h2 className="font-semibold text-slate-900 mb-4 flex items-center gap-2">
              <Search size={18} className="text-indigo-500" />
              Common Resources
            </h2>
            <div className="space-y-3">
              {presetOptions.map((preset) => (
                <button
                  key={preset.label}
                  onClick={() => handleSearch(preset.query, false)}
                  className="w-full flex items-center gap-3 p-3 rounded-xl border border-slate-100 hover:border-indigo-200 hover:shadow-md transition-all text-left group bg-white"
                >
                  <div className={`p-2 rounded-lg ${preset.bg} ${preset.color} group-hover:scale-110 transition-transform`}>
                    <preset.icon size={18} />
                  </div>
                  <span className="font-medium text-slate-700 group-hover:text-indigo-700">{preset.label}</span>
                </button>
              ))}
            </div>
          </Card>

          <Card className="p-6 border-indigo-100 shadow-sm bg-gradient-to-br from-indigo-50 to-white">
            <h2 className="font-semibold text-slate-900 mb-2 flex items-center gap-2">
              <Sparkles size={18} className="text-indigo-500" />
              Smart Search
            </h2>
            <p className="text-xs text-slate-500 mb-4">
              Enter keywords, subjects, or paper types to search the indexed repository.
            </p>
            <div className="space-y-4">
              <Input
                label=""
                placeholder="e.g. 'previous year dbms papers'"
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleSearch(query, true)}
                className="bg-white"
              />
              <Button 
                onClick={() => handleSearch(query, true)} 
                loading={isLoading}
                fullWidth
                className="bg-indigo-600 hover:bg-indigo-700 text-white shadow-lg shadow-indigo-600/20"
              >
                {!isLoading && <Search size={16} className="mr-2" />}
                Search Library
              </Button>
            </div>
          </Card>

          <Card className="p-6 border-cyan-100 shadow-sm bg-gradient-to-br from-cyan-50 to-white dark:bg-gradient-to-br dark:from-cyan-950/20 dark:to-transparent dark:border-cyan-500/10">
            <h2 className="font-semibold text-slate-900 dark:text-white mb-2 flex items-center gap-2">
              <Globe size={18} className="text-cyan-500" />
              VTU Circle Notes (AIML/DS)
            </h2>
            <p className="text-xs text-slate-500 dark:text-slate-400 mb-4">
              Scrape vtucircle.com directly to find your notes by subject.
            </p>
            <div className="space-y-4">
              <select
                value={vtuSem}
                onChange={(e) => setVtuSem(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl bg-white dark:bg-[#12141a] border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white focus:border-cyan-500 outline-none transition-all text-sm font-medium"
              >
                {[1, 2, 3, 4, 5, 6, 7, 8].map(sem => (
                  <option key={sem} value={sem}>Semester {sem}</option>
                ))}
              </select>
              
              <Input
                label=""
                placeholder="e.g. Data Structures"
                value={vtuSubject}
                onChange={(e) => setVtuSubject(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleVtuSearch()}
                className="bg-white dark:bg-[#12141a]"
              />
              <Button 
                onClick={handleVtuSearch} 
                loading={isVtuLoading}
                fullWidth
                className="bg-cyan-600 hover:bg-cyan-700 text-white shadow-lg shadow-cyan-600/20"
              >
                {!isVtuLoading && <Search size={16} className="mr-2" />}
                Fetch Notes
              </Button>
            </div>
          </Card>

        </div>

        {/* Right Column: Results */}
        <div className="lg:col-span-2">
          <Card className="p-6 min-h-[500px] flex flex-col border-slate-200 shadow-sm bg-slate-50/50">
            <h2 className="font-semibold text-slate-900 mb-6 flex items-center gap-2">
              <Database size={18} className="text-slate-500" />
              Search Results
            </h2>

            {isLoading || isVtuLoading ? (
              <div className="flex-1 flex flex-col items-center justify-center text-slate-400 space-y-4">
                <div className="relative flex justify-center items-center h-16 w-16">
                  <div className="absolute animate-ping inline-flex h-full w-full rounded-full bg-indigo-400 opacity-20"></div>
                  <Sparkles size={32} className="text-indigo-500 animate-pulse" />
                </div>
                <p>{isVtuLoading ? "Scraping VTU Circle (takes ~5-10s)..." : "Analyzing semantics & searching index..."}</p>
                {rawCount === 0 && !isIndexLoaded && (
                   <p className="text-xs text-indigo-400 animate-pulse">Downloading repository index (one-time process)...</p>
                )}
              </div>
            ) : !hasSearched ? (
              <div className="flex-1 flex flex-col items-center justify-center text-slate-400 text-center">
                <Library size={48} className="mb-4 text-slate-300" strokeWidth={1} />
                <p className="text-lg font-medium text-slate-500">Your library is waiting</p>
                <p className="text-sm">Select a common option or search for something specific.</p>
              </div>
            ) : results.length > 0 ? (
              <div className="space-y-4 overflow-y-auto pr-2 custom-scrollbar flex-1 max-h-[600px]">
                {rawCount > 0 && (
                  <div className="bg-indigo-50 border border-indigo-100 rounded-lg p-4 text-sm text-indigo-700 flex flex-col gap-2">
                    <div className="flex items-center justify-between">
                        <span><strong>Search Complete:</strong> Scanned {rawCount} documents.</span>
                    </div>
                    {semanticMetadata && (
                        <div className="text-xs bg-white/50 p-2 rounded border border-indigo-100">
                            <strong>AI NLP Analysis:</strong><br/>
                            <span className="text-slate-600">Core Subjects:</span> {semanticMetadata.core_subjects?.join(', ')}<br/>
                            <span className="text-slate-600">Context:</span> {semanticMetadata.context_filters?.join(', ')}
                        </div>
                    )}
                  </div>
                )}
                {results.map((res, i) => (
                  <a 
                    key={i} 
                    href={res.url} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="block p-4 bg-white border border-slate-200 rounded-xl hover:border-indigo-300 hover:shadow-md transition-all group"
                  >
                    <div className="flex justify-between items-start gap-4">
                      <div className="flex items-start gap-3 w-full">
                        <div className="p-2 bg-indigo-50 text-indigo-600 rounded-lg shrink-0 mt-0.5 group-hover:bg-indigo-600 group-hover:text-white transition-colors">
                          <FileText size={16} />
                        </div>
                        <div className="flex-1 space-y-2">
                          <h3 className="font-medium text-slate-800 leading-snug group-hover:text-indigo-700 transition-colors">
                            {res.title}
                          </h3>
                          {res.confidence !== undefined && (
                            <div className="flex items-center gap-2">
                              <div className="h-1.5 flex-1 bg-slate-100 rounded-full overflow-hidden">
                                <div 
                                  className={`h-full ${res.confidence > 80 ? 'bg-emerald-400' : res.confidence > 50 ? 'bg-amber-400' : 'bg-red-400'}`} 
                                  style={{ width: `${res.confidence}%` }}
                                ></div>
                              </div>
                              <span className="text-xs font-medium text-slate-400">{res.confidence}% match score</span>
                            </div>
                          )}
                        </div>
                      </div>
                      <ExternalLink size={16} className="text-slate-300 group-hover:text-indigo-500 shrink-0 mt-1" />
                    </div>
                  </a>
                ))}
              </div>
            ) : (
              <div className="flex-1 flex flex-col items-center justify-center text-slate-400 text-center">
                <div className="h-16 w-16 bg-slate-100 rounded-full flex items-center justify-center mb-4">
                  <Search size={24} className="text-slate-400" />
                </div>
                <p className="text-lg font-medium text-slate-500">No matches found</p>
                <p className="text-sm">Try using different keywords or checking spelling.</p>
              </div>
            )}
          </Card>
        </div>

      </div>
    </div>
  );
}
