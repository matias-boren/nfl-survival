-- Create chat_messages table for league chat functionality
CREATE TABLE IF NOT EXISTS chat_messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  is_system_message BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_chat_messages_league_id ON chat_messages(league_id);
CREATE INDEX IF NOT EXISTS idx_chat_messages_created_at ON chat_messages(created_at);
CREATE INDEX IF NOT EXISTS idx_chat_messages_league_created ON chat_messages(league_id, created_at);

-- Enable RLS
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for chat_messages
CREATE POLICY "Users can view messages in their leagues" ON chat_messages
  FOR SELECT USING (
    league_id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert messages in their leagues" ON chat_messages
  FOR INSERT WITH CHECK (
    league_id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    ) AND user_id = auth.uid()
  );

CREATE POLICY "Users can update their own messages" ON chat_messages
  FOR UPDATE USING (
    user_id = auth.uid() AND
    league_id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own messages" ON chat_messages
  FOR DELETE USING (
    user_id = auth.uid() AND
    league_id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    )
  );

-- Create a function to automatically create system messages when users join/leave leagues
CREATE OR REPLACE FUNCTION create_league_system_message()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO chat_messages (league_id, user_id, message, is_system_message)
    VALUES (NEW.league_id, NEW.user_id, 'joined the league', true);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO chat_messages (league_id, user_id, message, is_system_message)
    VALUES (OLD.league_id, OLD.user_id, 'left the league', true);
  END IF;
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Create triggers for automatic system messages
CREATE TRIGGER league_member_join_trigger
  AFTER INSERT ON league_members
  FOR EACH ROW
  EXECUTE FUNCTION create_league_system_message();

CREATE TRIGGER league_member_leave_trigger
  AFTER DELETE ON league_members
  FOR EACH ROW
  EXECUTE FUNCTION create_league_system_message();
