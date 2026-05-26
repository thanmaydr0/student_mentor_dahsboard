import React, { useEffect, useState, useMemo } from 'react';
import { View, Text, ScrollView, RefreshControl, ActivityIndicator, Image } from 'react-native';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';
import { Trophy, Star, Target, Flame } from 'lucide-react-native';

const LEVEL_THRESHOLDS = [
  { min: 0, title: 'Rookie', color: 'text-slate-500', bg: 'bg-slate-100', emoji: '🌱' },
  { min: 250, title: 'Scholar', color: 'text-blue-600', bg: 'bg-blue-50', emoji: '📚' },
  { min: 500, title: 'Achiever', color: 'text-emerald-600', bg: 'bg-emerald-50', emoji: '⭐' },
  { min: 750, title: 'Champion', color: 'text-purple-600', bg: 'bg-purple-50', emoji: '🏆' },
  { min: 1000, title: 'Legend', color: 'text-amber-600', bg: 'bg-amber-50', emoji: '👑' },
];

function getLevel(xp: number) {
  let level = LEVEL_THRESHOLDS[0];
  for (const l of LEVEL_THRESHOLDS) {
    if (xp >= l.min) level = l;
  }
  return level;
}

function computeXP(s: any): { xp: number; sgpa: number } {
  const att = s.avg_attendance ?? 0;
  const score = s.avg_total_score ?? 0;
  const fails = s.failing_subjects ?? 0;

  const attendanceScore = Math.round((att / 100) * 300);
  const marksScore = Math.round((score / 100) * 350);
  const failPenalty = fails * 50;
  const perfectBonus = att >= 95 ? 50 : att >= 85 ? 25 : 0;
  const scorerBonus = score >= 90 ? 50 : score >= 80 ? 25 : 0;

  const xp = Math.max(0, attendanceScore + marksScore - failPenalty + perfectBonus + scorerBonus);

  let sgpa = 0;
  if (score >= 85) sgpa = 10;
  else if (score >= 70) sgpa = 8;
  else if (score >= 55) sgpa = 6;
  else if (score >= 40) sgpa = 4;
  else sgpa = 0;

  return { xp, sgpa };
}

