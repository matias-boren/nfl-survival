-- Fix RLS policy to allow users to view leagues when they have a valid invitation
-- This solves the 406 error when accepting invitations

-- Add a new policy that allows users to view leagues if they have a pending invitation
CREATE POLICY "Users can view leagues with pending invitations" ON leagues
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_invitations li
            WHERE li."leagueId" = leagues.id
            AND li."invitedUserId" = auth.uid()
            AND li.status = 'pending'
            AND li."expiresAt" > NOW()
        )
    );

-- Also allow users to view leagues if they have any invitation (sent or received)
-- This covers cases where the invitation might be in a different state
CREATE POLICY "Users can view leagues with any invitation" ON leagues
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_invitations li
            WHERE li."leagueId" = leagues.id
            AND (li."invitedUserId" = auth.uid() OR li."invitedByUserId" = auth.uid())
        )
    );
