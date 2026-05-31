CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Add encrypted column
ALTER TABLE public.erp_credentials ADD COLUMN password_encrypted bytea;

-- Encrypt existing passwords using pgcrypto
UPDATE public.erp_credentials 
SET password_encrypted = pgp_sym_encrypt(password, 'edupredict_erp_secret_key');

-- Drop the plaintext column
ALTER TABLE public.erp_credentials DROP COLUMN password;

-- Create an RPC to securely fetch decrypted credentials 
-- This function runs with SECURITY DEFINER privileges to access the encrypted column
CREATE OR REPLACE FUNCTION public.get_decrypted_erp_credentials(p_student_ids uuid[])
RETURNS TABLE(student_id uuid, username text, password text)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    e.student_id, 
    e.username, 
    pgp_sym_decrypt(e.password_encrypted, 'edupredict_erp_secret_key') AS password
  FROM public.erp_credentials e
  WHERE e.student_id = ANY(p_student_ids);
END;
$$;
