import { boss } from '../queue';
import { supabaseAdmin } from '../../index';
import fetch from 'node-fetch'; // assuming node-fetch is available in Node 18+ natively as fetch, but explicitly importing or we can just use native fetch. 

export const registerAiBatchJobs = async () => {
  await boss.work('ai-message-batch', async (job) => {
    const { messages, channel, logAsIntervention, mentorId } = job.data as any;
    console.log(`Processing ai-message-batch for ${messages.length} messages...`);

    // In a real scenario, this would call the OpenAI proxy safely for each message
    // and space them out to respect rate limits
    const results = [];

    for (const msg of messages) {
       // Simulate processing delay
       await new Promise(r => setTimeout(r, 1000));
       results.push({ student_id: msg.student_id, success: true });
    }

    if (logAsIntervention) {
       const insertPayload = messages.map((m: any) => ({
          student_id: m.student_id, 
          mentor_id: mentorId, 
          type: 'Message', 
          notes: `AI Composed [${channel}]:\n${m.body}`, 
          date: new Date().toISOString().split('T')[0]
       }));
       await supabaseAdmin.from('interventions').insert(insertPayload);
    }

    console.log('Finished ai-message-batch.');
    return { processed: results.length };
  });
};
