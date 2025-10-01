-- Debug script to check invitation and league data
-- Run this in Supabase SQL Editor to diagnose the issue

-- 1. Check if the league exists
SELECT 'League exists:' as check_type, id, name, owner_id, visibility 
FROM leagues 
WHERE id = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc';

-- 2. Check all invitations for this league
SELECT 'Invitations for league:' as check_type, 
       "invitationCode", 
       "invitedByUserId", 
       "invitedUserId", 
       status, 
       "createdAt", 
       "expiresAt"
FROM league_invitations 
WHERE "leagueId" = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc';

-- 3. Check if there are any invitations with the code BM6GD5S2
SELECT 'Invitation by code:' as check_type,
       "invitationCode",
       "leagueId",
       "invitedByUserId", 
       "invitedUserId",
       status,
       "expiresAt"
FROM league_invitations 
WHERE "invitationCode" = 'BM6GD5S2';

-- 4. Check what user is currently authenticated (this will show the current user's ID)
SELECT 'Current user:' as check_type, auth.uid() as current_user_id;

-- 5. Check if the current user has any invitations
SELECT 'User invitations:' as check_type,
       "invitationCode",
       "leagueId",
       status,
       "expiresAt"
FROM league_invitations 
WHERE "invitedUserId" = auth.uid() OR "invitedByUserId" = auth.uid();

-- 6. Test the RLS policy directly
SELECT 'RLS test - can user see league:' as check_type,
       EXISTS (
           SELECT 1 FROM league_invitations li
           WHERE li."leagueId" = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc'
           AND (li."invitedUserId" = auth.uid() OR li."invitedByUserId" = auth.uid())
       ) as can_see_league;
