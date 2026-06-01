import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { createClient } from '@supabase/supabase-js';
import rateLimit from 'express-rate-limit';

dotenv.config();

const app = express();

// Load Shedder: Reject requests if Event Loop is heavily backlogged
let eventLoopLag = 0;
setInterval(() => {
  const start = Date.now();
  setImmediate(() => { eventLoopLag = Date.now() - start; });
}, 1000);

app.use((req, res, next) => {
  if (eventLoopLag > 150) { // If lag > 150ms, shed load
    return res.status(429).json({ error: 'Too Many Requests - Server Under Heavy Load' });
  }
  next();
});

// Rate Limiter: Max 100 requests per IP per minute
const apiLimiter = rateLimit({
  windowMs: 1 * 60 * 1000, 
  max: 100,
  message: { error: 'Too many requests from this IP, please try again after a minute' }
});

app.use(cors());
app.use(express.json());
app.use(apiLimiter);

const supabaseUrl = process.env.SUPABASE_URL || 'http://localhost';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY || 'dummy';
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

// Basic Health Check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'EduPredict Backend API is running' });
});

// Secure OpenAI Proxy Route
app.post('/api/ai/generate', async (req, res) => {
  const { systemPrompt, userPrompt, temperature, userId } = req.body;
  const apiKey = process.env.OPENAI_API_KEY;

  if (!apiKey) {
    return res.status(500).json({ error: 'OpenAI API key not configured on server' });
  }

  let aiModel = 'gpt-4o-mini'; // Default free tier model

  try {
    // Securely verify Premium status using Supabase Admin
    if (userId) {
      const { data } = await supabaseAdmin
        .from('user_subscriptions')
        .select('is_premium, premium_until')
        .eq('user_id', userId)
        .single();

      if (data?.is_premium) {
        // Upgrade to the heavy-duty model!
        aiModel = 'gpt-4o';
      }
    }

    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`
      },
      body: JSON.stringify({
        model: aiModel,
        temperature: temperature || 0.5,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt }
        ]
      })
    });

    if (!response.ok) {
      const errorData = await response.json();
      return res.status(response.status).json({ error: errorData.error?.message || 'OpenAI Error' });
    }

    const data = await response.json();
    res.json({ content: data.choices?.[0]?.message?.content || '' });
  } catch (error: any) {
    console.error('OpenAI Proxy Error:', error);
    res.status(500).json({ error: 'Failed to contact OpenAI' });
  }
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
