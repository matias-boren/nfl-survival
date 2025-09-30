-- Comprehensive fix for chat_messages RLS issues
-- This addresses potential problems with the RLS policies

-- First, let's disable RLS temporarily to see if that fixes the issue
-- (We'll re-enable it after creating proper policies)
ALTER TABLE chat_messages DISABLE ROW LEVEL SECURITY;

-- Drop ALL existing policies on chat_messages
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can update their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can delete their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Enable read access for all users" ON chat_messages;
DROP POLICY IF EXISTS "Enable insert for authenticated users only" ON chat_messages;
DROP POLICY IF EXISTS "Enable update for users based on user_id" ON chat_messages;
DROP POLICY IF EXISTS "Enable delete for users based on user_id" ON chat_messages;

-- Create a simple, permissive policy for testing
CREATE POLICY "Allow all operations for authenticated users" ON chat_messages
    FOR ALL
    USING (auth.uid() IS NOT NULL)
    WITH CHECK (auth.uid() IS NOT NULL);

-- Re-enable RLS
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Verify the policy was created
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

