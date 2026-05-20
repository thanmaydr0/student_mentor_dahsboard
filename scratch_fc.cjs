const fs = require('fs');
const text = fs.readFileSync('C:/Users/thanm/.gemini/antigravity/brain/d7770a06-276b-43ae-8e94-173c35863d0d/.system_generated/steps/425/content.md', 'utf8');
const matches = text.match(/type:\s*['"][a-zA-Z]+['"]/g) || [];
console.log([...new Set(matches)]);
