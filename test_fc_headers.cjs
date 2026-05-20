

(async () => {
  const apiKey = process.env.FIRECRAWL_API_KEY;
  if (!apiKey) {
    console.error("No API key");
    return;
  }
  
  const res = await fetch('https://api.firecrawl.dev/v1/scrape', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      url: 'https://erp.cmrit.ac.in/studentCourses.htm?shwA=%2700A%27',
      formats: ['markdown'],
      headers: {
        'Cookie': 'JSESSIONID=E2FC3A0D0C997F204F9BD48AABB6C428'
      }
    })
  });
  
  const data = await res.json();
  if (data.success) {
    console.log("Success! Markdown length:", data.data.markdown.length);
    console.log("Contains attendance:", data.data.markdown.includes('Database Management'));
    console.log("Snippet:", data.data.markdown.substring(0, 500));
  } else {
    console.log("Failed:", data);
  }
})();
