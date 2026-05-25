-- 1. Resumes Table
CREATE TABLE resumes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    resume_data JSONB NOT NULL DEFAULT '{}'::jsonb,
    ats_score INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Job Applications Table
CREATE TABLE job_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    company_name TEXT NOT NULL,
    job_title TEXT NOT NULL,
    location TEXT,
    status TEXT NOT NULL DEFAULT 'Applied', -- Applied, Interview, Offer, Rejected
    salary_range TEXT,
    notes TEXT,
    resume_id UUID REFERENCES resumes(id) ON DELETE SET NULL,
    applied_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Cover Letters Table
CREATE TABLE cover_letters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    application_id UUID REFERENCES job_applications(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Resume Examples Table (Gallery)
CREATE TABLE resume_examples (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    industry TEXT NOT NULL,
    title TEXT NOT NULL,
    resume_data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Triggers for updated_at
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_resumes_modtime
    BEFORE UPDATE ON resumes
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_job_applications_modtime
    BEFORE UPDATE ON job_applications
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_cover_letters_modtime
    BEFORE UPDATE ON cover_letters
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

-- Enable RLS
ALTER TABLE resumes ENABLE ROW LEVEL SECURITY;
ALTER TABLE job_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE cover_letters ENABLE ROW LEVEL SECURITY;
ALTER TABLE resume_examples ENABLE ROW LEVEL SECURITY;

-- RLS Policies

-- Resumes: students can manage their own
CREATE POLICY "Students can view own resumes" ON resumes
    FOR SELECT USING (auth.uid() = student_id);
CREATE POLICY "Students can insert own resumes" ON resumes
    FOR INSERT WITH CHECK (auth.uid() = student_id);
CREATE POLICY "Students can update own resumes" ON resumes
    FOR UPDATE USING (auth.uid() = student_id);
CREATE POLICY "Students can delete own resumes" ON resumes
    FOR DELETE USING (auth.uid() = student_id);

-- Job Applications: students can manage their own
CREATE POLICY "Students can view own applications" ON job_applications
    FOR SELECT USING (auth.uid() = student_id);
CREATE POLICY "Students can insert own applications" ON job_applications
    FOR INSERT WITH CHECK (auth.uid() = student_id);
CREATE POLICY "Students can update own applications" ON job_applications
    FOR UPDATE USING (auth.uid() = student_id);
CREATE POLICY "Students can delete own applications" ON job_applications
    FOR DELETE USING (auth.uid() = student_id);

-- Cover Letters: students can manage their own
CREATE POLICY "Students can view own cover letters" ON cover_letters
    FOR SELECT USING (auth.uid() = student_id);
CREATE POLICY "Students can insert own cover letters" ON cover_letters
    FOR INSERT WITH CHECK (auth.uid() = student_id);
CREATE POLICY "Students can update own cover letters" ON cover_letters
    FOR UPDATE USING (auth.uid() = student_id);
CREATE POLICY "Students can delete own cover letters" ON cover_letters
    FOR DELETE USING (auth.uid() = student_id);

-- Resume Examples: anyone authenticated can read, only authenticated can insert (for admin seeding)
CREATE POLICY "Anyone authenticated can view resume examples" ON resume_examples
    FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can insert examples" ON resume_examples
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');
