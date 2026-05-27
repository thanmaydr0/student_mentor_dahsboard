-- Create achievements table
CREATE TABLE IF NOT EXISTS public.achievements (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id uuid REFERENCES auth.users NOT NULL,
  title text NOT NULL,
  category text NOT NULL,
  event_date date,
  event_time text,
  cert_url text,
  attendance_claimed boolean DEFAULT false,
  notes text,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;

-- Policies for achievements
CREATE POLICY "Users can view their own achievements"
  ON public.achievements FOR SELECT
  USING (auth.uid() = student_id);

CREATE POLICY "Users can insert their own achievements"
  ON public.achievements FOR INSERT
  WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Users can update their own achievements"
  ON public.achievements FOR UPDATE
  USING (auth.uid() = student_id)
  WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Users can delete their own achievements"
  ON public.achievements FOR DELETE
  USING (auth.uid() = student_id);

-- Create storage bucket for certificates
INSERT INTO storage.buckets (id, name, public) 
VALUES ('certificates', 'certificates', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies
CREATE POLICY "Public can view certificates"
  ON storage.objects FOR SELECT
  USING ( bucket_id = 'certificates' );

CREATE POLICY "Users can upload certificates"
  ON storage.objects FOR INSERT
  WITH CHECK ( bucket_id = 'certificates' AND auth.uid() IS NOT NULL );

CREATE POLICY "Users can update their own certificates"
  ON storage.objects FOR UPDATE
  USING ( bucket_id = 'certificates' AND auth.uid() IS NOT NULL );

CREATE POLICY "Users can delete their own certificates"
  ON storage.objects FOR DELETE
  USING ( bucket_id = 'certificates' AND auth.uid() IS NOT NULL );
