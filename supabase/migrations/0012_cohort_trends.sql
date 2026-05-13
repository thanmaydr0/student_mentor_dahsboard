-- Migration: Cohort trends function for leaderboard sparklines
-- Returns weekly attendance, IAT scores, and per-subject scores per student
-- SECURITY DEFINER so students can see each other's trend data on the leaderboard.

CREATE OR REPLACE FUNCTION get_cohort_trends(p_mentor_id UUID)
RETURNS TABLE (
  student_id UUID,
  attendance_weekly JSONB,
  iat_scores JSONB,
  subject_scores JSONB
) AS $$
  SELECT 
    p.id AS student_id,
    
    -- Weekly attendance for last 5 weeks
    COALESCE((
      SELECT jsonb_agg(row_to_json(w) ORDER BY w.week_start)
      FROM (
        SELECT 
          date_trunc('week', a.date)::date AS week_start,
          ROUND(COUNT(*) FILTER (WHERE a.status = 'Present')::numeric / NULLIF(COUNT(*), 0) * 100, 1) AS pct
        FROM attendance a
        WHERE a.student_id = p.id AND a.date >= CURRENT_DATE - INTERVAL '35 days'
        GROUP BY date_trunc('week', a.date)
      ) w
    ), '[]'::jsonb) AS attendance_weekly,
    
    -- IAT scores grouped by iat_number (avg across all subjects)
    COALESCE((
      SELECT jsonb_agg(row_to_json(i) ORDER BY i.iat_num)
      FROM (
        SELECT 
          im.iat_number AS iat_num,
          ROUND(AVG(im.marks_obtained), 1) AS avg_marks,
          im.max_marks
        FROM iat_marks im
        WHERE im.student_id = p.id
        GROUP BY im.iat_number, im.max_marks
      ) i
    ), '[]'::jsonb) AS iat_scores,
    
    -- Subject-wise total scores (used as CGPA proxy)
    COALESCE((
      SELECT jsonb_agg(row_to_json(ss) ORDER BY ss.name)
      FROM (
        SELECT s.name, g.total_score AS score
        FROM grades g
        JOIN classes c ON c.id = g.class_id
        JOIN subjects s ON s.id = c.subject_id
        WHERE g.student_id = p.id
      ) ss
    ), '[]'::jsonb) AS subject_scores
    
  FROM profiles p
  WHERE p.mentor_id = p_mentor_id AND p.role = 'student';
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Grant to authenticated users
GRANT EXECUTE ON FUNCTION get_cohort_trends(UUID) TO authenticated;
