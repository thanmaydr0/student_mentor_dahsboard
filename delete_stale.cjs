const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({path: 'supabase/functions/.env'});

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

(async () => {
  const { data: profiles } = await supabase.from('profiles').select('*').eq('full_name', 'Amogh Sai Ykuntam');
  if (!profiles || profiles.length === 0) return console.log("No Amogh");
  const amogh = profiles[0];
  
  const { error } = await supabase.from('erp_attendance_summary').delete().eq('student_id', amogh.id);
  if (error) console.error("Error deleting:", error);
  else console.log("Deleted old attendance records for Amogh!");
})();
