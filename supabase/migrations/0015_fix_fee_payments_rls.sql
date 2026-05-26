-- Fix: Mentors can't see fee payments due to RLS recursion on profiles table.
-- Solution: Use a SECURITY DEFINER function to check mentor-student relationship
-- without being blocked by profiles RLS.

CREATE OR REPLACE FUNCTION is_mentor_of_student(p_student_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = p_student_id 
    AND mentor_id = auth.uid()
  );
$$;

-- Drop the old broken policy
DROP POLICY IF EXISTS "Mentors can view mentee fee payments" ON fee_payments;

-- Create new policy using the SECURITY DEFINER function
CREATE POLICY "Mentors can view mentee fee payments" ON fee_payments
    FOR SELECT TO authenticated
    USING (
      auth.uid() = student_id  -- students see their own
      OR is_mentor_of_student(student_id)  -- mentors see their mentees'
    );

-- Also drop and recreate the student select policy to avoid conflict
DROP POLICY IF EXISTS "Students can view own fee payments" ON fee_payments;
