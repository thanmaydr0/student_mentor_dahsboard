-- Run this in your Supabase SQL Editor
-- This allows Mentors to see the profiles of the parents of their assigned students

-- 1. Helper function to avoid recursion
CREATE OR REPLACE FUNCTION get_mentor_parent_ids(p_mentor_id UUID)
RETURNS SETOF UUID AS $$
  SELECT parent_id FROM parent_student_links WHERE student_id IN (
    SELECT id FROM profiles WHERE mentor_id = p_mentor_id
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION get_mentor_parent_ids(UUID) TO authenticated;

-- 2. Policy for mentor to read parent profiles
DROP POLICY IF EXISTS "mentors_select_assigned_parents" ON profiles;
CREATE POLICY "mentors_select_assigned_parents" ON profiles
FOR SELECT USING (
  public.user_role() = 'mentor' AND
  id IN (SELECT get_mentor_parent_ids(auth.uid()))
);
