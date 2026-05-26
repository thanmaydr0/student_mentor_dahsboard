import React from 'react';
import { View, Text } from 'react-native';

export default function ProfileScreen() {
  return (
    <View className="flex-1 items-center justify-center bg-slate-50 dark:bg-[#0c0d10]">
      <Text className="text-lg font-semibold text-slate-700 dark:text-slate-300">Profile</Text>
      <Text className="text-slate-500 dark:text-slate-400 mt-2">Coming soon</Text>
    </View>
  );
}
