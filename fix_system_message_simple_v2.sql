-- Simple fix for the system message function without touching auth.users
-- This approach modifies the function and RLS policies to work properly

-- First, let's see what triggers are using this function
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing,
    action_statement
FROM information_schema.triggers 
WHERE action_statement LIKE '%create_league_system_message%';

-- Option 1: Update the function to bypass RLS temporarily
CREATE OR REPLACE FUNCTION create_league_system_message()
RETURNS TRIGGER AS $$
BEGIN
  -- Temporarily disable RLS for this function
  SET row_security = off;
  
  IF TG_OP = 'INSERT' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (NEW.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A new user joined the league!', true);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (OLD.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A user left the league!', true);
  END IF;
  
  -- Re-enable RLS
  SET row_security = on;
  
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant necessary permissions
GRANT EXECUTE ON FUNCTION create_league_system_message() TO authenticated;
GRANT EXECUTE ON FUNCTION create_league_system_message() TO anon;

-- Option 2: Create a more permissive RLS policy that allows system messages
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;

CREATE POLICY "Users can insert chat messages for leagues they belong to" ON chat_messages
    FOR INSERT
    WITH CHECK (
        -- Allow regular users who are league members
        (
            user_id = auth.uid()
            AND EXISTS (
                SELECT 1 FROM league_members lm
                WHERE lm.league_id = chat_messages.league_id
                AND lm.user_id = auth.uid()
            )
        )
        OR
        -- Allow system messages (bypass user check for system messages)
        (
            user_id = '00000000-0000-0000-0000-000000000000'
            AND is_system_message = true
        )
    );

-- Also update the read policy to allow reading system messages
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;

CREATE POLICY "Users can read chat messages for leagues they belong to" ON chat_messages
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
        OR
        -- Allow reading system messages
        is_system_message = true
    );

-- Verify the policies
SELECT 
    schemaname, 
    tablename, 
    policyname, 
    permissive, 
    roles, 
    cmd, 
    qual, 
    with_check
FROM pg_policies 
WHERE tablename = 'chat_messages'
ORDER BY policyname;

