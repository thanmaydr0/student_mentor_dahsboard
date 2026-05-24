import React, { useState } from 'react';
import { View, Text, Alert } from 'react-native';
import { router } from 'expo-router';
import { Input } from '../../src/components/ui/Input';
import { Button } from '../../src/components/ui/Button';
import { Card } from '../../src/components/ui/Card';
import { supabase } from '../../src/lib/supabase';

export default function AuthScreen() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleLogin() {
    if (!email || !password) {
      Alert.alert('Error', 'Please enter both email and password');
      return;
    }
    setLoading(true);
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    setLoading(false);

    if (error) {
      Alert.alert('Login Failed', error.message);
    } else if (data.user) {
      // Fetch profile to get role
      const { data: profile } = await supabase
        .from('profiles')
        .select('role')
        .eq('id', data.user.id)
        .single();
        
      if (profile?.role === 'mentor') {
        router.replace('/(mentor)');
      } else if (profile?.role === 'parent') {
        router.replace('/(parent)');
      } else {
        router.replace('/(student)');
      }
    }
  }

  return (
    <View className="flex-1 justify-center bg-slate-50 dark:bg-[#0c0d10] p-4">
      <View className="items-center mb-8">
        <Text className="text-3xl font-black text-brand-600 dark:text-brand-400">EduPredict</Text>
        <Text className="text-slate-500 dark:text-slate-400 mt-2">Sign in to your account</Text>
      </View>
      <Card title="Login">
        <View className="flex flex-col gap-4">
          <Input 
            label="Email" 
            placeholder="Enter your email"
            value={email}
            onChangeText={setEmail}
            autoCapitalize="none"
            keyboardType="email-address"
          />
          <Input 
            label="Password" 
            placeholder="••••••••"
            value={password}
            onChangeText={setPassword}
            secureTextEntry
          />
          <View className="pt-2">
            <Button 
              title="Sign In" 
              onPress={handleLogin} 
              loading={loading}
              fullWidth
            />
          </View>
        </View>
      </Card>
    </View>
  );
}
