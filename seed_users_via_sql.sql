-- Run this in your Supabase SQL Editor
-- First: clean up the partial insert from the previous failed attempt
DELETE FROM auth.identities WHERE user_id IN (SELECT id FROM auth.users WHERE email = 'sejal.parent@edupredict.com');
DELETE FROM auth.users WHERE email = 'sejal.parent@edupredict.com';

-- Now create everything cleanly
DO $$
DECLARE
  student_uid UUID;
  parent_uid UUID := gen_random_uuid();
BEGIN
  -- 1. Find existing student
  SELECT id INTO student_uid FROM auth.users WHERE email = 'sejal.kumari@edupredict.com';
  IF student_uid IS NULL THEN
    RAISE EXCEPTION 'Student sejal.kumari@edupredict.com not found!';
  END IF;

  -- 2. Create parent auth user
  INSERT INTO auth.users (id, instance_id, email, encrypted_password, email_confirmed_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, confirmation_token, email_change, email_change_token_new, recovery_token)
  VALUES (parent_uid, '00000000-0000-0000-0000-000000000000', 'sejal.parent@edupredict.com', crypt('Password123!', gen_salt('bf')), now(), '{"provider":"email","providers":["email"]}', '{"full_name":"Parent of Sejal","role":"parent"}', now(), now(), 'authenticated', '', '', '', '');

  -- 3. Create auth identity
  INSERT INTO auth.identities (id, provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), parent_uid::text, parent_uid, format('{"sub":"%s","email":"sejal.parent@edupredict.com"}', parent_uid::text)::jsonb, 'email', now(), now(), now());

  -- 4. Create parent profile (semester=1 to satisfy check constraint)
  INSERT INTO public.profiles (id, full_name, role, branch, semester)
  VALUES (parent_uid, 'Parent of Sejal', 'parent', 'N/A', 1);

  -- 5. Link parent to student
  INSERT INTO public.parent_student_links (parent_id, student_id)
  VALUES (parent_uid, student_uid);

  RAISE NOTICE 'Done! Parent ID: %, linked to Student ID: %', parent_uid, student_uid;
END $$;
