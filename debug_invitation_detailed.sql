-- Detailed debug script to find the exact issue
-- Run this in Supabase SQL Editor

-- 1. Check current user ID
SELECT 'Current user ID:' as info, auth.uid() as user_id;

-- 2. Check if league exists
SELECT 'League info:' as info, id, name, owner_id, visibility 
FROM leagues 
WHERE id = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc';

-- 3. Check ALL invitations for this league (regardless of user)
SELECT 'All invitations for league:' as info,
       "invitationCode",
       "invitedByUserId", 
       "invitedUserId",
       status,
       "createdAt",
       "expiresAt",
       NOW() as current_time
FROM league_invitations 
WHERE "leagueId" = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc';

-- 4. Check invitation by code BM6GD5S2
SELECT 'Invitation by code BM6GD5S2:' as info,
       "invitationCode",
       "leagueId",
       "invitedByUserId", 
       "invitedUserId",
       status,
       "createdAt",
       "expiresAt",
       NOW() as current_time,
       ("expiresAt" > NOW()) as is_not_expired
FROM league_invitations 
WHERE "invitationCode" = 'BM6GD5S2';

-- 5. Check if current user has ANY invitations
SELECT 'Current user invitations:' as info,
       "invitationCode",
       "leagueId",
       "invitedByUserId",
       "invitedUserId",
       status,
       "expiresAt"
FROM league_invitations 
WHERE "invitedUserId" = auth.uid() OR "invitedByUserId" = auth.uid();

-- 6. Test each part of the RLS policy
SELECT 'RLS policy breakdown:' as info,
       -- Check if invitation exists for this league and current user
       EXISTS (
           SELECT 1 FROM league_invitations li
           WHERE li."leagueId" = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc'
           AND li."invitedUserId" = auth.uid()
       ) as has_invitation_as_invited_user,
       
       -- Check if invitation exists for this league and current user as inviter
       EXISTS (
           SELECT 1 FROM league_invitations li
           WHERE li."leagueId" = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc'
           AND li."invitedByUserId" = auth.uid()
       ) as has_invitation_as_inviter,
       
       -- Check if user is owner of the league
       EXISTS (
           SELECT 1 FROM leagues l
           WHERE l.id = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc'
           AND l.owner_id = auth.uid()
       ) as is_league_owner,
       
       -- Check if user is member of the league
       EXISTS (
           SELECT 1 FROM league_members lm
           WHERE lm.league_id = '4a0406f6-aaeb-4af4-a0aa-bcbc6f9cc2bc'
           AND lm.user_id = auth.uid()
       ) as is_league_member;
