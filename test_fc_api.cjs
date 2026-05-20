

(async () => {
  const params = new URLSearchParams();
  params.append('j_username', 'amogh.cseaiml24@cmrit.ac.in');
  params.append('j_password', '123456');
  
  const loginRes = await fetch('https://erp.cmrit.ac.in/j_spring_security_check', {
    method: 'POST',
    body: params,
    redirect: 'manual'
  });
  
  const cookieHeader = loginRes.headers.get('set-cookie') || '';
  const match = cookieHeader.match(/JSESSIONID=([^;]+)/);
  if (!match) return console.log("No cookie");
  
  const res = await fetch('https://api.firecrawl.dev/v1/scrape', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${process.env.FIRECRAWL_API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      url: 'https://erp.cmrit.ac.in/studentCourses.htm?shwA=%2700A%27',
      formats: ['markdown'],
      headers: {
        'Cookie': match[0]
      }
    })
  });
  
  const data = await res.json();
  if (data.success) {
    require('fs').writeFileSync('fc_dump.md', data.data.markdown);
    console.log("Dumped to fc_dump.md");
  } else {
    console.log("Failed:", data);
  }
})();
