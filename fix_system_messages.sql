-- Fix system messages to use proper UUID format
-- First, let's update the trigger function to use the system UUID

CREATE OR REPLACE FUNCTION create_league_system_message()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (NEW.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A new user joined the league!', true);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (OLD.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A user left the league!', true);
  END IF;
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Update existing system messages to use the proper UUID and user_name
UPDATE chat_messages 
SET user_id = '00000000-0000-0000-0000-000000000000',
    user_name = 'System'
WHERE is_system_message = true 
  AND user_id != '00000000-0000-0000-0000-000000000000';

-- Add user_name column if it doesn't exist
ALTER TABLE chat_messages ADD COLUMN IF NOT EXISTS user_name TEXT;

-- Update all existing messages to have user_name
UPDATE chat_messages 
SET user_name = COALESCE(
  (SELECT display_name FROM user_profiles WHERE user_id = chat_messages.user_id),
  'User ' || SUBSTRING(user_id::text, 1, 8)
)
WHERE user_name IS NULL;

-- Make user_name NOT NULL for new inserts
ALTER TABLE chat_messages ALTER COLUMN user_name SET NOT NULL;
