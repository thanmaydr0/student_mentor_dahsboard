import React, { useEffect, useState, useMemo } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator, TouchableOpacity } from 'react-native';
import { router } from 'expo-router';
import { Card } from '../../src/components/ui/Card';
import { Badge } from '../../src/components/ui/Badge';
import { supabase } from '../../src/lib/supabase';
import { Users, AlertTriangle, BookOpen, GraduationCap, ChevronRight, ClipboardList } from 'lucide-react-native';

export default function MentorDashboard() {
  const [profile, setProfile] = useState<any>(null);
  const [cohortData, setCohortData] = useState<any[]>([]);
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

    const { data, error } = await supabase.rpc('get_mentor_cohort_summary', { 
      p_mentor_id: user.id 
    });

    if (!error && data) {
      setCohortData(data);
    }

    setLoading(false);
    setRefreshing(false);
  };

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const stats = useMemo(() => {
    if (!cohortData || cohortData.length === 0) return { total: 0, highRisk: 0, avgAtt: 0, avgScore: 0 };
    
    const total = cohortData.length;
    const highRisk = cohortData.filter((s: any) => s.risk_level === 'High').length;
    
    const validAtts = cohortData.filter((s: any) => s.avg_attendance != null);
    const avgAtt = validAtts.length ? validAtts.reduce((sum: number, s: any) => sum + Number(s.avg_attendance), 0) / validAtts.length : 0;
    
    const validScores = cohortData.filter((s: any) => s.avg_total_score != null);
    const avgScore = validScores.length ? validScores.reduce((sum: number, s: any) => sum + Number(s.avg_total_score), 0) / validScores.length : 0;

    return { total, highRisk, avgAtt: Math.round(avgAtt), avgScore: Math.round(avgScore) };
  }, [cohortData]);

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
      <View className="mt-8 mb-2">
        <Text className="text-2xl font-bold text-slate-900 dark:text-white">
          Welcome back, {profile?.full_name?.split(' ')[0]}!
        </Text>
        <Text className="text-slate-500 dark:text-slate-400 mt-1">
          Faculty Mentor Dashboard
        </Text>
      </View>

      {/* Stats Grid */}
      <View className="flex-row flex-wrap justify-between gap-y-4">
        <View className="w-[48%]">
          <Card className="h-full px-4 py-4">
            <View className="flex-row items-center justify-between mb-3">
              <Text className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Students</Text>
              <Users size={16} color="#3b82f6" />
            </View>
            <Text className="text-2xl font-bold text-slate-900 dark:text-white">{stats.total}</Text>
          </Card>
        </View>
        
        <View className="w-[48%]">
          <Card className="h-full px-4 py-4">
            <View className="flex-row items-center justify-between mb-3">
              <Text className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">High Risk</Text>
              <AlertTriangle size={16} color="#ef4444" />
            </View>
            <Text className="text-2xl font-bold text-red-500">{stats.highRisk}</Text>
          </Card>
        </View>

        <View className="w-[48%]">
          <Card className="h-full px-4 py-4">
            <View className="flex-row items-center justify-between mb-3">
              <Text className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Avg Att</Text>
              <BookOpen size={16} color="#10b981" />
            </View>
            <Text className="text-2xl font-bold text-slate-900 dark:text-white">{stats.avgAtt}%</Text>
          </Card>
        </View>

        <View className="w-[48%]">
          <Card className="h-full px-4 py-4">
            <View className="flex-row items-center justify-between mb-3">
              <Text className="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Avg Score</Text>
              <GraduationCap size={16} color="#8b5cf6" />
            </View>
            <Text className="text-2xl font-bold text-slate-900 dark:text-white">{stats.avgScore}</Text>
          </Card>
        </View>
      </View>

      {/* Action Buttons */}
      <View className="mt-2 mb-2">
        <TouchableOpacity 
          onPress={() => router.push('/(mentor)/attendance')}
          className="bg-indigo-100 dark:bg-indigo-900/30 p-4 rounded-2xl flex-row items-center justify-between border border-indigo-200 dark:border-indigo-800/50"
        >
          <View className="flex-row items-center gap-x-3">
            <View className="bg-indigo-200 dark:bg-indigo-800/50 p-2 rounded-xl">
              <BookOpen size={20} color="#4f46e5" />
            </View>
            <View>
              <Text className="font-bold text-slate-900 dark:text-white text-base">ERP Attendance Sync</Text>
              <Text className="text-xs text-slate-500 dark:text-slate-400">View and sync college ERP data</Text>
            </View>
          </View>
          <ChevronRight size={20} color="#4f46e5" />
        </TouchableOpacity>

        <TouchableOpacity 
          onPress={() => router.push('/(mentor)/marks')}
          className="bg-purple-100 dark:bg-purple-900/30 p-4 rounded-2xl flex-row items-center justify-between border border-purple-200 dark:border-purple-800/50 mt-3"
        >
          <View className="flex-row items-center gap-x-3">
            <View className="bg-purple-200 dark:bg-purple-800/50 p-2 rounded-xl">
              <ClipboardList size={20} color="#9333ea" />
            </View>
            <View>
              <Text className="font-bold text-slate-900 dark:text-white text-base">IAT Marks Entry</Text>
              <Text className="text-xs text-slate-500 dark:text-slate-400">Record internal assessments</Text>
            </View>
          </View>
          <ChevronRight size={20} color="#9333ea" />
        </TouchableOpacity>
      </View>

      {/* Cohort List */}
      <View className="mt-4">
        <Text className="text-lg font-bold text-slate-900 dark:text-white mb-3">Your Cohort</Text>
        
        <View className="bg-white dark:bg-[#13151a] rounded-2xl border border-slate-200 dark:border-slate-800 overflow-hidden">
          {cohortData.length === 0 ? (
            <View className="p-8 items-center">
              <Users size={32} color="#94a3b8" className="mb-2" />
              <Text className="text-slate-500 text-center font-medium">No students assigned to you yet.</Text>
            </View>
          ) : (
            cohortData.map((student, index) => (
              <TouchableOpacity 
                key={student.student_id}
                onPress={() => router.push(`/(mentor)/student/${student.student_id}` as any)}
                className={`flex-row items-center p-4 border-slate-100 dark:border-white/5 active:bg-slate-50 dark:active:bg-white/5 ${index !== cohortData.length - 1 ? 'border-b' : ''}`}
              >
                <View className="flex-1">
                  <Text className="font-semibold text-slate-900 dark:text-white text-base">
                    {student.full_name}
                  </Text>
                  <View className="flex-row items-center gap-x-3 mt-1">
                    <Text className="text-xs text-slate-500 dark:text-slate-400">{student.branch} • Sem {student.semester}</Text>
                    <Text className={`text-xs font-bold ${student.avg_attendance < 75 ? 'text-amber-500' : 'text-slate-500'}`}>
                      Att: {student.avg_attendance ?? '-'}%
                    </Text>
                  </View>
                </View>
                
                <View className="items-end gap-y-2 ml-2">
                  <Badge 
                    label={student.risk_level || 'Low'} 
                    variant={student.risk_level === 'High' ? 'danger' : student.risk_level === 'Medium' ? 'warning' : 'success'} 
                  />
                  <ChevronRight size={16} color="#94a3b8" />
                </View>
              </TouchableOpacity>
            ))
          )}
        </View>
      </View>
      
      {/* Bottom spacer */}
      <View className="h-10" />
    </ScrollView>
  );
}
