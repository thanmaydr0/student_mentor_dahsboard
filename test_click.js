import puppeteer from 'puppeteer';
import * as fs from 'fs';

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  await page.goto('https://erp.cmrit.ac.in/', { waitUntil: 'networkidle2' });
  
  await page.type('input[name="j_username"]', 'amogh.cseaiml24@cmrit.ac.in');
  await page.type('input[name="j_password"]', '123456');
  
  await Promise.all([
    page.waitForNavigation({ waitUntil: 'networkidle2' }),
    page.click('button[type="submit"]')
  ]);
  
  console.log("After login URL:", page.url());
  
  // Click the attendance card
  await Promise.all([
    page.waitForNavigation({ waitUntil: 'networkidle2', timeout: 10000 }).catch(e => console.log("Navigation timeout")),
    page.click('#stud2')
  ]);
  
  console.log("After clicking stud2 URL:", page.url());
  
  const html = await page.content();
  fs.writeFileSync('attendance_out.html', html);
  console.log('HTML saved to attendance_out.html');
  
  await browser.close();
})();
