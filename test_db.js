import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://xjfpksstjolmfhaaajtt.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqZnBrc3N0am9sbWZoYWFhanR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1NzUzNjgsImV4cCI6MjA5NDE1MTM2OH0.gJmm5lSdG5KUne6JgrFBv3CYzT7M2--HEJVrJuq9dPY';

const supabase = createClient(supabaseUrl, supabaseKey);

async function check() {
  const { data, error } = await supabase.from('fee_payments').select('*');
  console.log('Fee Payments:', data, error);
}

check();
