import puppeteer from 'puppeteer';
import { spawn } from 'child_process';

async function run() {
  const server = spawn('npm', ['run', 'preview', '--', '--port', '3000'], { shell: true });
  
  await new Promise(resolve => setTimeout(resolve, 2000));
  console.log('Server started');
  
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  page.on('console', msg => console.log('PAGE LOG:', msg.text()));
  page.on('pageerror', error => console.log('PAGE ERROR:', error.message, '\n', error.stack));
  
  await page.goto('http://localhost:3000/auth/login');
  
  await new Promise(resolve => setTimeout(resolve, 2000));
  
  await browser.close();
  server.kill();
  process.exit(0);
}

run();
