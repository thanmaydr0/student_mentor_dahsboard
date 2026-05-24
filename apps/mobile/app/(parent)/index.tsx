import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, RefreshControl, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { router } from 'expo-router';
import { supabase } from '../../src/lib/supabase';
import { Card } from '../../src/components/ui/Card';
import { MessageSquare } from 'lucide-react-native';

export default function ParentDashboard() {
  const [loading, setLoading] = useState(true);
  const [student, setStudent] = useState<any>(null);
  const [mentorId, setMentorId] = useState<string | null>(null);

  const loadData = async () => {
    setLoading(true);
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { data: linkData } = await supabase
      .from('parent_student_links')
      .select('student_id, profiles!parent_student_links_student_id_fkey(full_name, branch, semester, mentor_id)')
      .eq('parent_id', user.id)
      .single();

    if (linkData) {
      setStudent(linkData.profiles);
      // @ts-ignore
      setMentorId(linkData.profiles?.mentor_id || null);
    }
    setLoading(false);
  };

  useEffect(() => {
    loadData();
  }, []);

  return (
    <SafeAreaView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" edges={['top']}>
      <ScrollView
        className="flex-1 px-4 pt-6"
        refreshControl={<RefreshControl refreshing={loading} onRefresh={loadData} />}
      >
        <View className="mb-6 flex-row justify-between items-center">
          <View>
            <Text className="text-2xl font-black text-slate-900 dark:text-white">Parent Portal</Text>
            <Text className="text-sm font-medium text-slate-500">Overview</Text>
          </View>
          {mentorId && (
            <TouchableOpacity 
              onPress={() => router.push(`/chat/${mentorId}`)}
              className="bg-brand-600 px-4 py-2 rounded-xl flex-row items-center gap-2"
            >
              <MessageSquare size={16} color="white" />
              <Text className="text-white font-bold">Chat Mentor</Text>
            </TouchableOpacity>
          )}
        </View>

        {!student ? (
          <Card className="items-center py-10">
            <Text className="text-slate-500 font-medium">No student linked to your account.</Text>
          </Card>
        ) : (
          <View className="gap-4">
            <Card title="Student Profile">
              <Text className="text-lg font-bold text-slate-900 dark:text-white">{student.full_name}</Text>
              <Text className="text-slate-500">{student.branch} • Semester {student.semester}</Text>
            </Card>

            <Card title="Recent Activity">
              <Text className="text-slate-500 py-4 text-center">More detailed stats coming soon...</Text>
            </Card>
          </View>
        )}
      </ScrollView>
    </SafeAreaView>
  );
}
