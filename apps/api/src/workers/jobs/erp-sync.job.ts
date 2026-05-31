import { boss } from '../queue';
import { supabaseAdmin } from '../../index';

export const registerErpSyncJobs = async () => {
  await boss.work('erp-sync-trigger', async (job) => {
    const { studentId, syncType } = job.data as any;
    console.log(`Processing ERP Sync for student ${studentId}, type: ${syncType}...`);

    // In a real scenario, this would spin up Puppeteer or call an internal scraper API
    // without worrying about a 5 second HTTP timeout.
    
    await new Promise(r => setTimeout(r, 5000)); // Simulate slow scrape

    console.log(`Finished ERP Sync for ${studentId}.`);
    return { status: 'success' };
  });
};
