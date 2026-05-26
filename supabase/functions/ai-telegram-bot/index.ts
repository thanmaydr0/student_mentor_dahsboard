import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.3";

const AI_TELEGRAM_BOT_TOKEN = Deno.env.get('AI_TELEGRAM_BOT_TOKEN') || '';
const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || '';
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';
const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') || '';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
const TELEGRAM_API = `https://api.telegram.org/bot${AI_TELEGRAM_BOT_TOKEN}`;

// --- Telegram Utilities ---

async function sendMessage(chatId: number, text: string) {
  try {
    await fetch(`${TELEGRAM_API}/sendMessage`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ chat_id: chatId, text, parse_mode: 'HTML' })
    });
  } catch (e) {
    console.error('[Telegram Send Error]', e);
  }
}

async function sendTypingAction(chatId: number) {
  try {
    await fetch(`${TELEGRAM_API}/sendChatAction`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ chat_id: chatId, action: 'typing' })
    });
  } catch (e) {
    // Ignore minor errors here
  }
}

// --- OpenAI API Client ---

async function callOpenAI(messages: any[], tools: any[]) {
  const res = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model: 'gpt-4o-mini',
      messages,
      tools,
      tool_choice: 'auto',
      temperature: 0.3
    })
  });
  
  if (!res.ok) {
    const err = await res.text();
    console.error('OpenAI Error:', err);
    throw new Error('OpenAI API Error');
  }
  
  return await res.json();
}

// --- Tool Definitions ---

const TOOLS = [
  {
    type: "function",
    function: {
      name: "search_student",
      description: "Mentors ONLY. Search for a student by name to find their exact student_id. Always use this first if you only know their name and need their ID for other functions.",
      parameters: {
        type: "object",
        properties: {
          name_query: { type: "string", description: "The name of the student to search for" }
        },
        required: ["name_query"]
      }
    }
  },
  {
    type: "function",
    function: {
      name: "get_attendance",
      description: "Get the attendance summary for a student. Returns present count, total count, and percentage per subject.",
      parameters: {
        type: "object",
        properties: {
          student_id: { type: "string", description: "Optional UUID of the student (only mentors need to provide this, students fetch their own automatically)" }
        }
      }
    }
  },
  {
    type: "function",
    function: {
      name: "get_grades",
      description: "Get the final semester grades and scores for a student.",
      parameters: {
        type: "object",
        properties: {
          student_id: { type: "string", description: "Optional UUID of the student" }
        }
      }
    }
  },
  {
    type: "function",
    function: {
      name: "get_iat_marks",
      description: "Get the Internal Assessment Test (IAT) and Lab marks for a student.",
      parameters: {
        type: "object",
        properties: {
          student_id: { type: "string", description: "Optional UUID of the student" }
        }
      }
    }
  },
  {
    type: "function",
    function: {
      name: "get_fee_status",
      description: "Check if the student has paid their fees (revaluation or exam registration) via Razorpay.",
      parameters: {
        type: "object",
        properties: {
          student_id: { type: "string", description: "Optional UUID of the student" }
        }
      }
    }
  },
  {
    type: "function",
    function: {
      name: "get_cohort_report",
      description: "Mentors ONLY. Get a summary report of all students in the mentor's cohort, showing their risk level, average attendance, and failing subjects.",
      parameters: { type: "object", properties: {} }
    }
  },
  {
    type: "function",
    function: {
      name: "list_my_students",
      description: "Mentors ONLY. Get a basic list of all students assigned to this mentor.",
      parameters: { type: "object", properties: {} }
    }
  },
  {
    type: "function",
    function: {
      name: "generate_parent_code",
      description: "Mentors ONLY. Generate a secure invite code for a parent to link their Telegram account to a specific student.",
      parameters: {
        type: "object",
        properties: {
          student_id: { type: "string", description: "UUID of the student" }
        },
        required: ["student_id"]
      }
    }
  }
];

// --- Tool Execution Engine ---

