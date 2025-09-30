-- Create league_invitations table
CREATE TABLE IF NOT EXISTS league_invitations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  invited_by_user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  invited_user_email TEXT,
  invited_user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  invitation_code TEXT NOT NULL UNIQUE,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined', 'expired')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE,
  accepted_at TIMESTAMP WITH TIME ZONE,
  declined_at TIMESTAMP WITH TIME ZONE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_league_invitations_league_id ON league_invitations(league_id);
CREATE INDEX IF NOT EXISTS idx_league_invitations_invitation_code ON league_invitations(invitation_code);
CREATE INDEX IF NOT EXISTS idx_league_invitations_invited_by_user_id ON league_invitations(invited_by_user_id);
CREATE INDEX IF NOT EXISTS idx_league_invitations_invited_user_id ON league_invitations(invited_user_id);
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
            WHERE lm.league_id = league_invitations.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- Users can create invitations for leagues they own
CREATE POLICY "Users can create invitations for leagues they own" ON league_invitations
    FOR INSERT
    WITH CHECK (
        invited_by_user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_invitations.league_id
            AND l.owner_id = auth.uid()
        )
    );

-- Users can update invitations they created or were invited to
CREATE POLICY "Users can update invitations they created or were invited to" ON league_invitations
    FOR UPDATE
    USING (
        invited_by_user_id = auth.uid()
        OR invited_user_id = auth.uid()
    )
    WITH CHECK (
        invited_by_user_id = auth.uid()
        OR invited_user_id = auth.uid()
    );

-- Users can delete invitations they created
CREATE POLICY "Users can delete invitations they created" ON league_invitations
    FOR DELETE
    USING (invited_by_user_id = auth.uid());

-- Grant permissions
GRANT ALL ON league_invitations TO authenticated;
GRANT ALL ON league_invitations TO anon;