export default function LeaderboardScreen() {
  const [user, setUser] = useState<any>(null);
  const [profile, setProfile] = useState<any>(null);
  const [cohortData, setCohortData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchDashboardData = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;
    setUser(user);

    const { data: profileData } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single();

    setProfile(profileData);

    if (profileData?.mentor_id) {
      const { data, error } = await supabase.rpc('get_mentor_cohort_summary', {
        p_mentor_id: profileData.mentor_id
      });
      if (data) setCohortData(data);
    }

    setLoading(false);
    setRefreshing(false);
  };

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const rankedStudents = useMemo(() => {
    if (!cohortData) return [];

    const withXP = cohortData.map((s: any) => {
      const { xp, sgpa } = computeXP(s);
      const level = getLevel(xp);
      return {
        ...s,
        xp,
        sgpa,
        levelTitle: level.title,
        emoji: level.emoji,
        isYou: s.student_id === user?.id,
      };
    });

    withXP.sort((a: any, b: any) => b.xp - a.xp);
    
    return withXP.map((s: any, i: number) => ({ ...s, rank: i + 1 }));
  }, [cohortData, user]);

  const topThree = rankedStudents.slice(0, 3);
  const restStudents = rankedStudents.slice(3);

  if (loading) {
    return (
      <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
        <ActivityIndicator size="large" color="#f59e0b" />
      </View>
    );
  }

  return (
    <ScrollView 
      className="flex-1 bg-slate-50 dark:bg-[#0c0d10]"
      contentContainerStyle={{ padding: 16, gap: 16 }}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={() => { setRefreshing(true); fetchDashboardData(); }} />}
    >
      <View className="mt-8 mb-4 items-center">
        <View className="flex-row items-center bg-amber-100 dark:bg-amber-900/30 px-4 py-1.5 rounded-full mb-3 border border-amber-200 dark:border-amber-700/50">
          <Trophy size={16} color="#d97706" />
          <Text className="text-amber-700 dark:text-amber-400 font-bold ml-2">Class Leaderboard</Text>
        </View>
        <Text className="text-2xl font-black text-slate-900 dark:text-white">Who's on 🔥?</Text>
      </View>

      {/* Podium */}
      {topThree.length > 0 && (
        <View className="flex-row items-end justify-center h-48 gap-4 mb-4 mt-2">
          {/* 2nd Place */}
          {topThree[1] && (
            <View className="items-center w-[30%]">
              <View className="w-12 h-12 rounded-full bg-slate-300 dark:bg-slate-600 justify-center items-center mb-2 relative">
                <Text className="font-bold text-lg text-slate-700 dark:text-slate-200">{topThree[1].full_name.charAt(0)}</Text>
                <Text className="absolute -bottom-2 -right-2 text-xl">🥈</Text>
              </View>
              <Text className="text-xs font-bold text-slate-800 dark:text-slate-200" numberOfLines={1}>{topThree[1].full_name.split(' ')[0]}</Text>
              <Text className="text-[10px] font-bold text-indigo-600 dark:text-indigo-400 mt-1">{topThree[1].xp} XP</Text>
              <View className="w-full h-24 bg-slate-300 dark:bg-slate-700 rounded-t-xl mt-2 justify-start items-center pt-2">
                <Text className="text-xl font-black text-slate-500 dark:text-slate-400">#2</Text>
              </View>
            </View>
          )}

          {/* 1st Place */}
          {topThree[0] && (
            <View className="items-center w-[30%]">
              <View className="w-16 h-16 rounded-full bg-amber-400 justify-center items-center mb-2 relative">
                <Text className="font-bold text-2xl text-amber-900">{topThree[0].full_name.charAt(0)}</Text>
                <Text className="absolute -bottom-2 -right-2 text-2xl">🥇</Text>
              </View>
              <Text className="text-sm font-bold text-slate-800 dark:text-slate-200" numberOfLines={1}>{topThree[0].full_name.split(' ')[0]}</Text>
              <Text className="text-[10px] font-bold text-indigo-600 dark:text-indigo-400 mt-1">{topThree[0].xp} XP</Text>
              <View className="w-full h-32 bg-amber-400 dark:bg-amber-600 rounded-t-xl mt-2 justify-start items-center pt-2">
                <Text className="text-2xl font-black text-amber-700 dark:text-amber-900">#1</Text>
              </View>
            </View>
          )}

          {/* 3rd Place */}
          {topThree[2] && (
            <View className="items-center w-[30%]">
              <View className="w-12 h-12 rounded-full bg-orange-300 dark:bg-orange-700 justify-center items-center mb-2 relative">
                <Text className="font-bold text-lg text-orange-900 dark:text-orange-100">{topThree[2].full_name.charAt(0)}</Text>
                <Text className="absolute -bottom-2 -right-2 text-xl">🥉</Text>
              </View>
              <Text className="text-xs font-bold text-slate-800 dark:text-slate-200" numberOfLines={1}>{topThree[2].full_name.split(' ')[0]}</Text>
              <Text className="text-[10px] font-bold text-indigo-600 dark:text-indigo-400 mt-1">{topThree[2].xp} XP</Text>
              <View className="w-full h-20 bg-orange-300 dark:bg-orange-800 rounded-t-xl mt-2 justify-start items-center pt-2">
                <Text className="text-lg font-black text-orange-700 dark:text-orange-400">#3</Text>
              </View>
            </View>
          )}
        </View>
      )}

      {/* List */}
      <Card className="p-0 overflow-hidden">
        {restStudents.map((student, idx) => (
          <View 
            key={student.student_id} 
            className={`flex-row items-center p-4 ${student.isYou ? 'bg-indigo-50 dark:bg-indigo-900/20 border-l-4 border-indigo-500' : ''} ${idx !== restStudents.length - 1 ? 'border-b border-slate-100 dark:border-slate-800' : ''}`}
          >
            <Text className="text-sm font-black w-8 text-slate-400">#{student.rank}</Text>
            
            <View className="flex-1 flex-row items-center">
              <View className="w-10 h-10 rounded-full bg-slate-100 dark:bg-slate-800 justify-center items-center mr-3">
                <Text className="font-bold text-slate-700 dark:text-slate-300">{student.full_name.charAt(0)}</Text>
              </View>
              <View>
                <View className="flex-row items-center gap-2">
                  <Text className="font-bold text-slate-900 dark:text-white text-base">{student.full_name.split(' ')[0]}</Text>
                  {student.isYou && <View className="bg-indigo-100 dark:bg-indigo-900/50 px-2 py-0.5 rounded-full"><Text className="text-[10px] font-bold text-indigo-700 dark:text-indigo-300">YOU</Text></View>}
                </View>
                <Text className="text-xs text-slate-500">{student.emoji} {student.levelTitle}</Text>
              </View>
            </View>

            <View className="items-end">
              <Text className="font-black text-slate-800 dark:text-slate-200">{student.xp}</Text>
              <Text className="text-[10px] font-bold text-slate-400">XP</Text>
            </View>
          </View>
        ))}
      </Card>
      
      <View className="h-20" />
    </ScrollView>
  );
}
