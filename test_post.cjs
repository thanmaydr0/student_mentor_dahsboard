const https = require('https');

const data = new URLSearchParams({
  j_username: 'amogh.cseaiml24@cmrit.ac.in',
  j_password: '123456'
}).toString();

const options = {
  hostname: 'erp.cmrit.ac.in',
  port: 443,
  path: '/j_spring_security_check', // the form action URL from the JS is usually /login or /j_spring_security_check
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Content-Length': data.length
  }
};

const req = https.request(options, res => {
  console.log(`statusCode: ${res.statusCode}`);
  console.log('headers:', res.headers);
  
  res.on('data', d => {
    // process.stdout.write(d);
  });
});

req.on('error', error => {
  console.error(error);
});

req.write(data);
req.end();
