import React from 'react';
import { TouchableOpacity, Text, ActivityIndicator } from 'react-native';

interface ButtonProps {
  onPress: () => void;
  title: string;
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  disabled?: boolean;
  className?: string;
  fullWidth?: boolean;
}

export function Button({
  onPress,
  title,
  variant = 'primary',
  size = 'md',
  loading = false,
  disabled = false,
  className = '',
  fullWidth = false,
}: ButtonProps) {
  let bgClass = '';
  let textClass = '';

  switch (variant) {
    case 'primary':
      bgClass = 'bg-brand-600 active:bg-brand-700';
      textClass = 'text-white';
      break;
    case 'secondary':
      bgClass = 'bg-brand-100 active:bg-brand-200 dark:bg-brand-900 dark:active:bg-brand-800';
      textClass = 'text-brand-700 dark:text-brand-300';
      break;
    case 'ghost':
      bgClass = 'bg-transparent active:bg-slate-100 dark:active:bg-slate-800';
      textClass = 'text-slate-600 dark:text-slate-300';
      break;
    case 'danger':
      bgClass = 'bg-red-500 active:bg-red-600';
      textClass = 'text-white';
      break;
  }

  let sizeClass = '';
  switch (size) {
    case 'sm':
      sizeClass = 'py-1.5 px-3 rounded-lg';
      break;
    case 'md':
      sizeClass = 'py-2.5 px-4 rounded-xl';
      break;
    case 'lg':
      sizeClass = 'py-3.5 px-6 rounded-xl';
      break;
  }

  const baseClass = `flex flex-row items-center justify-center ${bgClass} ${sizeClass} ${fullWidth ? 'w-full' : ''} ${disabled ? 'opacity-50' : ''} ${className}`;

  return (
    <TouchableOpacity
      className={baseClass}
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.7}
    >
      {loading ? (
        <ActivityIndicator color={variant === 'primary' || variant === 'danger' ? 'white' : '#0d9488'} />
      ) : (
        <Text className={`font-semibold ${textClass} text-center`}>{title}</Text>
      )}
    </TouchableOpacity>
  );
}
