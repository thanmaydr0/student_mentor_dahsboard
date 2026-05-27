import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './.env' });
dotenv.config({ path: './apps/web/.env' });

const supabase = createClient(
  process.env.VITE_SUPABASE_URL || 'https://xjfpksstjolmfhaaajtt.supabase.co',
  process.env.SUPABASE_SERVICE_ROLE_KEY || ''
);

async function run() {
  const { data, error } = await supabase.from('profiles').select('*').ilike('full_name', '%sejal%').limit(1);
  if (error) {
    console.error('Error fetching sejal:', error);
    return;
  }
  console.log('Sejal data:', JSON.stringify(data, null, 2));
}
run();