async function executeTool(name: string, args: any, session: any) {
  const role = session.role;
  // Determine default target ID based on role
  let targetId = role === 'parent' ? session.linked_student_id : session.user_id;

  // If mentor provided a student_id, use it. If mentor did NOT, they must.
  if (role === 'mentor') {
    if (args.student_id) {
      targetId = args.student_id;
    } else if (name === 'get_attendance' || name === 'get_grades' || name === 'get_iat_marks' || name === 'get_fee_status') {
      return JSON.stringify({ error: `Mentors MUST provide a valid 'student_id' parameter for this tool. Please use search_student first if you only know their name.` });
    }
  }

  try {
    switch (name) {
      case 'search_student': {
        if (role !== 'mentor') return JSON.stringify({ error: 'Only mentors can search students.' });
        const { data } = await supabase.from('profiles')
          .select('id, full_name, branch, semester')
          .eq('role', 'student')
          .eq('mentor_id', session.user_id)
          .ilike('full_name', `%${args.name_query}%`);
        return JSON.stringify(data || []);
      }
      
      case 'get_attendance': {
        const { data } = await supabase.rpc('get_attendance_summary', { p_student_id: targetId });
        return JSON.stringify(data || []);
      }
      
      case 'get_grades': {
        const { data } = await supabase.from('grades').select('*, classes(subjects(name, code))').eq('student_id', targetId);
        return JSON.stringify(data || []);
      }
      
      case 'get_iat_marks': {
        const { data } = await supabase.from('iat_marks').select('*, classes(subjects(name, code))').eq('student_id', targetId);
        return JSON.stringify(data || []);
      }
      
      case 'get_fee_status': {
        const { data } = await supabase.from('fee_payments').select('id, payment_type, amount, status, subjects, created_at, razorpay_payment_id').eq('student_id', targetId).order('created_at', { ascending: false });
        return JSON.stringify(data || []);
      }
      
      case 'get_cohort_report': {
        if (role !== 'mentor') return JSON.stringify({ error: 'Only mentors can view cohort reports.' });
        const { data } = await supabase.rpc('get_mentor_cohort_summary', { p_mentor_id: session.user_id });
        return JSON.stringify(data || []);
      }
      
      case 'list_my_students': {
        if (role !== 'mentor') return JSON.stringify({ error: 'Only mentors can list their students.' });
        const { data } = await supabase.from('profiles').select('id, full_name, branch, semester').eq('role', 'student').eq('mentor_id', session.user_id);
        return JSON.stringify(data || []);
      }
      
      case 'generate_parent_code': {
        if (role !== 'mentor') return JSON.stringify({ error: 'Only mentors can generate parent codes.' });
        const { data } = await supabase.rpc('generate_parent_code', { p_student_id: args.student_id, p_mentor_id: session.user_id });
        return JSON.stringify({ success: true, code: data, message: "Give this code to the parent." });
      }
      
      default:
        return JSON.stringify({ error: `Unknown tool: ${name}` });
    }
  } catch (err: any) {
    console.error(`Error executing ${name}:`, err);
    return JSON.stringify({ error: `Database error: ${err.message}` });
  }
}

// --- History Persistence Utilities ---

async function saveMessageToHistory(sessionId: string, msg: any) {
  try {
    await supabase.from('ai_chat_history').insert({
      session_id: sessionId,
      role: msg.role,
      content: msg.content || null,
      tool_calls: msg.tool_calls || null,
      tool_call_id: msg.tool_call_id || null,
      name: msg.name || null
    });
  } catch (err) {
    console.error('Failed to save message to history:', err);
  }
}

async function getChatHistory(sessionId: string) {
  // Fetch last 15 messages for context window
  const { data } = await supabase.from('ai_chat_history')
    .select('role, content, tool_calls, tool_call_id, name')
    .eq('session_id', sessionId)
    .order('created_at', { ascending: false })
    .limit(15);
    
  if (!data) return [];
  
  // Reverse to chronological order
  const history = data.reverse().map(row => {
    const msg: any = { role: row.role };
    if (row.content) msg.content = row.content;
    if (row.tool_calls) msg.tool_calls = row.tool_calls;
    if (row.tool_call_id) msg.tool_call_id = row.tool_call_id;
    if (row.name) msg.name = row.name;
    return msg;
  });
  
  return history;
}

// --- Main Agent Loop ---

