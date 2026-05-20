const fs = require('fs');
const text = fs.readFileSync('LoginActionCardComponent.js', 'utf8');

const nameMatches = text.match(/name:\s*['"](.*?)['"]/g) || [];
console.log('Names:', [...new Set(nameMatches)]);

const idMatches = text.match(/id:\s*['"](.*?)['"]/g) || [];
console.log('IDs:', [...new Set(idMatches)]);

const typeMatches = text.match(/type:\s*['"](.*?)['"]/g) || [];
console.log('Types:', [...new Set(typeMatches)]);
