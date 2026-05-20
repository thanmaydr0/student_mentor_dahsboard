-- Update iat_marks table to support multiple assessment types
-- Drop the existing constraints that rely on iat_number
ALTER TABLE iat_marks DROP CONSTRAINT IF EXISTS iat_marks_student_id_class_id_iat_number_key;
ALTER TABLE iat_marks DROP CONSTRAINT IF EXISTS iat_marks_iat_number_check;

-- Add new columns for the different assessments
ALTER TABLE iat_marks
  ADD COLUMN IF NOT EXISTS iat1 NUMERIC(5,2) CHECK (iat1 BETWEEN 0 AND 50),
  ADD COLUMN IF NOT EXISTS iat2 NUMERIC(5,2) CHECK (iat2 BETWEEN 0 AND 50),
  ADD COLUMN IF NOT EXISTS lab_iat1 NUMERIC(5,2) CHECK (lab_iat1 BETWEEN 0 AND 50),
  ADD COLUMN IF NOT EXISTS lab_iat2 NUMERIC(5,2) CHECK (lab_iat2 BETWEEN 0 AND 50),
  ADD COLUMN IF NOT EXISTS assignment1 NUMERIC(5,2) CHECK (assignment1 BETWEEN 0 AND 50),
  ADD COLUMN IF NOT EXISTS assignment2 NUMERIC(5,2) CHECK (assignment2 BETWEEN 0 AND 50);

-- Drop the old columns
ALTER TABLE iat_marks DROP COLUMN IF EXISTS iat_number;
ALTER TABLE iat_marks DROP COLUMN IF EXISTS marks_obtained;
ALTER TABLE iat_marks DROP COLUMN IF EXISTS max_marks;

-- Add new unique constraint (one row per student per class)
ALTER TABLE iat_marks ADD CONSTRAINT iat_marks_student_class_key UNIQUE (student_id, class_id);
