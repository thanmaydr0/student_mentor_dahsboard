import React, { useState, useEffect, useRef } from 'react';
import { View, Text, TextInput, TouchableOpacity, ScrollView, KeyboardAvoidingView, Platform, Alert } from 'react-native';
import { useLocalSearchParams, router } from 'expo-router';
import { SafeAreaView } from 'react-native-safe-area-context';
import { supabase } from '../../src/lib/supabase';
import { Send, ArrowLeft, Mic, Square } from 'lucide-react-native';
import { Audio } from 'expo-av';
import * as FileSystem from 'expo-file-system';
import { decode } from 'base64-arraybuffer';

export default function MobileChat() {
  const { userId: peerId } = useLocalSearchParams<{ userId: string }>();
  const [messages, setMessages] = useState<any[]>([]);
  const [input, setInput] = useState('');
  const [myId, setMyId] = useState<string | null>(null);
  const scrollViewRef = useRef<ScrollView>(null);
  
  // Audio State
  const [recording, setRecording] = useState<Audio.Recording | null>(null);
  const [sound, setSound] = useState<Audio.Sound | null>(null);
  const [isRecording, setIsRecording] = useState(false);

  useEffect(() => {
    let channel: any;

    const init = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;
      setMyId(user.id);

      const { data } = await supabase
        .from('direct_messages')
        .select('*')
        .or(`and(sender_id.eq.${user.id},receiver_id.eq.${peerId}),and(sender_id.eq.${peerId},receiver_id.eq.${user.id})`)
        .order('created_at', { ascending: true });

      if (data) setMessages(data);

      channel = supabase.channel(`direct_messages_mobile`)
        .on('postgres_changes', {
          event: 'INSERT',
          schema: 'public',
          table: 'direct_messages',
          filter: `receiver_id=eq.${user.id}`,
        }, (payload) => {
          if (payload.new.sender_id === peerId) {
            setMessages(prev => [...prev, payload.new]);
          }
        })
        .subscribe();
    };

    init();

    return () => {
      if (channel) supabase.removeChannel(channel);
      if (sound) sound.unloadAsync();
    };
  }, [peerId]);

  const sendMessage = async () => {
    if (!input.trim() || !myId) return;

    const newMsg = {
      sender_id: myId,
      receiver_id: peerId,
      content_type: 'text',
      content_url_or_text: input.trim(),
    };

    setInput('');
    setMessages(prev => [...prev, { ...newMsg, id: Date.now().toString(), created_at: new Date().toISOString() }]);

    await supabase.from('direct_messages').insert(newMsg);
  };

  const startRecording = async () => {
    try {
      const permission = await Audio.requestPermissionsAsync();
      if (permission.status !== 'granted') return;

      await Audio.setAudioModeAsync({
        allowsRecordingIOS: true,
        playsInSilentModeIOS: true,
      });

      const { recording } = await Audio.Recording.createAsync(Audio.RecordingOptionsPresets.HIGH_QUALITY);
      setRecording(recording);
      setIsRecording(true);
    } catch (err) {
      console.error('Failed to start recording', err);
    }
  };

  const stopRecording = async () => {
    if (!recording) return;
    setIsRecording(false);
    await recording.stopAndUnloadAsync();
    const uri = recording.getURI();
    setRecording(null);

    if (uri && myId) {
      await uploadVoiceNote(uri);
    }
  };

  const uploadVoiceNote = async (uri: string) => {
    try {
      const base64 = await FileSystem.readAsStringAsync(uri, { encoding: 'base64' });
      const fileName = `${myId}-${Date.now()}.m4a`;
      const { data, error } = await supabase.storage.from('voice_notes').upload(fileName, decode(base64), { contentType: 'audio/m4a' });
      
      if (error) {
         // Create bucket if it doesn't exist
         if (error.message.includes('Bucket not found')) {
            await supabase.storage.createBucket('voice_notes', { public: true });
            await supabase.storage.from('voice_notes').upload(fileName, decode(base64), { contentType: 'audio/m4a' });
         } else {
            throw error;
         }
      }

      const { data: publicUrlData } = supabase.storage.from('voice_notes').getPublicUrl(fileName);
      
      const newMsg = {
        sender_id: myId,
        receiver_id: peerId,
        content_type: 'audio',
        content_url_or_text: publicUrlData.publicUrl,
      };

      setMessages(prev => [...prev, { ...newMsg, id: Date.now().toString(), created_at: new Date().toISOString() }]);
      await supabase.from('direct_messages').insert(newMsg);
    } catch (err) {
      Alert.alert("Upload Failed", "Could not send voice note.");
    }
  };

  const playVoiceNote = async (uri: string) => {
    try {
      if (sound) await sound.unloadAsync();
      const { sound: newSound } = await Audio.Sound.createAsync({ uri }, { shouldPlay: true });
      setSound(newSound);
    } catch (err) {
      console.log('Error playing sound', err);
    }
  };

  return (
    <SafeAreaView className="flex-1 bg-slate-50 dark:bg-[#0c0d10]" edges={['top', 'bottom']}>
      <View className="px-4 py-3 flex-row items-center border-b border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900">
        <TouchableOpacity onPress={() => router.back()} className="mr-4 p-2">
          <ArrowLeft size={24} color="#0ea5e9" />
        </TouchableOpacity>
        <Text className="text-lg font-bold text-slate-900 dark:text-white">Direct Message</Text>
      </View>

      <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : undefined} className="flex-1">
        <ScrollView 
          ref={scrollViewRef}
          onContentSizeChange={() => scrollViewRef.current?.scrollToEnd({ animated: true })}
          className="flex-1 px-4 pt-4"
        >
          {messages.map(msg => {
            const isMe = msg.sender_id === myId;
            return (
              <View key={msg.id} className={`flex-row mb-4 ${isMe ? 'justify-end' : 'justify-start'}`}>
                <View className={`max-w-[80%] p-3 rounded-2xl ${isMe ? 'bg-brand-600 rounded-br-sm' : 'bg-white dark:bg-slate-800 rounded-bl-sm border border-slate-100 dark:border-slate-700'}`}>
                  {msg.content_type === 'audio' ? (
                    <TouchableOpacity onPress={() => playVoiceNote(msg.content_url_or_text)} className="flex-row items-center gap-2">
                      <View className={`p-2 rounded-full ${isMe ? 'bg-white/20' : 'bg-brand-100'}`}>
                        <Text className={isMe ? 'text-white' : 'text-brand-600'}>▶ Play Audio</Text>
                      </View>
                    </TouchableOpacity>
                  ) : (
                    <Text className={isMe ? 'text-white' : 'text-slate-800 dark:text-slate-200'}>
                      {msg.content_url_or_text}
                    </Text>
                  )}
                </View>
              </View>
            );
          })}
        </ScrollView>

        <View className="px-4 py-3 border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 flex-row items-center gap-2">
          <TextInput
            value={input}
            onChangeText={setInput}
            placeholder="Type a message..."
            placeholderTextColor="#94a3b8"
            className="flex-1 bg-slate-100 dark:bg-slate-800 text-slate-900 dark:text-white px-4 py-3 rounded-2xl"
          />
          
          {input.trim() ? (
            <TouchableOpacity onPress={sendMessage} className="p-3 bg-brand-600 rounded-full">
              <Send size={20} color="white" />
            </TouchableOpacity>
          ) : (
            <TouchableOpacity 
              onPressIn={startRecording} 
              onPressOut={stopRecording} 
              className={`p-3 rounded-full ${isRecording ? 'bg-red-500' : 'bg-brand-600'}`}
            >
              {isRecording ? <Square size={20} color="white" /> : <Mic size={20} color="white" />}
            </TouchableOpacity>
          )}
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
