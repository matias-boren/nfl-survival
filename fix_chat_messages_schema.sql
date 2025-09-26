-- Add user_name column to chat_messages table
ALTER TABLE chat_messages ADD COLUMN IF NOT EXISTS user_name TEXT;

-- Update existing messages to have user_name (fallback to user_id if no display name)
UPDATE chat_messages 
SET user_name = COALESCE(
  (SELECT display_name FROM user_profiles WHERE user_id = chat_messages.user_id),
  'User ' || SUBSTRING(user_id::text, 1, 8)
)
WHERE user_name IS NULL;

-- Update system messages to have proper user_name
-- Note: system messages use a special UUID format
UPDATE chat_messages 
SET user_name = 'System'
WHERE user_id = '00000000-0000-0000-0000-000000000000' AND user_name != 'System';

-- Make user_name NOT NULL for new inserts
ALTER TABLE chat_messages ALTER COLUMN user_name SET NOT NULL;

-- Add default value for user_name
ALTER TABLE chat_messages ALTER COLUMN user_name SET DEFAULT 'User';

-- Update the system message function to include user_name
CREATE OR REPLACE FUNCTION create_league_system_message()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (NEW.league_id, NEW.user_id, 'System', 'joined the league', true);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (OLD.league_id, OLD.user_id, 'System', 'left the league', true);
  END IF;
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;
