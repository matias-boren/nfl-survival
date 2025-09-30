-- Temporarily disable the system message trigger
-- This is the simplest fix to test if the trigger is causing the issue

-- First, find the exact trigger name
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing
FROM information_schema.triggers 
WHERE action_statement LIKE '%create_league_system_message%';

-- Then disable it (you'll need to replace 'trigger_name' with the actual name from above)
-- For example, if the trigger is called 'create_league_system_message_trigger':
-- DROP TRIGGER IF EXISTS create_league_system_message_trigger ON league_members;

-- Alternative: Drop the function entirely (this will also disable any triggers using it)
DROP FUNCTION IF EXISTS create_league_system_message() CASCADE;

-- Verify the trigger is gone
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing
FROM information_schema.triggers 
WHERE action_statement LIKE '%create_league_system_message%';

-- This should return no results if successful

