-- Run this in your Supabase SQL Editor
-- This fixes the infinite recursion caused by circular dependencies 
-- between the parent_student_links and profiles RLS policies.

-- 1. Create a SECURITY DEFINER helper function to read links (bypasses RLS)
CREATE OR REPLACE FUNCTION get_parent_student_ids(p_parent_id UUID)
RETURNS SETOF UUID AS $$
  SELECT student_id FROM parent_student_links WHERE parent_id = p_parent_id;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION get_parent_student_ids(UUID) TO authenticated;

-- 2. Drop the old recursive policies
DROP POLICY IF EXISTS "parents_select_linked_students" ON profiles;
DROP POLICY IF EXISTS "parents_select_linked_students_attendance" ON attendance;
DROP POLICY IF EXISTS "parents_select_linked_students_grades" ON grades;
DROP POLICY IF EXISTS "parents_select_linked_students_classes" ON classes;
DROP POLICY IF EXISTS "parents_select_linked_students_enrollments" ON enrollments;

-- 3. Recreate the policies using the helper function
CREATE POLICY "parents_select_linked_students" ON profiles
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  id IN (SELECT get_parent_student_ids(auth.uid()))
);

CREATE POLICY "parents_select_linked_students_attendance" ON attendance
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT get_parent_student_ids(auth.uid()))
);

CREATE POLICY "parents_select_linked_students_grades" ON grades
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT get_parent_student_ids(auth.uid()))
);

CREATE POLICY "parents_select_linked_students_classes" ON classes
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  id IN (
    SELECT class_id FROM enrollments WHERE student_id IN (
      SELECT get_parent_student_ids(auth.uid())
    )
  )
);

CREATE POLICY "parents_select_linked_students_enrollments" ON enrollments
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT get_parent_student_ids(auth.uid()))
);
