-- Run this script in your Supabase SQL Editor
-- It adds Amogh under your EXISTING Neha Pandey account

-- 1. Create tables (safe to re-run)
CREATE TABLE IF NOT EXISTS erp_credentials (
    student_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

ALTER TABLE erp_credentials ENABLE ROW LEVEL SECURITY;

-- Drop policies if they already exist (safe re-run)
DROP POLICY IF EXISTS "Students can view own credentials" ON erp_credentials;
DROP POLICY IF EXISTS "Students can insert own credentials" ON erp_credentials;
DROP POLICY IF EXISTS "Students can update own credentials" ON erp_credentials;

CREATE POLICY "Students can view own credentials" 
ON erp_credentials FOR SELECT 
USING (auth.uid() = student_id);

CREATE POLICY "Students can insert own credentials" 
ON erp_credentials FOR INSERT 
WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Students can update own credentials" 
ON erp_credentials FOR UPDATE 
USING (auth.uid() = student_id);

CREATE TABLE IF NOT EXISTS erp_attendance_summary (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    class_id UUID REFERENCES classes(id) ON DELETE CASCADE,
    theory_held INTEGER DEFAULT 0,
    theory_attended INTEGER DEFAULT 0,
    theory_percentage NUMERIC DEFAULT 0,
    lab_held INTEGER DEFAULT 0,
    lab_attended INTEGER DEFAULT 0,
    lab_percentage NUMERIC DEFAULT 0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    UNIQUE(student_id, class_id)
);

ALTER TABLE erp_attendance_summary ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Mentors can view student erp attendance" ON erp_attendance_summary;
DROP POLICY IF EXISTS "Students can view own erp attendance" ON erp_attendance_summary;

CREATE POLICY "Mentors can view student erp attendance" 
ON erp_attendance_summary FOR SELECT 
USING (
    EXISTS (
        SELECT 1 FROM profiles 
        WHERE id = erp_attendance_summary.student_id 
        AND mentor_id = auth.uid()
    )
);

CREATE POLICY "Students can view own erp attendance" 
ON erp_attendance_summary FOR SELECT 
USING (auth.uid() = student_id);

-- Allow service role to insert/update erp_attendance_summary (for edge function)
DROP POLICY IF EXISTS "Service role can manage erp attendance" ON erp_attendance_summary;
CREATE POLICY "Service role can manage erp attendance"
ON erp_attendance_summary FOR ALL
USING (true)
WITH CHECK (true);

-- 2. Add Amogh under the EXISTING Neha Pandey
DO $$ 
DECLARE
  v_mentor_id UUID;
  v_student_id UUID := 'b0000000-0000-0000-0000-000000000002'::uuid;
  r RECORD;
BEGIN
  -- Find the EXISTING Neha Pandey mentor account
  SELECT id INTO v_mentor_id FROM profiles WHERE full_name = 'Neha Pandey' AND role = 'mentor' LIMIT 1;
  
  IF v_mentor_id IS NULL THEN
    RAISE EXCEPTION 'Neha Pandey mentor account not found! Please make sure you have signed up as Neha Pandey first.';
  END IF;

  RAISE NOTICE 'Found existing Neha Pandey with ID: %', v_mentor_id;

  -- Create auth user for Amogh (if not exists)
  INSERT INTO auth.users (id, instance_id, aud, role, email, encrypted_password, email_confirmed_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at)
  VALUES (v_student_id, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'amogh.cseaiml24@cmrit.ac.in', crypt('123456', gen_salt('bf')), now(), '{"provider":"email","providers":["email"]}', '{}', now(), now())
  ON CONFLICT (id) DO NOTHING;

  -- Also handle email conflict
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE id = v_student_id) THEN
    -- Email might already exist with different ID, find it
    SELECT id INTO v_student_id FROM auth.users WHERE email = 'amogh.cseaiml24@cmrit.ac.in';
    IF v_student_id IS NULL THEN
      RAISE EXCEPTION 'Could not create auth user for Amogh';
    END IF;
  END IF;

  -- Create or update profile for Amogh, linking to the REAL Neha Pandey
  INSERT INTO profiles (id, full_name, role, branch, semester, mentor_id) 
  VALUES (v_student_id, 'Amogh Sai Ykuntam', 'student', 'AIML', 3, v_mentor_id)
  ON CONFLICT (id) DO UPDATE SET 
    full_name = EXCLUDED.full_name,
    mentor_id = EXCLUDED.mentor_id,
    branch = EXCLUDED.branch,
    semester = EXCLUDED.semester;

  RAISE NOTICE 'Student Amogh created/updated with ID: % under mentor: %', v_student_id, v_mentor_id;

  -- Insert ERP Credentials for Amogh (bypass RLS with direct insert)
  INSERT INTO erp_credentials (student_id, username, password)
  VALUES (v_student_id, 'amogh.cseaiml24@cmrit.ac.in', '123456')
  ON CONFLICT (student_id) DO UPDATE SET username = EXCLUDED.username, password = EXCLUDED.password;

  -- Enroll Amogh into Neha's existing classes
  FOR r IN SELECT id FROM classes WHERE mentor_id = v_mentor_id LOOP
    INSERT INTO enrollments (student_id, class_id) VALUES (v_student_id, r.id) ON CONFLICT DO NOTHING;
  END LOOP;

  RAISE NOTICE 'Done! Amogh is now enrolled in all of Neha Pandeys classes.';
END $$;

-- Clean up the dummy Neha Pandey that was accidentally created earlier (if any)
DELETE FROM profiles WHERE id = 'a0000000-0000-0000-0000-000000000001' AND full_name = 'Neha Pandey';
DELETE FROM auth.users WHERE id = 'a0000000-0000-0000-0000-000000000001';
