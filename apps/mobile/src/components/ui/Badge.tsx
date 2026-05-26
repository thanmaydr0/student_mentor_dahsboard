import React from 'react';
import { View, Text } from 'react-native';

interface BadgeProps {
  label: string;
  variant?: 'default' | 'success' | 'warning' | 'danger';
  className?: string;
}

export function Badge({ label, variant = 'default', className = '' }: BadgeProps) {
  let bgClass = '';
  let textClass = '';

  switch (variant) {
    case 'default':
      bgClass = 'bg-slate-100 dark:bg-slate-800 border-slate-200 dark:border-slate-700';
      textClass = 'text-slate-700 dark:text-slate-300';
      break;
    case 'success':
      bgClass = 'bg-emerald-100 dark:bg-emerald-950/40 border-emerald-200 dark:border-emerald-900/50';
      textClass = 'text-emerald-700 dark:text-emerald-400';
      break;
    case 'warning':
      bgClass = 'bg-amber-100 dark:bg-amber-950/40 border-amber-200 dark:border-amber-900/50';
      textClass = 'text-amber-700 dark:text-amber-400';
      break;
    case 'danger':
      bgClass = 'bg-red-100 dark:bg-red-950/40 border-red-200 dark:border-red-900/50';
      textClass = 'text-red-700 dark:text-red-400';
      break;
  }

  return (
    <View className={`self-start px-2.5 py-0.5 rounded-full border ${bgClass} ${className}`}>
      <Text className={`text-xs font-bold ${textClass}`}>{label}</Text>
    </View>
  );
}
