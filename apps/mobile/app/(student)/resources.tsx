import React, { useState } from 'react';
import { View, Text, ScrollView, TextInput, TouchableOpacity, ActivityIndicator, Linking } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { Library, Search, FileText, ExternalLink, Sparkles } from 'lucide-react-native';

export default function ResourceLibraryScreen() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);

  const handleSearch = async (searchQuery: string) => {
    if (!searchQuery.trim()) return;
    
    setIsLoading(true);
    setHasSearched(true);
    setResults([]);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      
      const response = await fetch(
        `${process.env.EXPO_PUBLIC_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co'}/functions/v1/dspace-search`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session?.access_token || ''}`,
          },
          body: JSON.stringify({ query: searchQuery }),
        }
      );

      if (!response.ok) throw new Error('Search failed');
      const data = await response.json();
      
      if (data.ok && data.semanticPayload) {
        // Since we are not doing local CSV filtering on mobile right now (to avoid 11MB download),
        // we will mock a few results based on the search, or show the semantic intent.
        // In a real app, the edge function would hit a vector DB or the edge function itself would return the matching URLs.
        // For now we simulate results.
        
        const mockResults = [
          { title: `${data.semanticPayload.core_subjects?.[0] || searchQuery} Previous Year Paper`, url: 'https://vtu.ac.in', confidence: 95 },
          { title: `${searchQuery} Important Questions`, url: 'https://vtu.ac.in', confidence: 80 },
          { title: `Module 1-5 Notes for ${data.semanticPayload.core_subjects?.[0] || 'Subject'}`, url: 'https://vtu.ac.in', confidence: 75 }
        ];
        
        setResults(mockResults);
      } else {
        setResults([]);
      }
    } catch (error) {
      console.error(error);
      alert('Failed to search resources');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <View className="flex-1 bg-slate-50 dark:bg-[#0c0d10]">
      <ScrollView className="flex-1" contentContainerStyle={{ padding: 16, gap: 16 }}>
        <View className="mt-8 mb-2">
          <View className="flex-row items-center gap-2 mb-2">
            <Library size={28} color="#4f46e5" />
            <Text className="text-3xl font-black text-slate-900 dark:text-white">Resources</Text>
          </View>
          <Text className="text-slate-500 dark:text-slate-400">Search the college repository for past papers, notes, and projects.</Text>
        </View>

        <Card className="bg-indigo-50/50 dark:bg-indigo-900/10 border-indigo-100 dark:border-indigo-900/30">
          <Text className="font-bold text-slate-800 dark:text-slate-200 mb-2 flex-row items-center">
            <Sparkles size={16} color="#4f46e5" /> AI Smart Search
          </Text>
          <View className="flex-row gap-2">
            <TextInput
              value={query}
              onChangeText={setQuery}
              placeholder="e.g. 'DBMS previous papers'"
              placeholderTextColor="#94a3b8"
              className="flex-1 bg-white dark:bg-slate-800 text-slate-900 dark:text-white px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700"
              onSubmitEditing={() => handleSearch(query)}
            />
            <TouchableOpacity 
              onPress={() => handleSearch(query)}
              disabled={isLoading || !query.trim()}
              className="bg-indigo-600 px-4 justify-center items-center rounded-xl"
            >
              {isLoading ? <ActivityIndicator color="white" /> : <Search size={20} color="white" />}
            </TouchableOpacity>
          </View>
        </Card>

        {hasSearched && (
          <View className="mt-4">
            <Text className="font-bold text-slate-800 dark:text-slate-200 mb-3 ml-1">Search Results</Text>
            
            {results.length > 0 ? (
              <View className="gap-y-3">
                {results.map((res, idx) => (
                  <TouchableOpacity 
                    key={idx}
                    onPress={() => Linking.openURL(res.url)}
                    className="bg-white dark:bg-slate-800 p-4 rounded-xl border border-slate-200 dark:border-slate-700 flex-row items-center gap-3"
                  >
                    <View className="bg-indigo-100 dark:bg-indigo-900/30 p-2 rounded-lg">
                      <FileText size={20} color="#4f46e5" />
                    </View>
                    <View className="flex-1">
                      <Text className="font-semibold text-slate-800 dark:text-slate-200 text-base">{res.title}</Text>
                      <View className="flex-row items-center gap-2 mt-1">
                        <View className="flex-1 h-1 bg-slate-100 dark:bg-slate-700 rounded-full overflow-hidden">
                          <View className="h-full bg-emerald-400" style={{ width: `${res.confidence}%` }} />
                        </View>
                        <Text className="text-[10px] text-slate-400 font-bold">{res.confidence}% match</Text>
                      </View>
                    </View>
                    <ExternalLink size={16} color="#94a3b8" />
                  </TouchableOpacity>
                ))}
              </View>
            ) : !isLoading && (
              <View className="items-center py-10 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700">
                <Search size={40} color="#cbd5e1" className="mb-3" />
                <Text className="text-slate-500 font-medium">No matches found</Text>
              </View>
            )}
          </View>
        )}

        <View className="h-10" />
      </ScrollView>
    </View>
  );
}
