import { supabase } from '../../lib/supabase';
import { CircuitBreaker } from '../../utils/CircuitBreaker';

export interface AIService {
  generateResponse(systemPrompt: string, userPrompt: string, temperature?: number): Promise<string>;
}

export class OpenAIService implements AIService {
  private breaker: CircuitBreaker<[string, string, number?], string>;

  constructor() {
    this.breaker = new CircuitBreaker(this.makeRequest.bind(this), {
      failureThreshold: 5,
      resetTimeout: 30000 
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
