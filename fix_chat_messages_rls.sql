-- Fix RLS policies for chat_messages table
-- This will allow league members to read and write chat messages

-- First, let's see the current policies
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies 
WHERE tablename = 'chat_messages';

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can update their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can delete their own chat messages" ON chat_messages;

-- Create comprehensive RLS policies for chat_messages

-- 1. Allow users to read chat messages for leagues they belong to
CREATE POLICY "Users can read chat messages for leagues they belong to" ON chat_messages
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- 2. Allow users to insert chat messages for leagues they belong to
CREATE POLICY "Users can insert chat messages for leagues they belong to" ON chat_messages
    FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
        AND user_id = auth.uid()
    );

-- 3. Allow users to update their own chat messages
CREATE POLICY "Users can update their own chat messages" ON chat_messages
    FOR UPDATE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    )
    WITH CHECK (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- 4. Allow users to delete their own chat messages
CREATE POLICY "Users can delete their own chat messages" ON chat_messages
    FOR DELETE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- Ensure RLS is enabled on the table
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Verify the policies were created
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies 
WHERE tablename = 'chat_messages'
ORDER BY policyname;

