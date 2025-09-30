-- Check for database triggers that might be creating chat messages
-- when a league is created

-- Check for triggers on the leagues table
SELECT 
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_table = 'leagues'
ORDER BY trigger_name;

-- Check for triggers on the league_members table
SELECT 
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_table = 'league_members'
ORDER BY trigger_name;

-- Check for any functions that might be called by triggers
SELECT 
    routine_name,
    routine_type,
    routine_definition
FROM information_schema.routines 
WHERE routine_schema = 'public'
AND routine_name LIKE '%chat%'
ORDER BY routine_name;

-- Check if there are any policies that might be causing issues
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
WHERE tablename IN ('chat_messages', 'leagues', 'league_members')
ORDER BY tablename, policyname;

