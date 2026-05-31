import { supabase } from '../../lib/supabase';
import { CircuitBreaker } from '../../utils/CircuitBreaker';

export interface MessagingService {
  sendMessage(toStudentId: string, messageBody: string): Promise<void>;
}

export class TelegramService implements MessagingService {
  private breaker: CircuitBreaker<[string, string], void>;

  constructor() {
    this.breaker = new CircuitBreaker(this.makeRequest.bind(this), {
      failureThreshold: 5,
      resetTimeout: 30000 
    });
    
    this.breaker.fallback(() => {
      throw new Error("Telegram API is currently overloaded or down. Please try again later.");
    });
  }

  private async makeRequest(toStudentId: string, messageBody: string): Promise<void> {
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

  async sendMessage(toStudentId: string, messageBody: string): Promise<void> {
    return this.breaker.fire(toStudentId, messageBody) as Promise<void>;
  }
}

export const telegramService = new TelegramService();
