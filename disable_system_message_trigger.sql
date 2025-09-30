-- Temporarily disable the system message trigger to test league creation
-- This will help us confirm that the trigger is causing the issue

-- Find the trigger name
SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_timing,
    action_statement
FROM information_schema.triggers 
WHERE action_statement LIKE '%create_league_system_message%';

-- Disable the trigger (replace 'trigger_name' with actual name from above query)
-- DROP TRIGGER IF EXISTS [trigger_name] ON league_members;

-- Alternative: Drop the function entirely (this will also disable the trigger)
-- DROP FUNCTION IF EXISTS create_league_system_message();

-- To re-enable later, you would need to recreate the trigger:
-- CREATE TRIGGER [trigger_name]
--     AFTER INSERT OR DELETE ON league_members
--     FOR EACH ROW
--     EXECUTE FUNCTION create_league_system_message();

