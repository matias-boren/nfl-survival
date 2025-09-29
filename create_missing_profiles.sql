-- Function to create missing user profiles for existing users
-- This can be run manually if needed

CREATE OR REPLACE FUNCTION create_missing_user_profiles()
RETURNS TABLE(
  user_id uuid,
  email text,
  display_name text,
  created boolean
) AS $$
BEGIN
  RETURN QUERY
  INSERT INTO public.user_profiles (user_id, display_name, favorite_team, is_premium, created_at)
  SELECT 
    au.id as user_id,
    COALESCE(au.raw_user_meta_data->>'full_name', SPLIT_PART(au.email, '@', 1)) as display_name,
    'DAL' as favorite_team,
    false as is_premium,
    NOW() as created_at
  FROM auth.users au
  LEFT JOIN user_profiles up ON au.id = up.user_id
  WHERE up.user_id IS NULL
  AND au.email_confirmed_at IS NOT NULL
  ON CONFLICT (user_id) DO NOTHING
  RETURNING 
    user_profiles.user_id,
    (SELECT email FROM auth.users WHERE id = user_profiles.user_id),
    user_profiles.display_name,
    true as created;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION create_missing_user_profiles() TO authenticated, service_role;

-- Run the function to create any missing profiles
SELECT * FROM create_missing_user_profiles();
