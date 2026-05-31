import { supabase } from '../../lib/supabase';
import CircuitBreaker from 'opossum';

export interface AIService {
  generateResponse(systemPrompt: string, userPrompt: string, temperature?: number): Promise<string>;
}

export class OpenAIService implements AIService {
  private breaker: CircuitBreaker;

  constructor() {
    // Fail circuit if 5 consecutive errors, keep open for 30s
    this.breaker = new CircuitBreaker(this.makeRequest.bind(this), {
      errorThresholdPercentage: 50, // Not explicitly consecutive but 50% errors trips it
      resetTimeout: 30000, 
      volumeThreshold: 5 // Min 5 requests before considering error rates
    });
    
    this.breaker.fallback(() => {
      throw new Error("OpenAI API is currently overloaded or down. Please try again later.");
    });
  }

  private async makeRequest(systemPrompt: string, userPrompt: string, temperature: number = 0.5): Promise<string> {
    const { data, error } = await supabase.functions.invoke('openai-proxy', {
      body: {
        model: 'gpt-4o-mini',
        temperature,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt }
        ]
      }
    });

    if (error) {
      throw new Error(`Proxy Error: ${error.message}`);
    }

    return data?.choices?.[0]?.message?.content || '';
  }

  async generateResponse(systemPrompt: string, userPrompt: string, temperature: number = 0.5): Promise<string> {
    return this.breaker.fire(systemPrompt, userPrompt, temperature) as Promise<string>;
  }
}

export const aiService = new OpenAIService();
