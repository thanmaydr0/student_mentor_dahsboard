import puppeteer from 'puppeteer';
import * as fs from 'fs';

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  console.log("Visiting attendance URL...");
  await page.goto('https://erp.cmrit.ac.in/studentCourses.htm?shwA=%2700A%27', { waitUntil: 'networkidle2' });
  
  console.log("Current URL:", page.url());
  
  console.log("Typing credentials...");
  await page.type('input[name="j_username"]', 'amogh.cseaiml24@cmrit.ac.in');
  await page.type('input[name="j_password"]', '123456');
  
  console.log("Clicking submit...");
  await Promise.all([
    page.waitForNavigation({ waitUntil: 'networkidle2' }),
    page.click('button[type="submit"]')
  ]);
  
  console.log("After login URL:", page.url());
  
  const html = await page.content();
  fs.writeFileSync('home_out.html', html);
  console.log('HTML saved to home_out.html');
  
  await browser.close();
})();
