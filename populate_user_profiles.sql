-- Populate user_profiles table with existing users from auth.users
-- This script will create user profiles for all existing authenticated users

-- Insert user profiles for all existing users in auth.users
INSERT INTO user_profiles (user_id, display_name, is_premium, favorite_team, created_at, updated_at)
SELECT 
  u.id as user_id,
  COALESCE(u.raw_user_meta_data->>'display_name', 
           COALESCE(u.raw_user_meta_data->>'full_name', 
                   SPLIT_PART(u.email, '@', 1))) as display_name,
  COALESCE((u.raw_user_meta_data->>'is_premium')::boolean, false) as is_premium,
  COALESCE(u.raw_user_meta_data->>'favorite_team', '') as favorite_team,
  u.created_at,
  NOW() as updated_at
FROM auth.users u
WHERE u.id NOT IN (SELECT user_id FROM user_profiles)
  AND u.email IS NOT NULL;

-- Show the results
SELECT 
  up.user_id,
  up.display_name,
  up.is_premium,
  up.favorite_team,
  u.email
FROM user_profiles up
JOIN auth.users u ON up.user_id = u.id
ORDER BY up.created_at;
