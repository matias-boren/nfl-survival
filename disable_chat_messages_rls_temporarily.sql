-- TEMPORARY FIX: Disable RLS on chat_messages completely
-- This will help us determine if RLS is the root cause

-- Disable RLS on chat_messages
ALTER TABLE chat_messages DISABLE ROW LEVEL SECURITY;

-- Drop all existing policies
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can update their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can delete their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Allow all operations for authenticated users" ON chat_messages;
DROP POLICY IF EXISTS "Enable read access for all users" ON chat_messages;
DROP POLICY IF EXISTS "Enable insert for authenticated users only" ON chat_messages;
DROP POLICY IF EXISTS "Enable update for users based on user_id" ON chat_messages;
DROP POLICY IF EXISTS "Enable delete for users based on user_id" ON chat_messages;

-- Verify RLS is disabled
SELECT 
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'chat_messages' 
AND schemaname = 'public';

-- This should show rowsecurity = false

