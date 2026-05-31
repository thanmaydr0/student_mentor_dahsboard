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

const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

// Basic Health Check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'EduPredict Backend API is running' });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
