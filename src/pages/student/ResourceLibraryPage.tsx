import React, { useState } from 'react';
import { Search, BookOpen, FileText, Database, Sparkles, ExternalLink, Library } from 'lucide-react';
import { supabase } from '../../lib/supabase';
import Card from '../../components/ui/Card';
import Button from '../../components/ui/Button';
import Input from '../../components/ui/Input';
import toast from 'react-hot-toast';

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
  const [isDeepScan, setIsDeepScan] = useState(false);
  const [rawCount, setRawCount] = useState(0);

  const handleSearch = async (searchQuery: string, useAi: boolean = false) => {
    if (!searchQuery.trim()) {
      toast.error("Please enter a search query");
      return;
    }

    setIsLoading(true);
    setHasSearched(true);
    setIsDeepScan(useAi);
    setRawCount(0);
    
    try {
      // Use native fetch to bypass supabase-js 12s timeout
      const { data: { session } } = await supabase.auth.getSession();
      const edgeFunctionUrl = `${import.meta.env.VITE_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co'}/functions/v1/dspace-search`;
      
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 60000); // 60 seconds allowed for deep scraping
      
      const response = await fetch(edgeFunctionUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${session?.access_token || import.meta.env.VITE_SUPABASE_ANON_KEY}`
        },
        body: JSON.stringify({ query: searchQuery, useAi }),
        signal: controller.signal
      });
      
      clearTimeout(timeoutId);
      
      if (!response.ok) {
        throw new Error(`Edge function returned ${response.status}`);
      }
      
      const data = await response.json();

      if (!data.ok) throw new Error(data.error);

      setResults(data.results || []);
      setRawCount(data.rawCount || 0);
      
      if (data.results?.length === 0) {
        toast.error("No resources found. Try different keywords.");
      } else {
        toast.success(`Found ${data.results.length} resources!`);
      }
    } catch (err: any) {
      toast.error(err.message || 'Failed to search library');
      setResults([]);
    } finally {
      setIsLoading(false);
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
          <p className="text-slate-500 mt-1">Search the college DSpace repository for past papers, notes, and projects.</p>
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
              AI Assistant Search
            </h2>
            <p className="text-xs text-slate-500 mb-4">
              Describe what you need in plain English. The AI will translate it into the optimal search query.
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
                {!isLoading && <Sparkles size={16} className="mr-2" />}
                Ask AI to Find It
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

            {isLoading ? (
              <div className="flex-1 flex flex-col items-center justify-center text-slate-400 space-y-4">
                <div className="relative flex justify-center items-center h-16 w-16">
                  <div className="absolute animate-ping inline-flex h-full w-full rounded-full bg-indigo-400 opacity-20"></div>
                  <Sparkles size={32} className="text-indigo-500 animate-pulse" />
                </div>
                <p>{isDeepScan ? "Running deep AI scan on DSpace..." : "Scraping repository..."}</p>
                {isDeepScan && (
                  <p className="text-xs text-indigo-400 animate-pulse">This may take 10-15 seconds to fetch and analyze multiple pages.</p>
                )}
              </div>
            ) : !hasSearched ? (
              <div className="flex-1 flex flex-col items-center justify-center text-slate-400 text-center">
                <Library size={48} className="mb-4 text-slate-300" strokeWidth={1} />
                <p className="text-lg font-medium text-slate-500">Your library is waiting</p>
                <p className="text-sm">Select a common option or ask the AI to find something specific.</p>
              </div>
            ) : results.length > 0 ? (
              <div className="space-y-4 overflow-y-auto pr-2 custom-scrollbar flex-1 max-h-[600px]">
                {isDeepScan && rawCount > 0 && (
                  <div className="bg-indigo-50 border border-indigo-100 rounded-lg p-3 text-sm text-indigo-700 flex items-center justify-between">
                    <span><strong>Deep Scan Complete:</strong> Filtered from {rawCount} raw documents.</span>
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
                          {res.reason && (
                            <div className="bg-slate-50 border border-slate-100 p-2.5 rounded-lg text-sm text-slate-600">
                              <span className="font-semibold text-indigo-600 mr-2">AI Note:</span>
                              {res.reason}
                            </div>
                          )}
                          {res.confidence !== undefined && (
                            <div className="flex items-center gap-2">
                              <div className="h-1.5 flex-1 bg-slate-100 rounded-full overflow-hidden">
                                <div 
                                  className={`h-full ${res.confidence > 80 ? 'bg-emerald-400' : res.confidence > 50 ? 'bg-amber-400' : 'bg-red-400'}`} 
                                  style={{ width: `${res.confidence}%` }}
                                ></div>
                              </div>
                              <span className="text-xs font-medium text-slate-400">{res.confidence}% match</span>
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
};
