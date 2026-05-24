import React from 'react';
import { View, Text } from 'react-native';

interface CardProps {
  children: React.ReactNode;
  className?: string;
  title?: React.ReactNode;
  action?: React.ReactNode;
}

export function Card({ children, className = '', title, action }: CardProps) {
  return (
    <View className={`bg-white dark:bg-[#13151a]/50 rounded-2xl border border-slate-200 dark:border-white/10 shadow-sm overflow-hidden ${className}`}>
      {(title || action) && (
        <View className="flex flex-row items-center justify-between border-b border-slate-100 dark:border-white/5 px-5 py-4">
          <View>
            {typeof title === 'string' ? (
              <Text className="font-bold text-slate-900 dark:text-white text-base">{title}</Text>
            ) : (
              title
            )}
          </View>
          {action && <View>{action}</View>}
        </View>
      )}
      <View className="p-5">{children}</View>
    </View>
  );
}
