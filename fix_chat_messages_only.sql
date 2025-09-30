-- Minimal fix for chat_messages RLS policy
-- This only fixes the immediate issue with private league creation

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can update their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can delete their own chat messages" ON chat_messages;

-- Create new policies
CREATE POLICY "Users can read chat messages for leagues they belong to" ON chat_messages
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

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

-- Ensure RLS is enabled
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Verify the policies were created
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

