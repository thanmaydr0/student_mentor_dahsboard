-- =============================================================================
-- 1. Create Academic Deadlines Table
-- =============================================================================
CREATE TABLE IF NOT EXISTS academic_deadlines (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  date DATE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('fee', 'exam', 'scholarship', 'other')),
  status TEXT NOT NULL CHECK (status IN ('urgent', 'upcoming')),
  amount TEXT,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================================================
-- 2. Create Career Metrics Table
-- =============================================================================
CREATE TABLE IF NOT EXISTS career_metrics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  problem_solving INTEGER NOT NULL DEFAULT 0 CHECK (problem_solving BETWEEN 0 AND 100),
  communication INTEGER NOT NULL DEFAULT 0 CHECK (communication BETWEEN 0 AND 100),
  technical_skills INTEGER NOT NULL DEFAULT 0 CHECK (technical_skills BETWEEN 0 AND 100),
  teamwork INTEGER NOT NULL DEFAULT 0 CHECK (teamwork BETWEEN 0 AND 100),
  leadership INTEGER NOT NULL DEFAULT 0 CHECK (leadership BETWEEN 0 AND 100),
  adaptability INTEGER NOT NULL DEFAULT 0 CHECK (adaptability BETWEEN 0 AND 100),
  recent_milestones JSONB DEFAULT '[]'::jsonb, -- Array of objects: { title, date, score, type }
  primary_strength TEXT,
  growth_area TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id)
);

-- =============================================================================
-- 3. Enable RLS and Add Policies
-- =============================================================================
ALTER TABLE academic_deadlines ENABLE ROW LEVEL SECURITY;
ALTER TABLE career_metrics ENABLE ROW LEVEL SECURITY;

-- Deadlines are globally readable by all authenticated users
DROP POLICY IF EXISTS "Enable read access for all authenticated users" ON academic_deadlines;
CREATE POLICY "Enable read access for all authenticated users" ON academic_deadlines
  FOR SELECT TO authenticated USING (true);

-- Career Metrics: Student can read their own. Mentors can read their mentees. Parents can read their children.
DROP POLICY IF EXISTS "Users can read career metrics" ON career_metrics;
CREATE POLICY "Users can read career metrics" ON career_metrics
  FOR SELECT TO authenticated USING (
    auth.uid() = student_id OR 
    auth.uid() IN (SELECT mentor_id FROM profiles WHERE id = student_id) OR
    auth.uid() IN (SELECT parent_id FROM parent_student_links WHERE parent_student_links.student_id = career_metrics.student_id)
  );

-- =============================================================================
-- 4. RPC for Historical Semester CGPA (Academic GPS)
-- =============================================================================
CREATE OR REPLACE FUNCTION get_historical_cgpa(p_student_id UUID)
RETURNS TABLE (
  semester SMALLINT,
  cgpa NUMERIC
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.semester,
    ROUND(AVG(
      CASE
        WHEN (g.internal_marks + g.external_marks) >= 85 THEN 10.0
        WHEN (g.internal_marks + g.external_marks) >= 70 THEN 8.0
        WHEN (g.internal_marks + g.external_marks) >= 55 THEN 6.0
        WHEN (g.internal_marks + g.external_marks) >= 40 THEN 4.0
        ELSE 0.0
      END
    ), 2) AS cgpa
  FROM grades g
  JOIN classes c ON g.class_id = c.id
  WHERE g.student_id = p_student_id
  GROUP BY c.semester
  ORDER BY c.semester ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================================================
-- 5. Seed Initial Data
-- =============================================================================
-- Insert standard deadlines
INSERT INTO academic_deadlines (title, date, type, status, amount, description) VALUES
('Even Semester Tuition Fee', CURRENT_DATE + INTERVAL '15 days', 'fee', 'urgent', '₹85,000', 'Final deadline to clear all tuition dues for the upcoming semester to avoid late penalties.'),
('VTU Exam Registration Form', CURRENT_DATE + INTERVAL '28 days', 'exam', 'upcoming', NULL, 'Student must submit the official exam form through the VTU web portal.'),
('State Scholarship Application', CURRENT_DATE + INTERVAL '40 days', 'scholarship', 'upcoming', NULL, 'Portal opens for the Vidyasiri State Scholarship scheme. Requires income certificate.')
ON CONFLICT DO NOTHING;

-- Seed dummy career metrics for existing students
INSERT INTO career_metrics (student_id, problem_solving, communication, technical_skills, teamwork, leadership, adaptability, primary_strength, growth_area, recent_milestones)
SELECT 
  id, 
  85, 65, 90, 75, 60, 80, 
  'Technical Skills', 
  'Communication',
  '[
    {"title": "Resume ATS Score Improved", "date": "2 days ago", "score": "82%", "type": "success"},
    {"title": "Completed AWS Certification", "date": "1 week ago", "score": null, "type": "achievement"},
    {"title": "Applied to Google SWE Intern", "date": "2 weeks ago", "score": null, "type": "action"}
  ]'::jsonb
FROM profiles WHERE role = 'student'
ON CONFLICT (student_id) DO NOTHING;
