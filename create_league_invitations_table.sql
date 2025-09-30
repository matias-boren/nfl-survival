-- Create league_invitations table
CREATE TABLE IF NOT EXISTS league_invitations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  "leagueId" UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  "invitedByUserId" UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  "invitedUserEmail" TEXT,
  "invitedUserId" UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  "invitationCode" TEXT NOT NULL UNIQUE,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined', 'expired')),
  "createdAt" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "expiresAt" TIMESTAMP WITH TIME ZONE,
  "acceptedAt" TIMESTAMP WITH TIME ZONE,
  "declinedAt" TIMESTAMP WITH TIME ZONE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_league_invitations_league_id ON league_invitations("leagueId");
CREATE INDEX IF NOT EXISTS idx_league_invitations_invitation_code ON league_invitations("invitationCode");
CREATE INDEX IF NOT EXISTS idx_league_invitations_invited_by_user_id ON league_invitations("invitedByUserId");
CREATE INDEX IF NOT EXISTS idx_league_invitations_invited_user_id ON league_invitations("invitedUserId");
CREATE INDEX IF NOT EXISTS idx_league_invitations_status ON league_invitations(status);

-- Enable RLS
ALTER TABLE league_invitations ENABLE ROW LEVEL SECURITY;

-- RLS Policies for league_invitations
-- Users can read invitations for leagues they belong to
CREATE POLICY "Users can read invitations for leagues they belong to" ON league_invitations
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = league_invitations."leagueId"
            AND lm.user_id = auth.uid()
        )
    );

-- Users can create invitations for leagues they own
CREATE POLICY "Users can create invitations for leagues they own" ON league_invitations
    FOR INSERT
    WITH CHECK (
        "invitedByUserId" = auth.uid()
        AND EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_invitations."leagueId"
            AND l.owner_id = auth.uid()
        )
    );

-- Users can update invitations they created or were invited to
CREATE POLICY "Users can update invitations they created or were invited to" ON league_invitations
    FOR UPDATE
    USING (
        "invitedByUserId" = auth.uid()
        OR "invitedUserId" = auth.uid()
    )
    WITH CHECK (
        "invitedByUserId" = auth.uid()
        OR "invitedUserId" = auth.uid()
    );

-- Users can delete invitations they created
CREATE POLICY "Users can delete invitations they created" ON league_invitations
    FOR DELETE
    USING ("invitedByUserId" = auth.uid());

-- Grant permissions
GRANT ALL ON league_invitations TO authenticated;
GRANT ALL ON league_invitations TO anon;
