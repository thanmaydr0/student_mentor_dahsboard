import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './.env' });
dotenv.config({ path: './apps/web/.env' });

const supabase = createClient(process.env.VITE_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co', process.env.VITE_SUPABASE_ANON_KEY || '');

async function run() {
  const { data, error } = await supabase.from('profiles').select('*').limit(1);
  console.log('Profiles data:', data);
  if (error) console.error(error);
}
run();
