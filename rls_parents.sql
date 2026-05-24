-- Enable Parents to access their linked students' data
-- Run this in your Supabase SQL Editor

-- 1. Profiles: parent can select their linked students' profiles
DROP POLICY IF EXISTS "parents_select_linked_students" ON profiles;
CREATE POLICY "parents_select_linked_students" ON profiles
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  id IN (SELECT student_id FROM parent_student_links WHERE parent_id = auth.uid())
);

-- 2. Attendance: parent can select their linked students' attendance
DROP POLICY IF EXISTS "parents_select_linked_students_attendance" ON attendance;
CREATE POLICY "parents_select_linked_students_attendance" ON attendance
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT student_id FROM parent_student_links WHERE parent_id = auth.uid())
);

-- 3. Grades: parent can select their linked students' grades
DROP POLICY IF EXISTS "parents_select_linked_students_grades" ON grades;
CREATE POLICY "parents_select_linked_students_grades" ON grades
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT student_id FROM parent_student_links WHERE parent_id = auth.uid())
);

-- 4. Classes: parents need to be able to see classes their students are enrolled in to join them for marks/attendance
DROP POLICY IF EXISTS "parents_select_linked_students_classes" ON classes;
CREATE POLICY "parents_select_linked_students_classes" ON classes
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  id IN (
    SELECT class_id FROM enrollments WHERE student_id IN (
      SELECT student_id FROM parent_student_links WHERE parent_id = auth.uid()
    )
  )
);

-- 5. Enrollments: parents can see enrollments of their linked students
DROP POLICY IF EXISTS "parents_select_linked_students_enrollments" ON enrollments;
CREATE POLICY "parents_select_linked_students_enrollments" ON enrollments
FOR SELECT USING (
  public.user_role() = 'parent' AND 
  student_id IN (SELECT student_id FROM parent_student_links WHERE parent_id = auth.uid())
);
