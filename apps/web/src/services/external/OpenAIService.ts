import { supabase } from '../../lib/supabase';

export interface AIService {
  generateResponse(systemPrompt: string, userPrompt: string, temperature?: number): Promise<string>;
}

export class OpenAIService implements AIService {
  async generateResponse(systemPrompt: string, userPrompt: string, temperature: number = 0.5): Promise<string> {
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
}

export const aiService = new OpenAIService();
