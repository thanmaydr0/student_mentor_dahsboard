const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

(async () => {
  const { data: profiles } = await supabase.from('profiles').select('*').eq('full_name', 'Amogh Sai Ykuntam');
  if (!profiles || profiles.length === 0) return console.log("No Amogh");
  const amogh = profiles[0];
  
  const { data: enrollments } = await supabase.from('enrollments').select('class_id, classes(subject_id, subjects(name))').eq('student_id', amogh.id);
  
  console.log("Amogh enrollments:", JSON.stringify(enrollments, null, 2));
})();
