import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';

export default function StudentDashboard() {
  const [profile, setProfile] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchDashboardData = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { data: profileData } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single();

    setProfile(profileData);
    setLoading(false);
    setRefreshing(false);
  };

  useEffect(() => {
    fetchDashboardData();
  }, []);

  if (loading) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <ActivityIndicator size="large" color="#0d9488" />
      </View>
    );
  }

  return (
    <ScrollView 
      className="flex-1 bg-slate-50 dark:bg-[#0c0d10]"
      contentContainerStyle={{ padding: 16, gap: 16 }}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={() => { setRefreshing(true); fetchDashboardData(); }} />}
    >
      <View className="mt-8 mb-4">
        <Text className="text-2xl font-bold text-slate-900 dark:text-white">
          Welcome back, {profile?.full_name?.split(' ')[0]}!
        </Text>
        <Text className="text-slate-500 dark:text-slate-400">
          Semester {profile?.semester} • {profile?.branch}
        </Text>
      </View>

      <Card title="Attendance Overview">
        <View className="flex-row items-center justify-between">
          <View>
            <Text className="text-sm text-slate-500 dark:text-slate-400">Total Attendance</Text>
            <Text className="text-3xl font-bold text-brand-600 dark:text-brand-400 mt-1">85%</Text>
          </View>
          <View className="bg-brand-50 dark:bg-brand-900/30 px-3 py-1.5 rounded-full">
            <Text className="text-brand-700 dark:text-brand-300 text-sm font-medium">On Track</Text>
          </View>
        </View>
      </Card>

      <Card title="Latest Assessments">
        <View className="flex-row justify-between mb-4">
          <Text className="text-slate-700 dark:text-slate-200 font-medium">Machine Learning (IAT 1)</Text>
          <Text className="text-slate-900 dark:text-white font-bold">28/30</Text>
        </View>
        <View className="flex-row justify-between mb-4">
          <Text className="text-slate-700 dark:text-slate-200 font-medium">Cloud Computing (IAT 1)</Text>
          <Text className="text-slate-900 dark:text-white font-bold">25/30</Text>
        </View>
        <View className="flex-row justify-between">
          <Text className="text-slate-700 dark:text-slate-200 font-medium">DevOps (Assignment 1)</Text>
          <Text className="text-slate-900 dark:text-white font-bold">10/10</Text>
        </View>
      </Card>

      <Card title="AI Prediction">
        <Text className="text-slate-600 dark:text-slate-300 leading-6">
          Based on your current performance trajectory, you are predicted to score an SGPA of <Text className="font-bold text-brand-600 dark:text-brand-400">8.9</Text> this semester. Keep up the good work to reach 9.0+.
        </Text>
      </Card>
    </ScrollView>
  );
}
