import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { Users, AlertCircle, CheckCircle2 } from 'lucide-react-native';

export default function MentorDashboard() {
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
          Faculty Mentor
        </Text>
      </View>

      <View className="flex-row flex-wrap justify-between">
        <View className="w-[48%] mb-4">
          <Card className="h-full">
            <View className="flex-row items-center gap-2 mb-2">
              <Users size={16} color="#0d9488" />
              <Text className="text-sm font-semibold text-slate-500 dark:text-slate-400">Total Students</Text>
            </View>
            <Text className="text-3xl font-bold text-slate-900 dark:text-white">24</Text>
          </Card>
        </View>
        <View className="w-[48%] mb-4">
          <Card className="h-full">
            <View className="flex-row items-center gap-2 mb-2">
              <AlertCircle size={16} color="#ef4444" />
              <Text className="text-sm font-semibold text-slate-500 dark:text-slate-400">High Risk</Text>
            </View>
            <Text className="text-3xl font-bold text-red-500">3</Text>
          </Card>
        </View>
      </View>

      <Card title="Cohort Highlights">
        <View className="flex-row items-center gap-3 mb-4">
          <CheckCircle2 size={20} color="#10b981" />
          <View className="flex-1">
            <Text className="text-slate-900 dark:text-white font-medium">Attendance is improving</Text>
            <Text className="text-sm text-slate-500 dark:text-slate-400 mt-0.5">Average attendance up by 4% this week.</Text>
          </View>
        </View>
        <View className="flex-row items-center gap-3">
          <AlertCircle size={20} color="#f59e0b" />
          <View className="flex-1">
            <Text className="text-slate-900 dark:text-white font-medium">IAT 1 marks missing</Text>
            <Text className="text-sm text-slate-500 dark:text-slate-400 mt-0.5">5 students haven't received their Cloud Computing marks.</Text>
          </View>
        </View>
      </Card>
    </ScrollView>
  );
}
