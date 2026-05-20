import puppeteer from 'puppeteer';

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  // Navigate directly to the attendance URL (which will redirect to login)
  await page.goto('https://erp.cmrit.ac.in/studentCourses.htm?shwA=%2700A%27', { waitUntil: 'networkidle2' });
  
  console.log("Current URL after initial goto:", page.url());
  
  await page.type('input[name="j_username"]', 'amogh.cseaiml24@cmrit.ac.in');
  await page.type('input[name="j_password"]', '123456');
  
  await Promise.all([
    page.waitForNavigation({ waitUntil: 'networkidle2' }),
    page.click('button[type="submit"]')
  ]);
  
  console.log("After login URL:", page.url());
  
  await browser.close();
})();
