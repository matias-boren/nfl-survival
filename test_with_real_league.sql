-- Test invitation creation with a real league ID
-- First, let's see what leagues exist in your database

-- Check existing leagues
SELECT id, name, creator_id FROM leagues LIMIT 5;

-- If you have leagues, use one of those IDs below
-- If not, we'll create a test league first

-- Option 1: Use an existing league ID (replace with actual ID from above query)
-- INSERT INTO league_invitations (
--   "leagueId",
--   "invitedByUserId", 
--   "invitationCode",
--   status,
--   "createdAt",
--   "expiresAt"
-- ) VALUES (
--   'REPLACE_WITH_REAL_LEAGUE_ID',
--   'REPLACE_WITH_REAL_USER_ID',
--   'TEST123',
--   'pending',
--   NOW(),
--   NOW() + INTERVAL '7 days'
-- );

-- Option 2: Create a test league first (uncomment if needed)
-- INSERT INTO leagues (id, name, creator_id, max_losses, visibility) 
-- VALUES (
--   gen_random_uuid(),
--   'Test League for Invitations',
--   (SELECT id FROM auth.users LIMIT 1),
--   3,
--   'private'
-- );

-- Then check if the insert worked
-- SELECT * FROM league_invitations WHERE "invitationCode" = 'TEST123';
