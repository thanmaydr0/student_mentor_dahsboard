import PgBoss from 'pg-boss';
import dotenv from 'dotenv';

dotenv.config();

const connectionString = process.env.DATABASE_URL || '';

export const boss = new PgBoss(connectionString);

boss.on('error', (error) => console.error('PgBoss Error:', error));

export const initQueue = async () => {
  if (!connectionString) {
    console.warn('DATABASE_URL not set, queue will not start.');
    return;
  }
  
  await boss.start();
  console.log('PgBoss queue started.');
};
