-- 1. Add columns (safely checking if they already exist)
ALTER TABLE public.attendance ADD COLUMN IF NOT EXISTS mentor_id UUID REFERENCES public.profiles(id);
ALTER TABLE public.grades ADD COLUMN IF NOT EXISTS mentor_id UUID REFERENCES public.profiles(id);

-- 2. Backfill existing attendance records by joining through the classes table
UPDATE public.attendance a
SET mentor_id = c.mentor_id
FROM public.classes c
WHERE a.class_id = c.id;

-- 3. Backfill existing grades records by joining through the classes table
UPDATE public.grades g
SET mentor_id = c.mentor_id
FROM public.classes c
WHERE g.class_id = c.id;

-- 4. Enforce NOT NULL for future inserts to prevent orphaned records
ALTER TABLE public.attendance ALTER COLUMN mentor_id SET NOT NULL;
ALTER TABLE public.grades ALTER COLUMN mentor_id SET NOT NULL;

-- 5. Drop the old, slow RLS policies (Assuming standard names, adjust if yours differ)
-- We use DO block to safely drop policies if they exist without failing
DO $$ 
BEGIN
    -- For Attendance
    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'attendance' AND policyname = 'Mentors can view their students attendance'
    ) THEN
        DROP POLICY "Mentors can view their students attendance" ON public.attendance;
    END IF;
    
    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'attendance' AND policyname = 'Mentors can insert attendance for their students'
    ) THEN
        DROP POLICY "Mentors can insert attendance for their students" ON public.attendance;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'attendance' AND policyname = 'Mentors can update attendance for their students'
    ) THEN
        DROP POLICY "Mentors can update attendance for their students" ON public.attendance;
    END IF;

    -- For Grades
    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'grades' AND policyname = 'Mentors can view their students grades'
    ) THEN
        DROP POLICY "Mentors can view their students grades" ON public.grades;
    END IF;
    
    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'grades' AND policyname = 'Mentors can insert grades for their students'
    ) THEN
        DROP POLICY "Mentors can insert grades for their students" ON public.grades;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = 'grades' AND policyname = 'Mentors can update grades for their students'
    ) THEN
        DROP POLICY "Mentors can update grades for their students" ON public.grades;
    END IF;
END $$;

-- 6. Create the NEW, highly optimized RLS policies using the denormalized mentor_id
-- ATTENDANCE
CREATE POLICY "Mentors can view their students attendance" 
ON public.attendance FOR SELECT TO authenticated
USING (auth.uid() = mentor_id);

CREATE POLICY "Mentors can insert attendance for their students" 
ON public.attendance FOR INSERT TO authenticated
WITH CHECK (auth.uid() = mentor_id);

CREATE POLICY "Mentors can update attendance for their students" 
ON public.attendance FOR UPDATE TO authenticated
USING (auth.uid() = mentor_id)
WITH CHECK (auth.uid() = mentor_id);

-- GRADES
CREATE POLICY "Mentors can view their students grades" 
ON public.grades FOR SELECT TO authenticated
USING (auth.uid() = mentor_id);

CREATE POLICY "Mentors can insert grades for their students" 
ON public.grades FOR INSERT TO authenticated
WITH CHECK (auth.uid() = mentor_id);

CREATE POLICY "Mentors can update grades for their students" 
ON public.grades FOR UPDATE TO authenticated
USING (auth.uid() = mentor_id)
WITH CHECK (auth.uid() = mentor_id);
