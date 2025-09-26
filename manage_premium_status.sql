-- SQL script to manage premium status in Supabase
-- Run these queries in the Supabase SQL Editor

-- 1. View all users and their premium status
SELECT 
  u.email,
  up.display_name,
  up.favorite_team,
  up.is_premium,
  up.created_at
FROM auth.users u
LEFT JOIN user_profiles up ON u.id = up.user_id
ORDER BY up.created_at DESC;

-- 2. Make a specific user premium (replace 'user@example.com' with actual email)
UPDATE user_profiles 
SET is_premium = true, updated_at = NOW()
WHERE user_id = (
  SELECT id FROM auth.users WHERE email = 'user@example.com'
);

-- 3. Make a specific user freemium (replace 'user@example.com' with actual email)
UPDATE user_profiles 
SET is_premium = false, updated_at = NOW()
WHERE user_id = (
  SELECT id FROM auth.users WHERE email = 'user@example.com'
);

-- 4. Make all users premium (use with caution!)
UPDATE user_profiles 
SET is_premium = true, updated_at = NOW();

-- 5. Make all users freemium (use with caution!)
UPDATE user_profiles 
SET is_premium = false, updated_at = NOW();

-- 6. Create user profile for existing users who don't have one
INSERT INTO user_profiles (user_id, display_name, is_premium, created_at, updated_at)
SELECT 
  u.id,
  COALESCE(u.raw_user_meta_data->>'full_name', split_part(u.email, '@', 1)) as display_name,
  false as is_premium,
  NOW() as created_at,
  NOW() as updated_at
FROM auth.users u
LEFT JOIN user_profiles up ON u.id = up.user_id
WHERE up.user_id IS NULL;
