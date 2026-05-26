-- =============================================================================
-- Send Notification RPC for Mentors
-- =============================================================================

CREATE OR REPLACE FUNCTION send_mentor_notification(
  p_student_id UUID,
  p_title TEXT,
  p_body TEXT,
  p_type TEXT
) RETURNS VOID AS $$
DECLARE
  v_mentor_id UUID;
  v_msg_id UUID;
BEGIN
  -- Verify the caller is the student's mentor
  SELECT mentor_id INTO v_mentor_id
  FROM profiles
  WHERE id = p_student_id;

  IF v_mentor_id != auth.uid() THEN
    RAISE EXCEPTION 'Unauthorized: You are not the mentor for this student.';
  END IF;

  -- Insert the message
  INSERT INTO notification_messages (title, body, type, deep_link)
  VALUES (
    p_title,
    p_body,
    p_type,
    '/student/notifications'
  )
  RETURNING id INTO v_msg_id;

  -- Link to the student
  INSERT INTO user_notifications (user_id, message_id)
  VALUES (p_student_id, v_msg_id)
  ON CONFLICT (user_id, message_id) DO NOTHING;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION send_mentor_notification TO authenticated;
