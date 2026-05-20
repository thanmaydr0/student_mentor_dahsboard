const fs = require('fs');

const markdown = fs.readFileSync('attendance_out.html', 'utf8');

const SUBJECT_PATTERNS = {
  'dbms': ['database management', 'dbms', 'bcs403', 'bcs304'],
  'ai': ['artificial intelligence', 'bai402'],
  'dms': ['discrete mathematical', 'dms', 'bcs405a'],
  'ada': ['analysis & design', 'algorithm design', 'ada', 'bcs401', 'bcsl404'],
}

const lines = markdown.split('\n');

const results = {};

for (const [patternKey, patterns] of Object.entries(SUBJECT_PATTERNS)) {
  let theoryHeld = 0, theoryAttended = 0, theoryPercentage = 0
  let labHeld = 0, labAttended = 0, labPercentage = 0

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].toLowerCase();
    
    const matchesSubject = patterns.some(p => line.includes(p))
    if (!matchesSubject) continue

    const attendanceMatch = line.match(/(\d+)\s*\/\s*(\d+)/)

    if (attendanceMatch) {
      const attended = parseInt(attendanceMatch[1], 10)
      const held = parseInt(attendanceMatch[2], 10)
      let percentage = 0
      if (held > 0) {
        percentage = parseFloat(((attended / held) * 100).toFixed(2))
      }

      const isLab = line.includes('lab') || line.includes('practical') || line.includes('laboratory') || line.match(/bcsl|bds/i)

      if (isLab) {
        labHeld = held
        labAttended = attended
        labPercentage = percentage
      } else {
        theoryHeld = held
        theoryAttended = attended
        theoryPercentage = percentage
      }
    }
  }
  
  results[patternKey] = {
    theoryHeld, theoryAttended, theoryPercentage,
    labHeld, labAttended, labPercentage
  };
}

console.log("Extraction Results:", JSON.stringify(results, null, 2));
