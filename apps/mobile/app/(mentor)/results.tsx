import React, { useState } from 'react';
import { View, Text, ScrollView, TextInput, TouchableOpacity, ActivityIndicator, Alert } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { Button } from '../../src/components/ui/Button';
import { Input } from '../../src/components/ui/Input';
import { supabase } from '../../src/lib/supabase';
import { Badge } from '../../src/components/ui/Badge';

// ── Types ─────────────────────────────────────────────────────────

interface SubjectResult {
  code: string;
  name: string;
  internal: number | null;
  external: number | null;
  total: number | null;
  result: string;
  passed: boolean;
}

interface SemesterResult {
  semester: number;
  label: string;
  subjects: SubjectResult[];
  sgpa: string | null;
}

// ── VTU Credit Rules ──────────────────────────────────────────────

const SUBJECT_CREDITS: Record<string, number> = {
  'BMATS101': 4, 'BPHYS102': 4, 'BPOPS103': 3, 'BESCK104': 3, 'BETCK105': 3, 'BPLCK105': 3,
  'BENGK106': 1, 'BPWSK106': 1, 'BKSKK107': 1, 'BKBKK107': 1, 'BICOK107': 1, 'BIDTK158': 1, 'BSFHK158': 1,
  'BMATS201': 4, 'BCHES202': 4, 'BCEDK203': 3, 'BESCK204': 3, 'BETCK205': 3, 'BPLCK205': 3,
  'BPWSK206': 1, 'BENGK206': 1, 'BICOK207': 1, 'BKSKK207': 1, 'BKBKK207': 1, 'BSFHK258': 1, 'KIDTK258': 1,
  'BMATS301': 4, 'BCS301': 4, 'BCS302': 4, 'BCS303': 4, 'BCS304': 3, 'BCSL305': 1,
  'BCS306': 3, 'BSCK307': 1, 'BNSK359': 0, 'BCS358A': 1
};

function getCreditsForSubject(code: string): number | null {
  const upper = code.toUpperCase().trim();
  if (upper in SUBJECT_CREDITS) return SUBJECT_CREDITS[upper];
  const stripped = upper.replace(/[A-Z]$/, '');
  if (stripped !== upper && stripped in SUBJECT_CREDITS) return SUBJECT_CREDITS[stripped];
  const numMatch = upper.match(/(\d{3})[A-Z]?$/);
  if (numMatch) {
    const lastTwo = parseInt(numMatch[1]) % 100;
    if (lastTwo >= 1 && lastTwo <= 2) return 4;
    if (lastTwo >= 3 && lastTwo <= 5) return 3;
    if (lastTwo >= 6 && lastTwo <= 7) return 1;
    if (lastTwo >= 50 && lastTwo <= 59) return 1;
  }
  return null;
}

function getGradePoint(total: number | null): number {
  if (total === null || total < 0) return 0;
  if (total >= 90) return 10;
  if (total >= 80) return 9;
  if (total >= 70) return 8;
  if (total >= 60) return 7;
  if (total >= 55) return 6;
  if (total >= 50) return 5;
  if (total >= 40) return 4;
  return 0;
}

function calculateSgpa(subjects: SubjectResult[]): string | null {
  if (!subjects || subjects.length === 0) return null;
  let totalCredits = 0;
  let totalWeighted = 0;
  for (const subj of subjects) {
    const credits = getCreditsForSubject(subj.code);
    if (credits === null || credits === 0) continue;
    const gp = getGradePoint(subj.total);
    totalCredits += credits;
    totalWeighted += credits * gp;
  }
  if (totalCredits === 0) return null;
  return (totalWeighted / totalCredits).toFixed(2);
}

// ── Component ─────────────────────────────────────────────────────

const SEMESTER_URLS = [
  { semester: 1, label: '1st Semester', url: 'https://results.vtu.ac.in/DJcbcs25/' },
  { semester: 2, label: '2nd Semester', url: 'https://results.vtu.ac.in/JJEcbcs25/' },
  { semester: 3, label: '3rd Semester', url: 'https://results.vtu.ac.in/D25J26Ecbcs/' },
];

export default function ResultsScreen() {
  const [usn, setUsn] = useState('');
  const [isFetching, setIsFetching] = useState(false);
  const [results, setResults] = useState<SemesterResult[]>([]);

  const fetchResults = async () => {
    if (!usn || usn.length < 8) {
      Alert.alert('Error', 'Please enter a valid USN');
      return;
    }

    setIsFetching(true);
    setResults([]);

    const fetchedResults: SemesterResult[] = [];

    for (const sem of SEMESTER_URLS) {
      try {
        const { data, error } = await supabase.functions.invoke('vtu-result', {
          body: { usn, resultUrl: sem.url },
        });

        if (error) continue;
        if (data?.ok && data.summary?.subjects) {
          const subjects = data.summary.subjects;
          const sgpa = calculateSgpa(subjects);
          fetchedResults.push({
            semester: sem.semester,
            label: sem.label,
            subjects,
            sgpa,
          });
        }
      } catch (err) {
        console.log(`Failed for sem ${sem.semester}`);
      }
    }

    setResults(fetchedResults);
    setIsFetching(false);

    if (fetchedResults.length === 0) {
      Alert.alert('No Results', 'Could not find any results for this USN.');
    }
  };

  return (
    <ScrollView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" contentContainerStyle={{ padding: 16 }}>
      <View className="mt-8 mb-6">
        <Text className="text-2xl font-bold text-slate-900 dark:text-white">VTU Results</Text>
        <Text className="text-slate-500 dark:text-slate-400 mt-1">Fetch and analyze academic results</Text>
      </View>

      <Card className="mb-6">
        <Input 
          label="Student USN"
          placeholder="e.g. 1CR24CI063"
          value={usn}
          onChangeText={setUsn}
          autoCapitalize="characters"
        />
        <View className="mt-4">
          <Button 
            title="Fetch Results" 
            onPress={fetchResults} 
            loading={isFetching}
            fullWidth
          />
        </View>
      </Card>

      {results.map((result) => (
        <Card key={result.semester} className="mb-4">
          <View className="flex-row justify-between items-center border-b border-slate-100 dark:border-slate-800 pb-3 mb-3">
            <View>
              <Text className="text-lg font-bold text-slate-900 dark:text-white">{result.label}</Text>
              <Text className="text-sm text-slate-500 dark:text-slate-400">{result.subjects.length} subjects</Text>
            </View>
            {result.sgpa && (
              <View className="items-end">
                <Text className="text-xs text-slate-500 font-bold uppercase">SGPA</Text>
                <Text className="text-2xl font-black text-indigo-600 dark:text-indigo-400">{result.sgpa}</Text>
              </View>
            )}
          </View>
          
          <View className="gap-2">
            {result.subjects.map((sub, idx) => (
              <View key={idx} className="flex-row justify-between items-center py-2 border-b border-slate-50 dark:border-white/5">
                <View className="flex-1 pr-2">
                  <Text className="text-xs font-bold text-slate-500">{sub.code}</Text>
                  <Text className="text-sm font-medium text-slate-800 dark:text-slate-200" numberOfLines={1}>{sub.name}</Text>
                </View>
                <View className="items-end flex-row gap-3">
                  <Text className="text-lg font-bold text-slate-700 dark:text-slate-300">{sub.total}</Text>
                  <Badge 
                    label={sub.passed ? 'PASS' : 'FAIL'} 
                    variant={sub.passed ? 'success' : 'danger'} 
                  />
                </View>
              </View>
            ))}
          </View>
        </Card>
      ))}

    </ScrollView>
  );
}
