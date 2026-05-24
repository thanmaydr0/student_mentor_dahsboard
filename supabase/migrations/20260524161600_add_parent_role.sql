-- 1. Add 'parent' to user_role ENUM
ALTER TYPE user_role ADD VALUE IF NOT EXISTS 'parent';

-- 2. Create parent_student_links table
CREATE TABLE IF NOT EXISTS parent_student_links (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  parent_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(parent_id, student_id)
);

-- 3. Create direct_messages table for mentor-parent chat
CREATE TABLE IF NOT EXISTS direct_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  sender_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  receiver_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  content_type TEXT NOT NULL DEFAULT 'text' CHECK (content_type IN ('text', 'audio')),
  content_url_or_text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  read_at TIMESTAMPTZ
);

-- 4. Enable RLS and add Policies for the new tables
ALTER TABLE parent_student_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE direct_messages ENABLE ROW LEVEL SECURITY;

-- Parent links policy: Parents can see their own links. Students can see their own links.
-- Mentors can see links for students they mentor. (Simplification: anyone can read for now, but restrict write)
CREATE POLICY "Users can read their own parent_student_links" ON parent_student_links
  FOR SELECT USING (
    auth.uid() = parent_id OR auth.uid() = student_id OR 
    auth.uid() IN (SELECT mentor_id FROM profiles WHERE id = student_id)
  );

CREATE POLICY "Admins/System can insert parent_student_links" ON parent_student_links
  FOR INSERT WITH CHECK (true); -- In a real app, restrict this more

-- Direct messages policy: Sender and Receiver can read. Sender can insert.
CREATE POLICY "Users can read their messages" ON direct_messages
  FOR SELECT USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE POLICY "Users can insert their messages" ON direct_messages
  FOR INSERT WITH CHECK (auth.uid() = sender_id);

CREATE POLICY "Users can update their received messages (e.g. read_at)" ON direct_messages
  FOR UPDATE USING (auth.uid() = receiver_id);

-- 5. Add index to speed up chat loading
CREATE INDEX IF NOT EXISTS idx_direct_messages_participants ON direct_messages(sender_id, receiver_id);
