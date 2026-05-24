-- Run this in your Supabase SQL Editor
-- This fixes the missing "aud" column and explicitly sets the password to 123456.

UPDATE auth.users 
SET 
  aud = 'authenticated',
  encrypted_password = crypt('123456', gen_salt('bf'))
WHERE email = 'sejal.parent@edupredict.com';
