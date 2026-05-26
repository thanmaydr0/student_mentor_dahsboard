import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, ActivityIndicator } from 'react-native';
import { useLocalSearchParams } from 'expo-router';
import { supabase } from '../../../src/lib/supabase';
import { Card } from '../../../src/components/ui/Card';
import { Badge } from '../../../src/components/ui/Badge';
import { BookOpen, GraduationCap, AlertTriangle } from 'lucide-react-native';

export default function StudentDetailScreen() {
  const { id } = useLocalSearchParams();
  const [profile, setProfile] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadStudent() {
      const { data } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', id)
        .single();
      
      if (data) setProfile(data);
      setLoading(false);
    }
    loadStudent();
  }, [id]);

  if (loading) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <ActivityIndicator size="large" color="#0d9488" />
      </View>
    );
  }

  if (!profile) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <Text className="text-slate-500">Student not found.</Text>
      </View>
    );
  }

  return (
    <ScrollView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" contentContainerStyle={{ padding: 16, gap: 16 }}>
      <View className="mt-4 mb-2 flex-row items-center justify-between">
        <View>
          <Text className="text-2xl font-bold text-slate-900 dark:text-white">{profile.full_name}</Text>
          <Text className="text-slate-500 dark:text-slate-400 mt-1">{profile.branch} • Sem {profile.semester}</Text>
        </View>
        <Badge label="Student" variant="default" />
      </View>

      <Card>
        <Text className="font-bold text-slate-900 dark:text-white mb-4">Academic Overview</Text>
        <View className="flex-row justify-between mb-4">
          <View className="flex-row items-center gap-2">
            <BookOpen size={16} color="#3b82f6" />
            <Text className="text-slate-600 dark:text-slate-300">Attendance</Text>
          </View>
          <Text className="font-bold text-slate-900 dark:text-white">-</Text>
        </View>
        
        <View className="flex-row justify-between mb-4">
          <View className="flex-row items-center gap-2">
            <GraduationCap size={16} color="#8b5cf6" />
            <Text className="text-slate-600 dark:text-slate-300">Avg CGPA</Text>
          </View>
          <Text className="font-bold text-slate-900 dark:text-white">-</Text>
        </View>

        <View className="flex-row justify-between">
          <View className="flex-row items-center gap-2">
            <AlertTriangle size={16} color="#ef4444" />
            <Text className="text-slate-600 dark:text-slate-300">Risk Level</Text>
          </View>
          <Badge label="Low" variant="success" />
        </View>
      </Card>
    </ScrollView>
  );
}
