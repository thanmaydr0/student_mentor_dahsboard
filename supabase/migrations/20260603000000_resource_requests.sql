-- Create the resource_requests table
CREATE TABLE public.resource_requests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    requester_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'fulfilled')),
    fulfilled_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    file_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create the subscribers table (the "Me Too" button)
CREATE TABLE public.resource_request_subscribers (
    request_id UUID REFERENCES public.resource_requests(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    PRIMARY KEY (request_id, user_id)
);

-- Turn on Row Level Security
ALTER TABLE public.resource_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.resource_request_subscribers ENABLE ROW LEVEL SECURITY;

-- Policies for resource_requests
-- 1. Everyone can view requests
CREATE POLICY "Anyone can view resource requests" 
    ON public.resource_requests FOR SELECT 
    USING (true);

-- 2. Authenticated users can create requests
CREATE POLICY "Users can create resource requests" 
    ON public.resource_requests FOR INSERT 
    WITH CHECK (auth.uid() = requester_id);

-- 3. Any user can update a request to fulfill it
CREATE POLICY "Users can fulfill requests" 
    ON public.resource_requests FOR UPDATE 
    USING (status = 'pending')
    WITH CHECK (status = 'fulfilled' AND fulfilled_by = auth.uid());

-- Policies for subscribers
-- 1. Everyone can view subscribers (to show "X people waiting")
CREATE POLICY "Anyone can view subscribers" 
    ON public.resource_request_subscribers FOR SELECT 
    USING (true);

-- 2. Users can subscribe themselves
CREATE POLICY "Users can subscribe to requests" 
    ON public.resource_request_subscribers FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

-- 3. Users can unsubscribe themselves
CREATE POLICY "Users can unsubscribe" 
    ON public.resource_request_subscribers FOR DELETE 
    USING (auth.uid() = user_id);

-- Set up storage bucket if it doesn't exist
INSERT INTO storage.buckets (id, name, public)
VALUES ('resources', 'resources', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies
CREATE POLICY "Public Access"
    ON storage.objects FOR SELECT
    USING ( bucket_id = 'resources' );

CREATE POLICY "Authenticated users can upload resources"
    ON storage.objects FOR INSERT
    WITH CHECK ( bucket_id = 'resources' AND auth.role() = 'authenticated' );