async function handleAIChat(session: any, text: string, chatId: number) {
  await sendTypingAction(chatId);
  
  const { data: profile } = await supabase.from('profiles').select('full_name').eq('id', session.user_id).single();
  const userName = profile?.full_name || 'User';
  
  // 1. Build System Context
  const systemPrompt = `You are EduPredict AI, a highly advanced, intelligent academic assistant.
You are talking to ${userName}. Their role is '${session.role}'.
Guidelines:
1. Use your tools to fetch real-time data from the ERP database.
2. If you are a mentor and the user asks about a student by name, ALWAYS use 'search_student' first to get their UUID. Never guess IDs.
3. Once you have the student_id from 'search_student', immediately use the appropriate tool (e.g. get_attendance or get_grades) in a multi-turn chain to fulfill their request.
4. Format your final response beautifully using Telegram HTML tags (<b>, <i>, <code>). Never expose raw JSON.
5. If a tool returns an error, explain it gracefully to the user.`;

  // 2. Load History
  const history = await getChatHistory(session.id);
  
  // 3. Prepare messages array
  const messages = [
    { role: 'system', content: systemPrompt },
    ...history,
    { role: 'user', content: text }
  ];
  
  // Save user's new message to DB
  await saveMessageToHistory(session.id, { role: 'user', content: text });

  try {
    let currentMessages = [...messages];
    let isProcessing = true;
    let iterationCount = 0; // Failsafe to prevent infinite loops
    let finalOutput = '';

    while (isProcessing && iterationCount < 5) {
      iterationCount++;
      await sendTypingAction(chatId);
      
      const response = await callOpenAI(currentMessages, TOOLS);
      const assistantMessage = response.choices[0].message;
      
      // Save assistant message (which might contain tool_calls or text)
      await saveMessageToHistory(session.id, assistantMessage);
      currentMessages.push(assistantMessage);

      if (assistantMessage.tool_calls) {
        // AI decided to call a tool
        for (const toolCall of assistantMessage.tool_calls) {
          if (toolCall.type === 'function') {
            const fnName = toolCall.function.name;
            const args = JSON.parse(toolCall.function.arguments || '{}');
            
            console.log(`[Tool Call] ${fnName}(`, args, `)`);
            const result = await executeTool(fnName, args, session);
            
            const toolMessage = {
              role: 'tool',
              tool_call_id: toolCall.id,
              name: fnName,
              content: result
            };
            
            await saveMessageToHistory(session.id, toolMessage);
            currentMessages.push(toolMessage);
          }
        }
        // Loop continues, sending the tool results back to OpenAI
      } else {
        // AI generated a final text response
        finalOutput = assistantMessage.content;
        isProcessing = false;
      }
    }

    if (finalOutput) {
      await sendMessage(chatId, finalOutput);
    } else {
       await sendMessage(chatId, "I processed your request but couldn't generate a final response. Please try again.");
    }

  } catch (error: any) {
    console.error('Agent Loop Error:', error);
    await sendMessage(chatId, "⚠️ Sorry, I encountered a technical issue while thinking. Please try again.");
  }
}

// --- Webhook Entry & Manual Login ---

async function handleMessage(chatId: number, text: string) {
  const { data: session } = await supabase.from('telegram_sessions').select('*').eq('telegram_chat_id', chatId).single();

  if (!session) {
    if (text === '/start') {
      await supabase.from('telegram_sessions').insert({ telegram_chat_id: chatId, state: 'awaiting_email' });
      await sendMessage(chatId, 'Welcome to EduPredict AI! 🤖✨\n\nI am your advanced academic assistant. Please reply with your <b>Email Address</b> to login.');
      return;
    }
    await sendMessage(chatId, 'Send /start to begin.');
    return;
  }

  // Handle manual login state machine
  if (session.state === 'awaiting_email') {
    if (text === '/start') {
       await sendMessage(chatId, 'Please reply with your <b>Email Address</b>.');
       return;
    }
    if (!text.includes('@')) {
       await sendMessage(chatId, 'Invalid email. Please send a valid email.');
       return;
    }
    await supabase.from('telegram_sessions').update({ state: `awaiting_password:${text}` }).eq('id', session.id);
    await sendMessage(chatId, 'Please reply with your <b>Password</b>.');
    return;
  }
  
  if (session.state.startsWith('awaiting_password:')) {
    const email = session.state.split(':')[1];
    const password = text;
    
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({ email, password });
    
    if (authErr || !authData.user) {
       await supabase.from('telegram_sessions').update({ state: 'awaiting_email' }).eq('id', session.id);
       await sendMessage(chatId, '❌ Login failed. Incorrect email or password.\n\nPlease reply with your <b>Email Address</b> to try again.');
       return;
    }
    
    const { data: profile } = await supabase.from('profiles').select('role').eq('id', authData.user.id).single();
    
    await supabase.from('telegram_sessions').update({ 
       user_id: authData.user.id,
       role: profile?.role || 'student',
       state: 'logged_in'
    }).eq('id', session.id);
    
    await sendMessage(chatId, `✅ Login successful! You are logged in as a <b>${(profile?.role || 'student').toUpperCase()}</b>.\n\nI am fully connected to your ERP. Just ask me what you want to know!`);
    return;
  }
  
  if (session.state === 'logged_in') {
    if (text === '/logout') {
      await supabase.from('telegram_sessions').delete().eq('telegram_chat_id', chatId);
      // Clear history when they logout
      await supabase.from('ai_chat_history').delete().eq('session_id', session.id);
      await sendMessage(chatId, 'Logged out and memory cleared. Send /start to login again.');
      return;
    }
    // Hand over to advanced AI Agent Loop
    await handleAIChat(session, text, chatId);
    return;
  }
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return new Response('ok', { status: 200 });

  try {
    const update = await req.json();
    
    if (update.message && update.message.text) {
       const chatId = update.message.chat.id;
       const text = update.message.text.trim();
       await handleMessage(chatId, text);
    }

    return new Response('ok', { status: 200 });
  } catch (error) {
    console.error('Webhook error:', error);
    return new Response('error', { status: 500 });
  }
});
