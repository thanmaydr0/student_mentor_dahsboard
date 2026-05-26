-- Create fee_payments table
CREATE TABLE IF NOT EXISTS fee_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    payment_type TEXT NOT NULL CHECK (payment_type IN ('revaluation', 'exam_registration')),
    amount DECIMAL(10,2) NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    razorpay_order_id TEXT,
    razorpay_payment_id TEXT,
    receipt_url TEXT,
    subjects JSONB, -- Array of subject codes registered for (if applicable)
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE fee_payments ENABLE ROW LEVEL SECURITY;

-- Policy: Students can view their own payments
CREATE POLICY "Students can view own fee payments" ON fee_payments
    FOR SELECT TO authenticated
    USING (auth.uid() = student_id);

-- Policy: Mentors can view fee payments of their mentees
CREATE POLICY "Mentors can view mentee fee payments" ON fee_payments
    FOR SELECT TO authenticated
    USING (
        auth.uid() IN (
            SELECT mentor_id FROM profiles WHERE id = fee_payments.student_id
        )
    );

-- Policy: Students can insert their own pending payments
CREATE POLICY "Students can insert own payments" ON fee_payments
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = student_id);

-- Policy: Students can update their own payments (e.g. status upon success)
CREATE POLICY "Students can update own payments" ON fee_payments
    FOR UPDATE TO authenticated
    USING (auth.uid() = student_id);
