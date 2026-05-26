-- Migration for AI Chat History
-- Stores the conversational context for the AI Telegram Bot

CREATE TABLE IF NOT EXISTS public.ai_chat_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES public.telegram_sessions(id) ON DELETE CASCADE NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('user', 'assistant', 'system', 'tool')),
    content TEXT,
    tool_calls JSONB,     -- Used when the assistant requests a tool
    tool_call_id TEXT,    -- Used when the role is 'tool' to map back to the assistant's request
    name TEXT,            -- Used when the role is 'tool' for the function name
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes for fast retrieval by session
CREATE INDEX IF NOT EXISTS idx_ai_chat_history_session_id ON public.ai_chat_history(session_id);

-- Row Level Security
ALTER TABLE public.ai_chat_history ENABLE ROW LEVEL SECURITY;

-- Allow edge functions (service_role) to do everything
CREATE POLICY "Enable all for service role on ai_chat_history" 
ON public.ai_chat_history 
FOR ALL 
USING (true) 
WITH CHECK (true);
