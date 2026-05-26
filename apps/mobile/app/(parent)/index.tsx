import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator, TouchableOpacity } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { BookOpen, GraduationCap, MessageSquare, AlertCircle } from 'lucide-react-native';
import { router } from 'expo-router';

export default function ParentDashboard() {
  const [studentId, setStudentId] = useState<string | null>(null);
  const [mentorId, setMentorId] = useState<string | null>(null);
  const [profile, setProfile] = useState<any>(null);
  const [attendance, setAttendance] = useState<any[]>([]);
  const [grades, setGrades] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchDashboardData = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    // Fetch Link
    const { data: linkData } = await supabase
      .from('parent_student_links')
      .select('student_id, profiles!parent_student_links_student_id_fkey(mentor_id)')
      .eq('parent_id', user.id)
      .single();

    if (linkData) {
      setStudentId(linkData.student_id);
      // @ts-ignore
      setMentorId(linkData.profiles?.mentor_id || null);

      // Fetch Profile
      const { data: profileData } = await supabase.from('profiles').select('*').eq('id', linkData.student_id).single();
      setProfile(profileData);

      // Fetch Attendance
      const { data: attData } = await supabase.rpc('get_attendance_summary', { p_student_id: linkData.student_id });
      if (attData) setAttendance(attData);

      // Fetch Grades
      const { data: enrollments } = await supabase.from('enrollments').select('class_id').eq('student_id', linkData.student_id);
      if (enrollments && enrollments.length > 0) {
        const classIds = enrollments.map((e: any) => e.class_id);
        const { data: gradesData } = await supabase.from('grades').select('*').eq('student_id', linkData.student_id).in('class_id', classIds);
        const { data: classes } = await supabase.from('classes').select('id, subjects(name)').in('id', classIds);
        
        const combinedGrades = gradesData?.map(g => {
          const cls = classes?.find(c => c.id === g.class_id);
          return { ...g, subject_name: cls?.subjects?.name || 'Unknown Subject' };
        }) || [];
        setGrades(combinedGrades);
      }
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
        <ActivityIndicator size="large" color="#0891b2" />
      </View>
    );
  }

  if (!studentId) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10] p-6">
        <AlertCircle size={48} color="#94a3b8" className="mb-4" />
        <Text className="text-xl font-bold text-slate-800 dark:text-slate-200 mb-2">No Student Linked</Text>
        <Text className="text-center text-slate-500">Please contact the administration to link your child to your parent account.</Text>
      </View>
    );
  }

  const totalAttClasses = attendance.reduce((acc, curr) => acc + Number(curr.total_count), 0);
  const totalAttPresent = attendance.reduce((acc, curr) => acc + Number(curr.present_count), 0);
  const overallAttPercentage = totalAttClasses > 0 ? Math.round((totalAttPresent / totalAttClasses) * 100) : 0;

  return (
    <ScrollView 
      className="flex-1 bg-slate-50 dark:bg-[#0c0d10]"
      contentContainerStyle={{ padding: 16, gap: 16 }}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={() => { setRefreshing(true); fetchDashboardData(); }} />}
    >
      <View className="mt-8 mb-2 flex-row justify-between items-center">
        <View>
          <Text className="text-2xl font-bold text-slate-900 dark:text-white">
            {profile?.full_name}'s Progress
          </Text>
          <Text className="text-slate-500 dark:text-slate-400 mt-1">
            Parent Dashboard
          </Text>
        </View>
      </View>

      {mentorId && (
        <TouchableOpacity 
          onPress={() => router.push(`/chat/${mentorId}` as any)}
          className="bg-cyan-600 p-4 rounded-2xl flex-row items-center justify-center gap-x-2"
        >
          <MessageSquare size={20} color="white" />
          <Text className="text-white font-bold text-base">Contact Mentor</Text>
        </TouchableOpacity>
      )}

      <View className="flex-row gap-4">
        <View className="flex-1">
          <Card className="items-center py-6">
            <BookOpen size={24} color="#0891b2" className="mb-2" />
            <Text className="text-3xl font-bold text-slate-900 dark:text-white">{overallAttPercentage}%</Text>
            <Text className="text-xs text-slate-500 font-medium text-center">OVERALL ATTENDANCE</Text>
          </Card>
        </View>
        <View className="flex-1">
          <Card className="items-center py-6">
            <GraduationCap size={24} color="#8b5cf6" className="mb-2" />
            <Text className="text-3xl font-bold text-slate-900 dark:text-white">{profile?.semester}</Text>
            <Text className="text-xs text-slate-500 font-medium text-center">SEMESTER</Text>
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

      <Card title="Grades Overview">
        {grades.length === 0 ? (
          <Text className="text-slate-500 text-center py-4">No grades recorded yet.</Text>
        ) : (
          <View className="gap-y-4 mt-2">
            {grades.map((grade, idx) => (
              <View key={idx} className={`pb-3 flex-row justify-between items-center ${idx !== grades.length -1 ? 'border-b border-slate-100 dark:border-slate-800' : ''}`}>
                <Text className="font-semibold text-slate-800 dark:text-slate-200 flex-1 mr-2" numberOfLines={1}>{grade.subject_name}</Text>
                <View className="bg-slate-100 dark:bg-slate-800 px-3 py-1 rounded-lg">
                  <Text className="font-bold text-slate-700 dark:text-slate-300">Grade: {grade.grade || '-'}</Text>
                </View>
              </View>
            ))}
          </View>
        )}
      </Card>

      <View className="h-10" />
    </ScrollView>
  );
}
