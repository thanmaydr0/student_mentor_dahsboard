import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.3";

const TELEGRAM_BOT_TOKEN = Deno.env.get('TELEGRAM_BOT_TOKEN') || '';
const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || '';
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

const TELEGRAM_API = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}`;

async function sendMessage(chatId: number, text: string) {
  try {
    const res = await fetch(`${TELEGRAM_API}/sendMessage`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ chat_id: chatId, text, parse_mode: 'HTML' })
    });
    const data = await res.json();
    if (!data.ok) console.error('[Telegram Error]', data);
  } catch (e) {
    console.error('[Telegram Send Error]', e);
  }
}

async function handleCommand(session: any, text: string, chatId: number) {
  const role = session.role;
  const targetStudentId = role === 'parent' ? session.linked_student_id : session.user_id;

  if (text === '/logout') {
    await supabase.from('telegram_sessions').delete().eq('telegram_chat_id', chatId);
    await sendMessage(chatId, 'Logged out successfully. Send /start to login again.');
    return;
  }

  if (role === 'student' || role === 'parent') {
    if (text === '/attendance') {
      const { data } = await supabase.rpc('get_attendance_summary', { p_student_id: targetStudentId });
      if (!data || data.length === 0) {
        await sendMessage(chatId, 'No attendance records found.');
      } else {
        let msg = '<b>Attendance Summary:</b>\n\n';
        data.forEach((r: any) => {
           msg += `${r.subject_name}: ${r.percentage}% (${r.present_count}/${r.total_count})\n`;
        });
        await sendMessage(chatId, msg);
      }
    } 
    else if (text === '/grades' || text === '/marks') {
      const { data } = await supabase.from('grades').select('*, classes(subjects(name))').eq('student_id', targetStudentId);
      if (!data || data.length === 0) {
         await sendMessage(chatId, 'No grades data found.');
      } else {
         let msg = '<b>Grades Overview:</b>\n\n';
         data.forEach((g: any) => {
            msg += `${g.classes?.subjects?.name}: ${g.total_score}/100 (Grade ${g.grade})\n`;
         });
         await sendMessage(chatId, msg);
      }
    }
    else if (text === '/timetable') {
       await sendMessage(chatId, 'Timetable functionality is coming soon to the bot!');
    }
    else if (text === '/help') {
      await sendMessage(chatId, '<b>Available Commands:</b>\n/attendance - View attendance\n/grades - View grades\n/timetable - View timetable\n/logout - Disconnect');
    }
    else {
      await sendMessage(chatId, 'Unknown command. Send /help for options.');
    }
  } 
  
  else if (role === 'mentor') {
    if (text.startsWith('/broadcast ')) {
       const messageBody = text.substring('/broadcast '.length);
       // Fetch students for this mentor
       const { data: students, error: sErr } = await supabase.from('profiles').select('id, full_name').eq('role', 'student').eq('mentor_id', session.user_id);
          
       if (!students || students.length === 0) {
          await sendMessage(chatId, 'No students found in your cohort.');
          return;
       }
       
       let count = 0;
       for (const student of students) {
          // Fetch parent telegram sessions linked to this student
          const { data: tsList } = await supabase.from('telegram_sessions')
             .select('telegram_chat_id')
             .eq('linked_student_id', student.id)
             .eq('role', 'parent');
             
          if (tsList && tsList.length > 0) {
             for (const ts of tsList) {
                await sendMessage(ts.telegram_chat_id, `📢 <b>Message from Mentor (regarding ${student.full_name}):</b>\n\n${messageBody}`);
                count++;
             }
          }
       }
       await sendMessage(chatId, `Broadcast sent to ${count} connected parents.`);
    }
    else if (text.startsWith('/broadcastmail ') || text.startsWith('/broadcastsms ') || text.startsWith('/broadcastwa ')) {
       const type = text.startsWith('/broadcastmail ') ? 'email' : text.startsWith('/broadcastsms ') ? 'sms' : 'whatsapp';
       const prefixLength = text.indexOf(' ') + 1;
       const messageBody = text.substring(prefixLength);
       
       const { data: students } = await supabase.from('profiles').select('id, full_name').eq('role', 'student').eq('mentor_id', session.user_id);
       
       if (!students || students.length === 0) {
          await sendMessage(chatId, 'No students found in your cohort.');
          return;
       }
       
       const dateString = new Date().toISOString().split('T')[0];
       for (const student of students) {
          await supabase.from('interventions').insert({
             student_id: student.id,
             mentor_id: session.user_id,
             type: 'Message',
             notes: `AI Composed [${type}]:\n${messageBody}`,
             date: dateString
          });
       }
       await sendMessage(chatId, `✅ Successfully dispatched ${type.toUpperCase()} broadcast to ${students.length} students (logged as interventions).`);
    }
    else if (text === '/students') {
       const { data: students } = await supabase.from('profiles').select('id, full_name, branch, semester').eq('role', 'student').eq('mentor_id', session.user_id);
       if (!students || students.length === 0) {
          await sendMessage(chatId, 'No students found in your cohort.');
       } else {
          let msg = `<b>Your Cohort (${students.length} students):</b>\n\n`;
          students.forEach(s => msg += `• ${s.full_name} (${s.branch} S${s.semester})\n`);
          await sendMessage(chatId, msg);
       }
    }
    else if (text.startsWith('/student ')) {
       const query = text.substring('/student '.length).toLowerCase();
       const { data: students } = await supabase.from('profiles').select('id, full_name, branch, semester').eq('role', 'student').eq('mentor_id', session.user_id);
       const match = students?.find(s => s.full_name.toLowerCase().includes(query));
       if (match) {
          await sendMessage(chatId, `<b>Student Profile:</b>\nName: ${match.full_name}\nBranch: ${match.branch}\nSemester: ${match.semester}\n\nUse /gencode ${query} to generate parent access.`);
       } else {
          await sendMessage(chatId, `No student found matching "${query}".`);
       }
    }
    else if (text.startsWith('/gencode ')) {
       const query = text.substring('/gencode '.length).toLowerCase();
       const { data: students } = await supabase.from('profiles').select('id, full_name').eq('role', 'student').eq('mentor_id', session.user_id);
       const match = students?.find(s => s.full_name.toLowerCase().includes(query));
       if (match) {
          const { data: code } = await supabase.rpc('generate_parent_code', { p_student_id: match.id, p_mentor_id: session.user_id });
          await sendMessage(chatId, `✅ <b>Parent Code Generated for ${match.full_name}:</b>\n\n<code>${code}</code>\n\nParents can send "/start ${code}" to this bot to link their account.`);
       } else {
          await sendMessage(chatId, `No student found matching "${query}".`);
       }
    }
    else if (text === '/report') {
       const { data: report } = await supabase.rpc('get_mentor_cohort_summary', { p_mentor_id: session.user_id });
       if (!report || report.length === 0) {
          await sendMessage(chatId, 'No data for cohort report.');
       } else {
          let msg = '<b>Cohort Risk Report:</b>\n\n';
          report.forEach((r: any) => {
             const icon = r.risk_level === 'High' ? '🔴' : r.risk_level === 'Medium' ? '🟡' : '🟢';
             msg += `${icon} <b>${r.full_name}</b>: Att ${r.avg_attendance}%, Fails: ${r.failing_subjects}\n`;
          });
          await sendMessage(chatId, msg);
       }
    }
    else if (text === '/attendance' || text === '/grades' || text === '/marks') {
       await sendMessage(chatId, `To view stats for the whole cohort, use /report.\nTo view individual stats, log in as a student.`);
    }
    else if (text === '/help') {
      await sendMessage(chatId, '<b>Available Mentor Commands:</b>\n/students - List all students\n/student [name] - View student\n/gencode [name] - Generate parent code\n/report - Cohort risk report\n/broadcast [message] - Message parents via Telegram\n/broadcastmail [message] - Email broadcast\n/broadcastsms [message] - SMS broadcast\n/broadcastwa [message] - WhatsApp broadcast\n/logout - Disconnect');
    }
    else {
      await sendMessage(chatId, 'Unknown command. Send /help for options.');
    }
  }
}

async function handleMessage(chatId: number, text: string) {
  // Check if session exists
  const { data: session } = await supabase.from('telegram_sessions').select('*').eq('telegram_chat_id', chatId).single();

  if (!session) {
    if (text.startsWith('/start ')) {
      // Potentially a parent code
      const code = text.split(' ')[1].trim().toUpperCase();
      const { data: codeData } = await supabase.from('parent_access_codes').select('*').eq('code', code).eq('used', false).single();
      
      if (codeData) {
         // Link parent
         await supabase.from('parent_access_codes').update({ used: true, used_by_chat_id: chatId }).eq('id', codeData.id);
         await supabase.from('telegram_sessions').insert({
            telegram_chat_id: chatId,
            role: 'parent',
            linked_student_id: codeData.student_id,
            state: 'logged_in'
         });
         
         const { data: student } = await supabase.from('profiles').select('full_name').eq('id', codeData.student_id).single();
         await sendMessage(chatId, `✅ Successfully linked to student <b>${student?.full_name || 'Unknown'}</b> as a Parent.\n\nSend /help to see commands.`);
         return;
      } else {
         await sendMessage(chatId, 'Invalid or expired parent access code. Try sending /start to login manually.');
         return;
      }
    }

    if (text === '/start') {
      await supabase.from('telegram_sessions').insert({ telegram_chat_id: chatId, state: 'awaiting_email' });
      await sendMessage(chatId, 'Welcome to EduPredict! 🎓\n\nPlease reply with your <b>Email Address</b> to login.');
      return;
    }

    await sendMessage(chatId, 'Send /start to begin.');
    return;
  }

  // Handle state machine for manual login
  if (session.state === 'awaiting_email') {
    if (text === '/start') {
       await sendMessage(chatId, 'Please reply with your <b>Email Address</b>.');
       return;
    }
    // Simple email validation
    if (!text.includes('@')) {
       await sendMessage(chatId, 'Invalid email. Please send a valid email.');
       return;
    }
    
    // Store email temporarily in a state metadata or just prompt for password
    // Actually, we need to pass email to signIn. Let's store it in a temporary column or state string
    await supabase.from('telegram_sessions').update({ state: `awaiting_password:${text}` }).eq('id', session.id);
    await sendMessage(chatId, 'Please reply with your <b>Password</b>.');
    return;
  }
  
  if (session.state.startsWith('awaiting_password:')) {
    const email = session.state.split(':')[1];
    const password = text;
    
    // Attempt sign in via supabase auth
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({ email, password });
    
    if (authErr || !authData.user) {
       await supabase.from('telegram_sessions').update({ state: 'awaiting_email' }).eq('id', session.id);
       await sendMessage(chatId, '❌ Login failed. Incorrect email or password.\n\nPlease reply with your <b>Email Address</b> to try again.');
       return;
    }
    
    // Get user profile
    const { data: profile } = await supabase.from('profiles').select('role').eq('id', authData.user.id).single();
    
    await supabase.from('telegram_sessions').update({ 
       user_id: authData.user.id,
       role: profile?.role || 'student',
       state: 'logged_in'
    }).eq('id', session.id);
    
    await sendMessage(chatId, `✅ Login successful! Welcome back. You are logged in as a <b>${(profile?.role || 'student').toUpperCase()}</b>.\n\nSend /help to see available commands.`);
    return;
  }
  
  if (session.state === 'logged_in') {
    await handleCommand(session, text, chatId);
    return;
  }
}

serve(async (req) => {
  if (req.method !== 'POST') return new Response('ok', { status: 200 });

  try {
    const update = await req.json();
    
    if (update.message && update.message.text) {
       const chatId = update.message.chat.id;
       const text = update.message.text.trim();
       await handleMessage(chatId, text);
    }
    
    // Handle external API call to send a message via /broadcast or direct route
    if (update.action === 'send_message') {
       const authHeader = req.headers.get('Authorization')
       if (!authHeader) return new Response('Unauthorized', { status: 401 })
       
       const { data: { user } } = await supabase.auth.getUser(authHeader.replace('Bearer ', ''))
       if (!user) return new Response('Unauthorized', { status: 401 })

       const { to_student_id, message_body } = update;
       // Find the parent's connected telegram session
       const { data: sessions } = await supabase.from('telegram_sessions')
          .select('telegram_chat_id')
          .eq('linked_student_id', to_student_id)
          .eq('role', 'parent');
          
       if (sessions && sessions.length > 0) {
          for (const s of sessions) {
             await sendMessage(s.telegram_chat_id, message_body);
          }
          return new Response(JSON.stringify({ ok: true, sent: true }), { status: 200 });
       } else {
          return new Response(JSON.stringify({ ok: true, sent: false, error: 'No parent connected to Telegram' }), { status: 200 });
       }
    }

    return new Response('ok', { status: 200 });
  } catch (error) {
    console.error('Webhook error:', error);
    return new Response('error', { status: 500 });
  }
});
