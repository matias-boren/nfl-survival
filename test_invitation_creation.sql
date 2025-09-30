-- Test script to manually insert an invitation and see what happens
-- Run this in Supabase SQL Editor to test if the table structure is correct

INSERT INTO league_invitations (
  "leagueId",
  "invitedByUserId", 
  "invitationCode",
  status,
  "createdAt",
  "expiresAt"
) VALUES (
  '00000000-0000-0000-0000-000000000000', -- dummy league ID
  '00000000-0000-0000-0000-000000000000', -- dummy user ID
  'TEST123',
  'pending',
  NOW(),
  NOW() + INTERVAL '7 days'
);

-- Check if the insert worked
SELECT * FROM league_invitations WHERE "invitationCode" = 'TEST123';
