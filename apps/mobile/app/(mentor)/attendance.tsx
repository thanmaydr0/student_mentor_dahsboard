import React, { useState, useEffect } from 'react';
import { View, Text, ScrollView, RefreshControl, Alert, ActivityIndicator } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { Button } from '../../src/components/ui/Button';
import { supabase } from '../../src/lib/supabase';
import { ClipboardCheck, CloudDownload } from 'lucide-react-native';

export default function AttendanceScreen() {
  const [classes, setClasses] = useState<any[]>([]);
  const [isLoadingClasses, setIsLoadingClasses] = useState(true);
  const [erpData, setErpData] = useState<any[]>([]);
  const [studentsData, setStudentsData] = useState<any[]>([]);
  const [isLoadingErp, setIsLoadingErp] = useState(false);
  const [isSyncing, setIsSyncing] = useState(false);
  const [user, setUser] = useState<any>(null);

  useEffect(() => {
    async function loadData() {
      const { data: { user } } = await supabase.auth.getUser();
      setUser(user);
      if (!user) return;

      const { data: classesData } = await supabase
        .from('classes')
        .select(`id, semester, subjects ( name, code )`)
        .eq('mentor_id', user.id);
        
      if (classesData) setClasses(classesData);

      const { data: students } = await supabase
        .from('profiles')
        .select('id, full_name')
        .eq('mentor_id', user.id)
        .eq('role', 'student');

      if (students) setStudentsData(students);

      setIsLoadingClasses(false);
      fetchErpData(classesData?.map(c => c.id) || []);
    }
    loadData();
  }, []);

  const fetchErpData = async (classIds: string[]) => {
    if (classIds.length === 0) return;
    setIsLoadingErp(true);
    const { data, error } = await supabase
      .from('erp_attendance_summary')
      .select('*')
      .in('class_id', classIds);
    
    if (data) setErpData(data);
    setIsLoadingErp(false);
  };

  const handleSyncErp = async () => {
    setIsSyncing(true);
    try {
      const { data, error } = await supabase.functions.invoke('erp-attendance-sync');
      if (error) throw new Error(error.message);
      if (data?.error) throw new Error(data.error);
      
      Alert.alert('Success', data?.message || 'Synced successfully');
      fetchErpData(classes.map(c => c.id));
    } catch (err: any) {
      Alert.alert('Sync Failed', err.message || 'Failed to sync ERP attendance');
    }
    setIsSyncing(false);
  };

  if (isLoadingClasses) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <ActivityIndicator size="large" color="#0d9488" />
      </View>
    );
  }

  return (
    <ScrollView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" contentContainerStyle={{ padding: 16, gap: 16 }}>
      <View className="mt-8">
        <Text className="text-2xl font-bold text-slate-900 dark:text-white flex-row items-center">
          ERP Attendance
        </Text>
        <Text className="text-slate-500 dark:text-slate-400 mt-1">
          Automatically sync and view attendance.
        </Text>
      </View>

      <Button 
        title="Sync ERP Attendance" 
        onPress={handleSyncErp} 
        loading={isSyncing} 
      />

      {isLoadingErp ? (
        <ActivityIndicator size="large" color="#0d9488" className="mt-8" />
      ) : erpData.length === 0 ? (
        <Card className="items-center py-10 mt-4">
          <ClipboardCheck size={32} color="#94a3b8" />
          <Text className="text-slate-500 mt-2">No ERP attendance data found.</Text>
        </Card>
      ) : (
        <View className="mt-4 gap-4">
          {erpData.map(record => {
            const student = studentsData.find(s => s.id === record.student_id);
            const cls = classes.find(c => c.id === record.class_id);
            
            return (
              <Card key={record.id} className="p-4">
                <Text className="font-bold text-lg text-slate-900 dark:text-white">{student?.full_name || 'Unknown'}</Text>
                <Text className="text-slate-500 dark:text-slate-400 text-sm mb-3">{cls?.subjects?.name || 'Unknown Subject'}</Text>
                
                <View className="flex-row justify-between">
                  <View className="w-[48%] bg-blue-50 dark:bg-blue-950/30 p-3 rounded-lg border border-blue-100 dark:border-blue-900/30">
                    <Text className="text-xs font-bold text-blue-600 dark:text-blue-400 uppercase tracking-wider mb-2">Theory</Text>
                    <View className="flex-row justify-between mb-1">
                      <Text className="text-slate-500 text-xs">Held / Att</Text>
                      <Text className="text-slate-700 dark:text-slate-300 font-bold text-xs">{record.theory_held} / {record.theory_attended}</Text>
                    </View>
                    <View className="flex-row justify-between">
                      <Text className="text-slate-500 text-xs">Percentage</Text>
                      <Text className={`font-bold text-xs ${record.theory_percentage < 75 ? 'text-red-500' : 'text-emerald-600'}`}>{record.theory_percentage}%</Text>
                    </View>
                  </View>

                  <View className="w-[48%] bg-purple-50 dark:bg-purple-950/30 p-3 rounded-lg border border-purple-100 dark:border-purple-900/30">
                    <Text className="text-xs font-bold text-purple-600 dark:text-purple-400 uppercase tracking-wider mb-2">Lab</Text>
                    <View className="flex-row justify-between mb-1">
                      <Text className="text-slate-500 text-xs">Held / Att</Text>
                      <Text className="text-slate-700 dark:text-slate-300 font-bold text-xs">{record.lab_held} / {record.lab_attended}</Text>
                    </View>
                    <View className="flex-row justify-between">
                      <Text className="text-slate-500 text-xs">Percentage</Text>
                      <Text className={`font-bold text-xs ${record.lab_percentage < 75 ? 'text-red-500' : 'text-emerald-600'}`}>{record.lab_percentage}%</Text>
                    </View>
                  </View>
                </View>
              </Card>
            );
          })}
        </View>
      )}
      <View className="h-20" />
    </ScrollView>
  );
}
