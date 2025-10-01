-- Implement multi-use invitations system
-- This allows multiple users to accept the same invitation code

-- 1. Update the league_invitations table to support multi-use
-- Remove the single-use constraints and add join tracking

-- First, let's see what columns we currently have
-- (This is just for reference - we'll keep the existing structure)

-- 2. Create a new table to track invitation acceptances
-- This will track who accepted which invitation and when
CREATE TABLE IF NOT EXISTS invitation_acceptances (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    invitation_id UUID NOT NULL REFERENCES league_invitations(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    accepted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(invitation_id, user_id) -- Prevent duplicate acceptances
);

-- 3. Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_invitation_acceptances_invitation_id 
ON invitation_acceptances(invitation_id);

CREATE INDEX IF NOT EXISTS idx_invitation_acceptances_user_id 
ON invitation_acceptances(user_id);

-- 4. Create RLS policies for the new table
ALTER TABLE invitation_acceptances ENABLE ROW LEVEL SECURITY;

-- Users can view their own acceptances
CREATE POLICY "Users can view their own acceptances" ON invitation_acceptances
    FOR SELECT
    USING (user_id = auth.uid());

-- Users can create acceptances (when they accept an invitation)
CREATE POLICY "Users can create acceptances" ON invitation_acceptances
    FOR INSERT
    WITH CHECK (user_id = auth.uid());

-- League owners can view all acceptances for their invitations
CREATE POLICY "League owners can view acceptances" ON invitation_acceptances
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_invitations li
            JOIN leagues l ON l.id = li."leagueId"
            WHERE li.id = invitation_acceptances.invitation_id
            AND l.owner_id = auth.uid()
        )
    );

-- 5. Create a function to get invitation acceptance count
CREATE OR REPLACE FUNCTION get_invitation_acceptance_count(invitation_uuid UUID)
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM invitation_acceptances ia
        WHERE ia.invitation_id = invitation_uuid
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. Create a function to check if user has already accepted an invitation
CREATE OR REPLACE FUNCTION user_has_accepted_invitation(invitation_uuid UUID, user_uuid UUID)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM invitation_acceptances ia
        WHERE ia.invitation_id = invitation_uuid
        AND ia.user_id = user_uuid
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Create a function to accept an invitation (multi-use)
CREATE OR REPLACE FUNCTION accept_invitation_multi_use(
    invitation_code TEXT,
    user_uuid UUID
)
RETURNS JSON AS $$
DECLARE
    invitation_record league_invitations%ROWTYPE;
    league_record leagues%ROWTYPE;
    acceptance_count INTEGER;
    already_accepted BOOLEAN;
BEGIN
    -- Get the invitation
    SELECT * INTO invitation_record
    FROM league_invitations
    WHERE "invitationCode" = invitation_code
    AND status = 'pending'
    AND "expiresAt" > NOW();
    
    -- Check if invitation exists and is valid
    IF NOT FOUND THEN
        RETURN json_build_object(
            'success', false,
            'error', 'Invalid or expired invitation code'
        );
    END IF;
    
    -- Check if user has already accepted this invitation
    SELECT user_has_accepted_invitation(invitation_record.id, user_uuid) INTO already_accepted;
    
    IF already_accepted THEN
        RETURN json_build_object(
            'success', false,
            'error', 'You have already accepted this invitation'
        );
    END IF;
    
    -- Get the league
    SELECT * INTO league_record
    FROM leagues
    WHERE id = invitation_record."leagueId";
    
    -- Add user to league_members if not already a member
    INSERT INTO league_members (league_id, user_id, losses, joined_at)
    VALUES (league_record.id, user_uuid, 0, NOW())
    ON CONFLICT (league_id, user_id) DO NOTHING;
    
    -- Record the acceptance
    INSERT INTO invitation_acceptances (invitation_id, user_id)
    VALUES (invitation_record.id, user_uuid);
    
    -- Get the new acceptance count
    SELECT get_invitation_acceptance_count(invitation_record.id) INTO acceptance_count;
    
    RETURN json_build_object(
        'success', true,
        'league_id', league_record.id,
        'league_name', league_record.name,
        'acceptance_count', acceptance_count
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
