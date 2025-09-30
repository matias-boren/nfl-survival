-- Debug script to understand what's happening during league creation
-- Run this to see the current state and identify the issue

-- 1. Check if there are any triggers on the leagues table
SELECT 
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_table = 'leagues'
ORDER BY trigger_name;

-- 2. Check if there are any triggers on the league_members table
SELECT 
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_table = 'league_members'
ORDER BY trigger_name;

-- 3. Check the current RLS policies on chat_messages
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

-- 4. Check if RLS is enabled on chat_messages
SELECT 
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'chat_messages' 
AND schemaname = 'public';

-- 5. Check the structure of chat_messages table
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_name = 'chat_messages' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 6. Check if there are any functions that might be called
SELECT 
    routine_name,
    routine_type,
    routine_definition
FROM information_schema.routines 
WHERE routine_schema = 'public'
AND (routine_name LIKE '%chat%' OR routine_name LIKE '%league%')
ORDER BY routine_name;

