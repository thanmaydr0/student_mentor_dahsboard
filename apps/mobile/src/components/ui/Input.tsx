import React from 'react';
import { View, Text, TextInput, TextInputProps } from 'react-native';

interface InputProps extends TextInputProps {
  label: string;
  error?: string;
  icon?: React.ReactNode;
}

export function Input({ label, error, icon, className = '', ...props }: InputProps) {
  return (
    <View className={`w-full ${className}`}>
      <Text className="mb-1.5 text-sm font-semibold text-slate-700 dark:text-slate-200">
        {label}
      </Text>
      <View className="relative">
        {icon && (
          <View className="absolute left-3 top-0 bottom-0 justify-center z-10">
            {icon}
          </View>
        )}
        <TextInput
          className={`w-full rounded-xl border ${
            error ? 'border-red-500' : 'border-slate-200 dark:border-white/10'
          } bg-white dark:bg-white/5 py-2.5 ${icon ? 'pl-10' : 'pl-3'} pr-3 text-sm text-slate-900 dark:text-white`}
          placeholderTextColor="#94a3b8"
          {...props}
        />
      </View>
      {error && (
        <Text className="mt-1.5 text-sm font-medium text-red-500">{error}</Text>
      )}
    </View>
  );
}
