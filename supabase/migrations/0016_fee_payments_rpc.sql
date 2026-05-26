-- Direct RPC approach: bypasses all RLS issues by using a SECURITY DEFINER function
-- that returns fee payments for the authenticated mentor's students.

DROP FUNCTION IF EXISTS get_mentor_fee_payments();

CREATE OR REPLACE FUNCTION get_mentor_fee_payments()
RETURNS TABLE (
  id UUID,
  student_id UUID,
  payment_type TEXT,
  amount DECIMAL,
  status TEXT,
  razorpay_order_id TEXT,
  razorpay_payment_id TEXT,
  subjects JSONB,
  created_at TIMESTAMPTZ,
  student_name TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    fp.id,
    fp.student_id,
    fp.payment_type,
    fp.amount,
    fp.status,
    fp.razorpay_order_id,
    fp.razorpay_payment_id,
    fp.subjects,
    fp.created_at,
    p.full_name AS student_name
  FROM fee_payments fp
  JOIN profiles p ON p.id = fp.student_id
  WHERE p.mentor_id = auth.uid()
  ORDER BY fp.created_at DESC;
END;
$$;
