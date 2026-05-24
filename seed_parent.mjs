import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://xjfpksstjolmfhaaajtt.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqZnBrc3N0am9sbWZoYWFhanR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1NzUzNjgsImV4cCI6MjA5NDE1MTM2OH0.gJmm5lSdG5KUne6JgrFBv3CYzT7M2--HEJVrJuq9dPY';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function signUpUser(email, password, metadata) {
  const { data: authData, error: authError } = await supabase.auth.signUp({
    email,
    password,
    options: { data: metadata }
  });

  if (authError) {
    if (authError.message.includes('already registered')) {
        const { data: loginData } = await supabase.auth.signInWithPassword({ email, password });
        return loginData.user.id;
    }
    throw authError;
  }
  
  // Call RPC to create profile manually just in case trigger fails
  await supabase.rpc('create_profile', {
    p_user_id: authData.user.id,
    p_full_name: metadata.full_name,
    p_role: metadata.role,
    p_branch: metadata.branch || 'CSE',
    p_semester: metadata.semester || 1,
  });

  return authData.user.id;
}

async function seedData() {
  console.log('Seeding Mentor: Neha Pandey...');
  const mentorId = await signUpUser('neha.pandey@edupredict.com', 'Password123!', {
      full_name: 'Neha Pandey',
      role: 'mentor',
      branch: 'CSE',
      semester: 1
  });
  console.log(`Mentor ID: ${mentorId}`);

  console.log('Seeding Student: Sejal Kumari...');
  const studentId = await signUpUser('sejal.kumari@edupredict.com', 'Password123!', {
      full_name: 'Sejal Kumari',
      role: 'student',
      branch: 'CSE',
      semester: 4
  });
  console.log(`Student ID: ${studentId}`);
  
  // Link student to mentor
  await supabase.from('profiles').update({ mentor_id: mentorId }).eq('id', studentId);

  console.log('Seeding Parent...');
  const parentId = await signUpUser('sejal.parent@edupredict.com', 'Password123!', {
      full_name: 'Parent of Sejal',
      role: 'parent',
      branch: 'N/A',
      semester: 0
  });
  console.log(`Parent ID: ${parentId}`);

  console.log('Linking Parent to Student...');
  const { error: linkError } = await supabase
    .from('parent_student_links')
    .insert({ parent_id: parentId, student_id: studentId });

  if (linkError) {
     if (linkError.code === '23505') console.log('Already linked.');
     else console.error('Link Error:', linkError);
  } else {
     console.log('Successfully linked!');
  }

  console.log('\n--- Accounts Created ---');
  console.log('Mentor: neha.pandey@edupredict.com / Password123!');
  console.log('Student: sejal.kumari@edupredict.com / Password123!');
  console.log('Parent: sejal.parent@edupredict.com / Password123!');
}

seedData();
