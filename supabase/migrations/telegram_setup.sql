-- Migration for Telegram Bot Integration

-- 1. Create telegram_sessions table
CREATE TABLE IF NOT EXISTS public.telegram_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    telegram_chat_id BIGINT UNIQUE NOT NULL,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    role TEXT CHECK (role IN ('student', 'mentor', 'parent')),
    linked_student_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    state TEXT DEFAULT 'idle',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Create parent_access_codes table
CREATE TABLE IF NOT EXISTS public.parent_access_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code TEXT UNIQUE NOT NULL,
    student_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    mentor_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    used_by_chat_id BIGINT,
    expires_at TIMESTAMPTZ DEFAULT (now() + INTERVAL '7 days'),
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Set up RLS (Row Level Security)

-- Enable RLS
ALTER TABLE public.telegram_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.parent_access_codes ENABLE ROW LEVEL SECURITY;

-- Policies for telegram_sessions
-- Only service role (Edge Functions) should have full access.
CREATE POLICY "Enable read access for service role" ON public.telegram_sessions FOR SELECT USING (true);
CREATE POLICY "Enable insert for service role" ON public.telegram_sessions FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for service role" ON public.telegram_sessions FOR UPDATE USING (true);

-- Policies for parent_access_codes
-- Mentors can manage codes they created, service role has full access.
CREATE POLICY "Mentors can manage their created codes" ON public.parent_access_codes FOR ALL USING (auth.uid() = mentor_id);
CREATE POLICY "Enable read access for all (for validation)" ON public.parent_access_codes FOR SELECT USING (true);
CREATE POLICY "Enable insert for service role" ON public.parent_access_codes FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for service role" ON public.parent_access_codes FOR UPDATE USING (true);

-- 4. Create function to generate random 6-character code
CREATE OR REPLACE FUNCTION generate_parent_code(p_student_id UUID, p_mentor_id UUID) 
RETURNS TEXT AS $$
DECLARE
    new_code TEXT;
    code_exists BOOLEAN;
BEGIN
    LOOP
        -- Generate a random 6-character alphanumeric uppercase code
        new_code := upper(substring(md5(random()::text), 1, 6));
        
        -- Check if it already exists
        SELECT EXISTS(SELECT 1 FROM public.parent_access_codes WHERE code = new_code) INTO code_exists;
        
        IF NOT code_exists THEN
            -- Insert the new code
            INSERT INTO public.parent_access_codes (code, student_id, mentor_id)
            VALUES (new_code, p_student_id, p_mentor_id);
            
            RETURN new_code;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
