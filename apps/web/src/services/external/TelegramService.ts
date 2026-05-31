import { supabase } from '../../lib/supabase';

export interface MessagingService {
  sendMessage(toStudentId: string, messageBody: string): Promise<void>;
}

export class TelegramService implements MessagingService {
  async sendMessage(toStudentId: string, messageBody: string): Promise<void> {
    const { error } = await supabase.functions.invoke('telegram-bot', {
      body: {
        action: 'send_message',
        to_student_id: toStudentId,
        message_body: messageBody
      }
    });

    if (error) {
      console.error(`Failed to send telegram message to ${toStudentId}`, error);
      throw error;
    }
  }
}

export const telegramService = new TelegramService();
