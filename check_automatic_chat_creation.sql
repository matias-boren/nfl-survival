-- Check for any automatic chat message creation
-- This will help identify if there's a trigger or function creating messages

-- 1. Check all triggers in the database
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_schema = 'public'
ORDER BY event_object_table, trigger_name;

-- 2. Check all functions that might be related to chat or league creation
SELECT 
    routine_name,
    routine_type,
    routine_definition
FROM information_schema.routines 
WHERE routine_schema = 'public'
AND (
    routine_definition ILIKE '%chat%' 
    OR routine_definition ILIKE '%league%'
    OR routine_name ILIKE '%chat%'
    OR routine_name ILIKE '%league%'
)
ORDER BY routine_name;

-- 3. Check if there are any default values or constraints on chat_messages
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'chat_messages' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 4. Check for any foreign key constraints that might be causing issues
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
AND (tc.table_name = 'chat_messages' OR ccu.table_name = 'chat_messages')
ORDER BY tc.table_name, kcu.column_name;

