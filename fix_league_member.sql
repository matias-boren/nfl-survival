INSERT INTO league_members (league_id, user_id) VALUES ('b2d97471-b3f9-4116-b00b-715eab2faabd', 'c3356d0a-b713-4a15-ac52-ba0d6309f25e') ON CONFLICT (league_id, user_id) DO NOTHING;
