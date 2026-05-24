-- Run this in your Supabase SQL Editor to reset passwords to 123456
UPDATE auth.users
SET encrypted_password = crypt('123456', gen_salt('bf'))
WHERE email IN (
  'sejal.parent@edupredict.com',
  'sejal.kumari@edupredict.com',
  'neha.pandey@edupredict.com'
);
