import React, { useState } from 'react';
import { View, Text, ScrollView, TextInput, TouchableOpacity, ActivityIndicator, KeyboardAvoidingView, Platform } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { CalendarDays, Sparkles, AlertTriangle, Check, Info } from 'lucide-react-native';

export default function CalendarParserScreen() {
  const [calendarText, setCalendarText] = useState('');
  const [isParsing, setIsParsing] = useState(false);
  const [result, setResult] = useState<any>(null);

  const handleParse = async () => {
    if (!calendarText.trim()) return;
    setIsParsing(true);
    setResult(null);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error('Not authenticated');

      const response = await fetch(
        `${process.env.EXPO_PUBLIC_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co'}/functions/v1/parse-calendar`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({
            calendar_text: calendarText,
          }),
        }
      );

      if (!response.ok) throw new Error('Failed to parse calendar');
      const data = await response.json();
      setResult(data);
    } catch (error: any) {
      console.error("Parse Error:", error);
      alert(error.message || 'Failed to parse calendar');
    } finally {
      setIsParsing(false);
    }
  };

  return (
    <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : undefined} className="flex-1 bg-slate-50 dark:bg-[#0c0d10]">
      <ScrollView className="flex-1" contentContainerStyle={{ padding: 16, gap: 16 }}>
        <View className="mt-8 mb-2 items-center">
          <View className="flex-row items-center bg-violet-100 dark:bg-violet-900/30 px-4 py-1.5 rounded-full mb-3 border border-violet-200 dark:border-violet-700/50">
            <CalendarDays size={16} color="#6d28d9" />
            <Text className="text-violet-700 dark:text-violet-400 font-bold ml-2">AI Calendar Parser</Text>
          </View>
          <Text className="text-2xl font-black text-slate-900 dark:text-white text-center">Extract Events 📅</Text>
          <Text className="text-slate-500 text-center mt-2">Paste your college Calendar of Events below to extract holidays, exams & events using AI.</Text>
        </View>

        {!result ? (
          <Card>
            <Text className="font-bold text-slate-700 dark:text-slate-300 mb-2">Paste Calendar Text</Text>
            <TextInput
              value={calendarText}
              onChangeText={setCalendarText}
              placeholder="Paste calendar text here..."
              placeholderTextColor="#94a3b8"
              multiline
              textAlignVertical="top"
              className="min-h-[150px] bg-slate-100 dark:bg-slate-800 text-slate-900 dark:text-white p-3 rounded-xl mb-4"
            />
            
            <TouchableOpacity 
              onPress={handleParse}
              disabled={isParsing || !calendarText.trim()}
              className={`p-4 rounded-xl flex-row justify-center items-center gap-x-2 ${(!calendarText.trim() || isParsing) ? 'bg-violet-400' : 'bg-violet-600'}`}
            >
              {isParsing ? (
                <ActivityIndicator color="white" />
              ) : (
                <>
                  <Sparkles size={20} color="white" />
                  <Text className="text-white font-bold text-base">Extract with AI</Text>
                </>
              )}
            </TouchableOpacity>
          </Card>
        ) : (
          <View className="gap-y-4">
            <View className="bg-violet-100 dark:bg-violet-900/20 p-5 rounded-2xl border border-violet-200 dark:border-violet-800">
              <Text className="text-lg font-black text-slate-900 dark:text-white">{result.academic_year} • {result.semester || 'Full Year'}</Text>
              <Text className="text-slate-600 dark:text-slate-300 mt-2">{result.summary}</Text>
              
              <View className="flex-row gap-2 mt-4 flex-wrap">
                <View className="bg-white dark:bg-slate-800 p-3 rounded-lg flex-1 items-center">
                  <Text className="text-xl font-black text-violet-700 dark:text-violet-400">{result.events?.length || 0}</Text>
                  <Text className="text-[10px] text-slate-500 font-bold">EVENTS</Text>
                </View>
                <View className="bg-white dark:bg-slate-800 p-3 rounded-lg flex-1 items-center">
                  <Text className="text-xl font-black text-red-600 dark:text-red-400">{result.total_holidays || 0}</Text>
                  <Text className="text-[10px] text-slate-500 font-bold">HOLIDAYS</Text>
                </View>
                <View className="bg-white dark:bg-slate-800 p-3 rounded-lg flex-1 items-center">
                  <Text className="text-xl font-black text-amber-600 dark:text-amber-400">{result.total_working_days_lost || 0}</Text>
                  <Text className="text-[10px] text-slate-500 font-bold">DAYS OFF</Text>
                </View>
              </View>
            </View>

            <Text className="font-bold text-slate-800 dark:text-slate-200 ml-1">Extracted Events</Text>
            
            {result.events?.map((event: any, idx: number) => (
              <View key={idx} className="bg-white dark:bg-slate-800 p-4 rounded-xl border border-slate-100 dark:border-slate-700 flex-row gap-3 items-center">
                <View className={`w-10 h-10 rounded-full justify-center items-center ${event.is_holiday ? 'bg-red-100 dark:bg-red-900/30' : 'bg-blue-100 dark:bg-blue-900/30'}`}>
                  {event.is_holiday ? <AlertTriangle size={20} color="#ef4444" /> : <Info size={20} color="#3b82f6" />}
                </View>
                <View className="flex-1">
                  <Text className="font-bold text-slate-800 dark:text-white text-base">{event.name}</Text>
                  <Text className="text-xs text-slate-500 dark:text-slate-400 mt-0.5">{event.start_date}{event.end_date ? ` to ${event.end_date}` : ''}</Text>
                </View>
                {event.days_off > 0 && (
                  <View className="bg-amber-100 dark:bg-amber-900/30 px-2 py-1 rounded-md">
                    <Text className="text-[10px] font-bold text-amber-700 dark:text-amber-400">{event.days_off}d off</Text>
                  </View>
                )}
              </View>
            ))}

            <TouchableOpacity 
              onPress={() => { setResult(null); setCalendarText(''); }}
              className="p-4 bg-slate-200 dark:bg-slate-800 rounded-xl items-center mt-2"
            >
              <Text className="font-bold text-slate-700 dark:text-slate-300">Parse another calendar</Text>
            </TouchableOpacity>
          </View>
        )}
        
        <View className="h-10" />
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
