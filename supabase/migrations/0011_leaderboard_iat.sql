-- Migration: Leaderboard IAT averages function
-- Returns average IAT marks per student for a mentor's cohort.
-- SECURITY DEFINER so students can see each other's aggregated IAT data on the leaderboard.

CREATE OR REPLACE FUNCTION get_cohort_iat_averages(p_mentor_id UUID)
RETURNS TABLE (
  student_id UUID,
  avg_iat_marks NUMERIC,
  iat_count BIGINT
) AS $$
  SELECT
    im.student_id,
    ROUND(AVG(im.marks_obtained), 2) AS avg_iat_marks,
    COUNT(im.id) AS iat_count
  FROM iat_marks im
  INNER JOIN profiles p ON p.id = im.student_id
  WHERE p.mentor_id = p_mentor_id AND p.role = 'student'
  GROUP BY im.student_id;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Grant to authenticated users
GRANT EXECUTE ON FUNCTION get_cohort_iat_averages(UUID) TO authenticated;
