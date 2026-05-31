-- Drop the old insecure function
DROP FUNCTION IF EXISTS public.create_profile(uuid, text, text, text, integer);

-- Create the secure function that forces the 'student' role
CREATE OR REPLACE FUNCTION public.create_profile(
    p_user_id uuid,
    p_full_name text,
    p_branch text,
    p_semester integer
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role, branch, semester)
  VALUES (p_user_id, p_full_name, 'student', p_branch, p_semester);
END;
$$;
