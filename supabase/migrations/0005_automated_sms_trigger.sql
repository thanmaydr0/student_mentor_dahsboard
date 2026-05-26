-- =============================================================================
-- 1. Enable pg_net extension for webhooks
-- =============================================================================
CREATE EXTENSION IF NOT EXISTS pg_net;

-- =============================================================================
-- 2. Trigger function to invoke Edge Function for automated SMS
-- =============================================================================
CREATE OR REPLACE FUNCTION invoke_auto_sms_alert()
RETURNS TRIGGER AS $$
DECLARE
  v_percentage NUMERIC;
  v_subject_name TEXT;
  v_request_id BIGINT;
  v_url TEXT;
  v_anon_key TEXT;
BEGIN
  -- We only want to trigger this if the student is marked Absent
  -- OR we can check their overall attendance. Let's do both.
  
  -- Calculate current attendance for the class
  SELECT percentage, subject_name
  INTO v_percentage, v_subject_name
  FROM get_attendance_summary(NEW.student_id)
  WHERE class_id = NEW.class_id;

  -- Condition 1: Marked Absent
  -- Condition 2: Attendance drops below 75%
  IF NEW.status = 'Absent' OR (v_percentage IS NOT NULL AND v_percentage < 75) THEN
    
    -- In a real production environment, these would be fetched from vault or custom claims
    v_url := 'https://xjfpksstjolmfhaaajtt.supabase.co/functions/v1/auto-sms-alert';
    
    -- Make the asynchronous HTTP POST request
    SELECT net.http_post(
      url := v_url,
      headers := '{"Content-Type": "application/json"}'::jsonb,
      body := json_build_object(
        'student_id', NEW.student_id,
        'class_id', NEW.class_id,
        'subject_name', v_subject_name,
        'status', NEW.status,
        'current_percentage', v_percentage,
        'date', NEW.date
      )::jsonb
    ) INTO v_request_id;
    
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================================================
-- 3. Attach trigger to attendance table
-- =============================================================================
DROP TRIGGER IF EXISTS trigger_auto_sms_on_absence ON attendance;
CREATE TRIGGER trigger_auto_sms_on_absence
  AFTER INSERT OR UPDATE ON attendance
  FOR EACH ROW
  -- Optionally we can restrict this to only fire when status changes to absent
  -- WHEN (NEW.status = 'Absent')
  EXECUTE FUNCTION invoke_auto_sms_alert();
