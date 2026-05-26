import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, ScrollView, TextInput, TouchableOpacity, Alert, ActivityIndicator } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { Button } from '../../src/components/ui/Button';
import { supabase } from '../../src/lib/supabase';
import { ClipboardList, DownloadCloud } from 'lucide-react-native';

export default function MarksScreen() {
  const [data, setData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [syncing, setSyncing] = useState(false);
  const [user, setUser] = useState<any>(null);
  
  // Minimal state for storing edits locally before save
  const [editedCells, setEditedCells] = useState<Map<string, number | null>>(new Map());

  const fetchData = async () => {
    setLoading(true);
    const { data: { user } } = await supabase.auth.getUser();
    setUser(user);
    if (!user) return;

    try {
      const { data: students } = await supabase.from('profiles').select('id, full_name').eq('mentor_id', user.id).eq('role', 'student');
      if (!students || students.length === 0) return;

      const studentIds = students.map(s => s.id);
      const { data: enrollments } = await supabase.from('enrollments').select('student_id, class_id').in('student_id', studentIds);
      const classIds = [...new Set((enrollments || []).map(e => e.class_id))];
      
      const { data: classes } = await supabase.from('classes').select('id, subject_id').in('id', classIds);
      const subjectIds = [...new Set((classes || []).map(c => c.subject_id))];
      
      const { data: subjects } = await supabase.from('subjects').select('id, name').in('id', subjectIds);
      const subjectMap = new Map((subjects || []).map(s => [s.id, s.name]));
      const classSubjectMap = new Map((classes || []).map(c => [c.id, subjectMap.get(c.subject_id) || 'Unknown']));

      const { data: iatMarks } = await supabase.from('iat_marks').select('*').in('student_id', studentIds);
      const iatMap = new Map<string, any>();
      (iatMarks || []).forEach(m => iatMap.set(`${m.student_id}-${m.class_id}`, m));

      const studentMap = new Map(students.map(s => [s.id, s.full_name]));
      const classToSubjectId = new Map((classes || []).map(c => [c.id, c.subject_id]));

      const seen = new Set<string>();
      const uniqueEnrollments = (enrollments || []).filter((e: any) => {
        const subjectId = classToSubjectId.get(e.class_id);
        const dedupeKey = `${e.student_id}::${subjectId}`;
        if (seen.has(dedupeKey)) return false;
        seen.add(dedupeKey);
        return true;
      });

      const allowedSubjects = ['dbms', 'database', 'ai', 'artificial intelligence', 'dms', 'discrete', 'ada', 'algorithm'];
      
      let rows = uniqueEnrollments.map((e: any) => {
        const marks = iatMap.get(`${e.student_id}-${e.class_id}`) || {};
        return {
          student_id: e.student_id,
          full_name: studentMap.get(e.student_id) || 'Unknown',
          class_id: e.class_id,
          subject_name: classSubjectMap.get(e.class_id) || 'Unknown',
          iat1: marks.iat1 ?? null,
          iat2: marks.iat2 ?? null,
          lab_iat1: marks.lab_iat1 ?? null,
          lab_iat2: marks.lab_iat2 ?? null,
        };
      });

      rows = rows.filter(d => {
        const name = d.subject_name.toLowerCase();
        return allowedSubjects.some(a => name.includes(a) || name === 'ai' || name === 'ada' || name === 'dms');
      });

      setData(rows.sort((a, b) => a.full_name.localeCompare(b.full_name)));
    } catch (err) {
      console.log('Error fetching marks', err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchData();
  }, []);

  const handleMarkChange = (studentId: string, classId: string, field: string, value: string) => {
    const key = `${studentId}-${classId}-${field}`;
    if (value === '') {
      const newCells = new Map(editedCells);
      newCells.set(key, null);
      setEditedCells(newCells);
      return;
    }
    const num = parseFloat(value);
    if (!isNaN(num) && num >= 0 && num <= 50) {
      const newCells = new Map(editedCells);
      newCells.set(key, num);
      setEditedCells(newCells);
    }
  };

  const getDisplayValue = (row: any, field: string) => {
    const key = `${row.student_id}-${row.class_id}-${field}`;
    if (editedCells.has(key)) {
      const val = editedCells.get(key);
      return val !== null ? String(val) : '';
    }
    const existing = row[field];
    return existing !== null ? String(existing) : '';
  };

  const handleSave = async () => {
    if (editedCells.size === 0) return;
    setSaving(true);
    try {
      const rowUpdates = new Map<string, any>();
      editedCells.forEach((value, key) => {
        const [studentId, classId, field] = key.split('-');
        const rowKey = `${studentId}-${classId}`;
        if (!rowUpdates.has(rowKey)) {
          rowUpdates.set(rowKey, { student_id: studentId, class_id: classId });
        }
        rowUpdates.get(rowKey)[field] = value;
      });

      const promises = Array.from(rowUpdates.values()).map(update => 
        supabase.from('iat_marks').upsert(update, { onConflict: 'student_id,class_id' })
      );

      await Promise.all(promises);
      Alert.alert('Success', 'Marks saved successfully!');
      setEditedCells(new Map());
      await fetchData();
    } catch (e) {
      Alert.alert('Error', 'Failed to save marks');
    }
    setSaving(false);
  };

  if (loading) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <ActivityIndicator size="large" color="#a855f7" />
      </View>
    );
  }

  return (
    <ScrollView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" contentContainerStyle={{ padding: 16, gap: 16 }}>
      <View className="mt-8 flex-row items-center justify-between">
        <View>
          <Text className="text-2xl font-bold text-slate-900 dark:text-white">IAT Marks</Text>
          <Text className="text-slate-500 dark:text-slate-400 mt-1">Record internal assessments</Text>
        </View>
        <TouchableOpacity className="p-3 bg-purple-100 dark:bg-purple-900/30 rounded-xl flex-row items-center">
          <DownloadCloud size={20} color="#9333ea" />
        </TouchableOpacity>
      </View>

      {editedCells.size > 0 && (
        <Card className="bg-purple-50 dark:bg-purple-900/20 border border-purple-200 dark:border-purple-800 flex-row justify-between items-center p-4">
          <Text className="text-purple-700 dark:text-purple-300 font-semibold">{editedCells.size} changes</Text>
          <View className="flex-row gap-x-2">
            <Button title="Save All" size="sm" onPress={handleSave} loading={saving} className="bg-purple-600" />
          </View>
        </Card>
      )}

      {data.map((row, idx) => (
        <Card key={`${row.student_id}-${row.class_id}`} className="mb-4 p-4">
          <Text className="text-lg font-bold text-slate-900 dark:text-white">{row.full_name}</Text>
          <Text className="text-sm font-semibold text-purple-600 mb-4">{row.subject_name}</Text>
          
          <View className="flex-row justify-between mb-3">
            <View className="w-[48%]">
              <Text className="text-xs font-bold text-slate-500 mb-1">Theory IAT 1</Text>
              <TextInput 
                className="border border-slate-200 dark:border-slate-800 rounded-lg p-2 bg-white dark:bg-[#13151a] text-slate-900 dark:text-white text-center font-bold"
                keyboardType="numeric"
                value={getDisplayValue(row, 'iat1')}
                onChangeText={(val) => handleMarkChange(row.student_id, row.class_id, 'iat1', val)}
                placeholder="-"
                placeholderTextColor="#94a3b8"
              />
            </View>
            <View className="w-[48%]">
              <Text className="text-xs font-bold text-slate-500 mb-1">Theory IAT 2</Text>
              <TextInput 
                className="border border-slate-200 dark:border-slate-800 rounded-lg p-2 bg-white dark:bg-[#13151a] text-slate-900 dark:text-white text-center font-bold"
                keyboardType="numeric"
                value={getDisplayValue(row, 'iat2')}
                onChangeText={(val) => handleMarkChange(row.student_id, row.class_id, 'iat2', val)}
                placeholder="-"
                placeholderTextColor="#94a3b8"
              />
            </View>
          </View>
          
          <View className="flex-row justify-between">
            <View className="w-[48%]">
              <Text className="text-xs font-bold text-slate-500 mb-1">Lab IAT 1</Text>
              <TextInput 
                className="border border-slate-200 dark:border-slate-800 rounded-lg p-2 bg-white dark:bg-[#13151a] text-slate-900 dark:text-white text-center font-bold"
                keyboardType="numeric"
                value={getDisplayValue(row, 'lab_iat1')}
                onChangeText={(val) => handleMarkChange(row.student_id, row.class_id, 'lab_iat1', val)}
                placeholder="-"
                placeholderTextColor="#94a3b8"
              />
            </View>
            <View className="w-[48%]">
              <Text className="text-xs font-bold text-slate-500 mb-1">Lab IAT 2</Text>
              <TextInput 
                className="border border-slate-200 dark:border-slate-800 rounded-lg p-2 bg-white dark:bg-[#13151a] text-slate-900 dark:text-white text-center font-bold"
                keyboardType="numeric"
                value={getDisplayValue(row, 'lab_iat2')}
                onChangeText={(val) => handleMarkChange(row.student_id, row.class_id, 'lab_iat2', val)}
                placeholder="-"
                placeholderTextColor="#94a3b8"
              />
            </View>
          </View>
        </Card>
      ))}

      <View className="h-20" />
    </ScrollView>
  );
}
