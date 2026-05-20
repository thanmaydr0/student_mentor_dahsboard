-- Run this entire script in your Supabase SQL Editor
-- It safely adds AI, DMS, and ADA subjects and enrolls your students in them.

DO $$ 
DECLARE
  v_mentor_id UUID;
  v_ai_subject UUID;
  v_dms_subject UUID;
  v_ada_subject UUID;
  v_ai_class UUID;
  v_dms_class UUID;
  v_ada_class UUID;
  r RECORD;
BEGIN
  -- 1. Insert the 3 subjects if they don't exist
  INSERT INTO subjects (name, code, description) 
  VALUES ('Artificial Intelligence', 'BCS301', 'Core AI concepts') 
  ON CONFLICT (code) DO NOTHING;
  
  INSERT INTO subjects (name, code, description) 
  VALUES ('Discrete Mathematical Structures', 'BCS302', 'DMS concepts') 
  ON CONFLICT (code) DO NOTHING;
  
  INSERT INTO subjects (name, code, description) 
  VALUES ('Algorithm Design and Analysis', 'BCS303', 'ADA concepts') 
  ON CONFLICT (code) DO NOTHING;

  -- 2. Get the subject IDs
  SELECT id INTO v_ai_subject FROM subjects WHERE name = 'Artificial Intelligence' LIMIT 1;
  SELECT id INTO v_dms_subject FROM subjects WHERE name = 'Discrete Mathematical Structures' LIMIT 1;
  SELECT id INTO v_ada_subject FROM subjects WHERE name = 'Algorithm Design and Analysis' LIMIT 1;

  -- 3. Get your mentor ID (picks the first mentor account)
  SELECT id INTO v_mentor_id FROM profiles WHERE role = 'mentor' LIMIT 1;

  IF v_mentor_id IS NULL THEN
    RAISE EXCEPTION 'No mentor found in the database. Please create a mentor profile first.';
  END IF;

  -- 4. Create classes for these subjects (Academic Year 2024-25, Semester 3)
  INSERT INTO classes (subject_id, mentor_id, academic_year, semester) 
  VALUES (v_ai_subject, v_mentor_id, '2024-25', 3) 
  ON CONFLICT (subject_id, mentor_id, academic_year, semester) DO NOTHING;
  
  INSERT INTO classes (subject_id, mentor_id, academic_year, semester) 
  VALUES (v_dms_subject, v_mentor_id, '2024-25', 3) 
  ON CONFLICT (subject_id, mentor_id, academic_year, semester) DO NOTHING;
  
  INSERT INTO classes (subject_id, mentor_id, academic_year, semester) 
  VALUES (v_ada_subject, v_mentor_id, '2024-25', 3) 
  ON CONFLICT (subject_id, mentor_id, academic_year, semester) DO NOTHING;

  -- 5. Get the class IDs
  SELECT id INTO v_ai_class FROM classes WHERE subject_id = v_ai_subject AND mentor_id = v_mentor_id LIMIT 1;
  SELECT id INTO v_dms_class FROM classes WHERE subject_id = v_dms_subject AND mentor_id = v_mentor_id LIMIT 1;
  SELECT id INTO v_ada_class FROM classes WHERE subject_id = v_ada_subject AND mentor_id = v_mentor_id LIMIT 1;

  -- 6. Enroll all students assigned to this mentor into these new classes
  FOR r IN SELECT id FROM profiles WHERE role = 'student' AND mentor_id = v_mentor_id LOOP
    INSERT INTO enrollments (student_id, class_id) VALUES (r.id, v_ai_class) ON CONFLICT DO NOTHING;
    INSERT INTO enrollments (student_id, class_id) VALUES (r.id, v_dms_class) ON CONFLICT DO NOTHING;
    INSERT INTO enrollments (student_id, class_id) VALUES (r.id, v_ada_class) ON CONFLICT DO NOTHING;
  END LOOP;

END $$;
