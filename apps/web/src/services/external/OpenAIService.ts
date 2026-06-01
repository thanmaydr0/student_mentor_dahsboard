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
    const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';
    
    // Get the current user session from Supabase
    const { data: { session } } = await supabase.auth.getSession();
    const userId = session?.user?.id;

    const response = await fetch(`${apiUrl}/api/ai/generate`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        systemPrompt,
        userPrompt,
        temperature,
        userId
      })
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(`Proxy Error: ${errorData.error || response.statusText}`);
    }

    const data = await response.json();
    return data.content || '';
  }

  async generateResponse(systemPrompt: string, userPrompt: string, temperature: number = 0.5): Promise<string> {
    return this.breaker.fire(systemPrompt, userPrompt, temperature) as Promise<string>;
  }
}

export const aiService = new OpenAIService();
