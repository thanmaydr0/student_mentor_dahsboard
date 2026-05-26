import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator, TouchableOpacity } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { ChevronRight, Award, Calendar, BookOpen } from 'lucide-react-native';
import { router } from 'expo-router';

export default function StudentDashboard() {
  const [profile, setProfile] = useState<any>(null);
  const [attendance, setAttendance] = useState<any[]>([]);
  const [iatMarks, setIatMarks] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchDashboardData = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    // Fetch Profile
    const { data: profileData } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single();
    setProfile(profileData);

    // Fetch Attendance via RPC
    const { data: attData } = await supabase.rpc('get_attendance_summary', { p_student_id: user.id });
    if (attData) setAttendance(attData);

    // Fetch Recent Assessments (IAT Marks)
    const { data: enrollments } = await supabase.from('enrollments').select('class_id').eq('student_id', user.id);
    if (enrollments && enrollments.length > 0) {
      const classIds = enrollments.map((e: any) => e.class_id);
      
      const { data: marks } = await supabase
        .from('iat_marks')
        .select('*')
        .eq('student_id', user.id);
        
      const { data: classes } = await supabase.from('classes').select('id, subjects(name)').in('id', classIds);
      
      const combinedMarks = marks?.map(m => {
        const cls = classes?.find(c => c.id === m.class_id);
        return {
          ...m,
          subject_name: cls?.subjects?.name || 'Unknown Subject'
        };
      }) || [];
      
      setIatMarks(combinedMarks);
    }

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

  // Calculate total attendance percentage
  const totalAttClasses = attendance.reduce((acc, curr) => acc + Number(curr.total_count), 0);
  const totalAttPresent = attendance.reduce((acc, curr) => acc + Number(curr.present_count), 0);
  const overallAttPercentage = totalAttClasses > 0 ? Math.round((totalAttPresent / totalAttClasses) * 100) : 0;

  return (
    <ScrollView 
      className="flex-1 bg-slate-50 dark:bg-[#0c0d10]"
      contentContainerStyle={{ padding: 16, gap: 16 }}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={() => { setRefreshing(true); fetchDashboardData(); }} />}
    >
      <View className="mt-8 mb-4 flex-row justify-between items-center">
        <View>
          <Text className="text-2xl font-bold text-slate-900 dark:text-white">
            Hi, {profile?.full_name?.split(' ')[0]}!
          </Text>
          <Text className="text-slate-500 dark:text-slate-400">
            Semester {profile?.semester} • {profile?.branch}
          </Text>
        </View>
        <TouchableOpacity 
          className="p-3 bg-brand-100 dark:bg-brand-900/30 rounded-full"
          onPress={() => router.push('/(student)/leaderboard' as any)}
        >
          <Award size={24} color="#0d9488" />
        </TouchableOpacity>
      </View>

      <View className="flex-row gap-4 mb-2">
        <View className="flex-1">
          <Card className="items-center py-6">
            <BookOpen size={24} color="#3b82f6" className="mb-2" />
            <Text className="text-3xl font-bold text-slate-900 dark:text-white">{overallAttPercentage}%</Text>
            <Text className="text-xs text-slate-500 font-medium">ATTENDANCE</Text>
          </Card>
        </View>
        <View className="flex-1">
          <Card className="items-center py-6">
            <Calendar size={24} color="#8b5cf6" className="mb-2" />
            <Text className="text-3xl font-bold text-slate-900 dark:text-white">0.0</Text>
            <Text className="text-xs text-slate-500 font-medium">EST. SGPA</Text>
          </Card>
        </View>
      </View>

      <Card title="Subject Attendance">
        {attendance.length === 0 ? (
          <Text className="text-slate-500 text-center py-4">No attendance data yet.</Text>
        ) : (
          <View className="gap-y-4 mt-2">
            {attendance.map((att, idx) => (
              <View key={idx}>
                <View className="flex-row justify-between mb-1">
                  <Text className="text-slate-700 dark:text-slate-200 font-medium text-sm flex-1 mr-2" numberOfLines={1}>{att.subject_name}</Text>
                  <Text className={`font-bold ${Number(att.percentage) < 75 ? 'text-red-500' : 'text-emerald-500'}`}>{Math.round(att.percentage)}%</Text>
                </View>
                <View className="h-2 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                  <View 
                    className={`h-full ${Number(att.percentage) < 75 ? 'bg-red-500' : 'bg-emerald-500'}`} 
                    style={{ width: `${Math.round(att.percentage)}%` }} 
                  />
                </View>
              </View>
            ))}
          </View>
        )}
      </Card>

      <Card title="Recent Assessments (IAT)">
        {iatMarks.length === 0 ? (
          <Text className="text-slate-500 text-center py-4">No IAT marks recorded yet.</Text>
        ) : (
          <View className="gap-y-4 mt-2">
            {iatMarks.map((mark, idx) => (
              <View key={idx} className={`pb-3 ${idx !== iatMarks.length -1 ? 'border-b border-slate-100 dark:border-slate-800' : ''}`}>
                <Text className="font-semibold text-slate-800 dark:text-slate-200 mb-2">{mark.subject_name}</Text>
                <View className="flex-row flex-wrap gap-2">
                  {mark.iat1 !== null && (
                    <View className="bg-purple-50 dark:bg-purple-900/20 px-3 py-1.5 rounded-lg border border-purple-100 dark:border-purple-800">
                      <Text className="text-xs text-purple-600 dark:text-purple-400">IAT 1: <Text className="font-bold">{mark.iat1}/50</Text></Text>
                    </View>
                  )}
                  {mark.iat2 !== null && (
                    <View className="bg-purple-50 dark:bg-purple-900/20 px-3 py-1.5 rounded-lg border border-purple-100 dark:border-purple-800">
                      <Text className="text-xs text-purple-600 dark:text-purple-400">IAT 2: <Text className="font-bold">{mark.iat2}/50</Text></Text>
                    </View>
                  )}
                  {mark.assignment1 !== null && (
                    <View className="bg-blue-50 dark:bg-blue-900/20 px-3 py-1.5 rounded-lg border border-blue-100 dark:border-blue-800">
                      <Text className="text-xs text-blue-600 dark:text-blue-400">Ass 1: <Text className="font-bold">{mark.assignment1}/50</Text></Text>
                    </View>
                  )}
                </View>
              </View>
            ))}
          </View>
        )}
      </Card>

      <Card title="Advanced Tools">
        <View className="flex-row gap-4 mt-2">
          <TouchableOpacity 
            className="flex-1 bg-violet-50 dark:bg-violet-900/20 p-4 rounded-xl border border-violet-100 dark:border-violet-800/50 items-center justify-center gap-2"
            onPress={() => router.push('/(student)/calendar' as any)}
          >
            <Calendar size={24} color="#6d28d9" />
            <Text className="font-bold text-violet-800 dark:text-violet-300">Calendar Parser</Text>
          </TouchableOpacity>

          <TouchableOpacity 
            className="flex-1 bg-indigo-50 dark:bg-indigo-900/20 p-4 rounded-xl border border-indigo-100 dark:border-indigo-800/50 items-center justify-center gap-2"
            onPress={() => router.push('/(student)/resources' as any)}
          >
            <BookOpen size={24} color="#4f46e5" />
            <Text className="font-bold text-indigo-800 dark:text-indigo-300">Resource Library</Text>
          </TouchableOpacity>
        </View>
      </Card>

      <View className="h-10" />
    </ScrollView>
  );
}
