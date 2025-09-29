-- Populate user_profiles table with existing auth users
-- This script creates user profiles for all users in the auth.users table

INSERT INTO user_profiles (user_id, display_name, favorite_team, is_premium, created_at)
SELECT 
    au.id as user_id,
    COALESCE(au.raw_user_meta_data->>'full_name', SPLIT_PART(au.email, '@', 1)) as display_name,
    'DAL' as favorite_team, -- Default favorite team
    false as is_premium, -- Default to freemium
    NOW() as created_at
FROM auth.users au
LEFT JOIN user_profiles up ON au.id = up.user_id
WHERE up.user_id IS NULL -- Only insert if user profile doesn't exist
AND au.email_confirmed_at IS NOT NULL; -- Only confirmed users

-- Show the results
SELECT 
    up.user_id,
    up.display_name,
    up.favorite_team,
    up.is_premium,
    au.email,
    au.email_confirmed_at
FROM user_profiles up
JOIN auth.users au ON up.user_id = au.id
ORDER BY up.created_at DESC;
