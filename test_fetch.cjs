

(async () => {
  const params = new URLSearchParams();
  params.append('j_username', 'amogh.cseaiml24@cmrit.ac.in');
  params.append('j_password', '123456');
  
  const loginRes = await fetch('https://erp.cmrit.ac.in/j_spring_security_check', {
    method: 'POST',
    body: params,
    redirect: 'manual'
  });
  
  console.log("Status:", loginRes.status);
  const cookieHeader = loginRes.headers.get('set-cookie');
  console.log("Cookies:", cookieHeader);
  
  let jsessionid = '';
  if (cookieHeader) {
    const match = cookieHeader.match(/JSESSIONID=([^;]+)/);
    if (match) {
      jsessionid = match[0];
    }
  }
  
  console.log("Extracted JSESSIONID:", jsessionid);
})();
