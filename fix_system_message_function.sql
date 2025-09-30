-- Fix the system message function to work with RLS
-- The function is trying to insert with a hardcoded user ID that doesn't exist

-- First, let's see what triggers are using this function
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing,
    action_statement
FROM information_schema.triggers 
WHERE action_statement LIKE '%create_league_system_message%';

-- Option 1: Update the function to use a valid system user ID
-- We need to either create a system user or modify the function

-- Create a system user for automated messages
INSERT INTO auth.users (
    id,
    instance_id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin,
    last_sign_in_at,
    email_change,
    email_change_sent_at,
    confirmation_token,
    email_change_token,
    recovery_token
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'system@nfl-survival.com',
    '$2a$10$dummy.hash.for.system.user',
    NOW(),
    NOW(),
    NOW(),
    '{"provider": "email", "providers": ["email"]}',
    '{"display_name": "System"}',
    false,
    NOW(),
    '',
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

-- Create a user profile for the system user
INSERT INTO user_profiles (
    user_id,
    display_name,
    is_premium,
    created_at
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    'System',
    false,
    NOW()
) ON CONFLICT (user_id) DO NOTHING;

-- Update the function to handle RLS properly
CREATE OR REPLACE FUNCTION create_league_system_message()
RETURNS TRIGGER AS $$
BEGIN
  -- Use SECURITY DEFINER to run with elevated privileges
  IF TG_OP = 'INSERT' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (NEW.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A new user joined the league!', true);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO chat_messages (league_id, user_id, user_name, message, is_system_message)
    VALUES (OLD.league_id, '00000000-0000-0000-0000-000000000000', 'System', 'A user left the league!', true);
  END IF;
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant necessary permissions to the function
GRANT EXECUTE ON FUNCTION create_league_system_message() TO authenticated;
GRANT EXECUTE ON FUNCTION create_league_system_message() TO anon;

-- Update the RLS policy to allow the system user to insert messages
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
        -- Allow system user to insert system messages
        (
            user_id = '00000000-0000-0000-0000-000000000000'
            AND is_system_message = true
        )
    );

-- Verify the function and policies
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

