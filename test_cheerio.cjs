const fs = require('fs');
const cheerio = require('cheerio');

const html = fs.readFileSync('attendance_out.html', 'utf8');
const $ = cheerio.load(html);

const results = [];
// find tables with attendance
$('table').each((i, table) => {
  $(table).find('tr').each((j, row) => {
    const text = $(row).text().replace(/\s+/g, ' ').trim();
    if (text.includes('Database Management') || text.includes('Analysis') || text.includes('Intelligence') || text.includes('Discrete')) {
      results.push(text);
    }
  });
});

console.log(results.join('\n'));
