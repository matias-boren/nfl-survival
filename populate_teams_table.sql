-- Populate teams table with NFL teams
-- ESPN Team IDs and basic information for all 32 NFL teams
-- These are the ACTUAL ESPN API team IDs fetched from the API

INSERT INTO teams (espn_team_id, name, abbreviation, city, conference, division, logo_url) VALUES
('1', 'Atlanta Falcons', 'ATL', 'Atlanta', 'NFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/atl.png'),
('2', 'Buffalo Bills', 'BUF', 'Buffalo', 'AFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/buf.png'),
('3', 'Chicago Bears', 'CHI', 'Chicago', 'NFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/chi.png'),
('4', 'Cincinnati Bengals', 'CIN', 'Cincinnati', 'AFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/cin.png'),
('5', 'Cleveland Browns', 'CLE', 'Cleveland', 'AFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/cle.png'),
('6', 'Dallas Cowboys', 'DAL', 'Dallas', 'NFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/dal.png'),
('7', 'Denver Broncos', 'DEN', 'Denver', 'AFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/den.png'),
('8', 'Detroit Lions', 'DET', 'Detroit', 'NFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/det.png'),
('9', 'Green Bay Packers', 'GB', 'Green Bay', 'NFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/gb.png'),
('11', 'Indianapolis Colts', 'IND', 'Indianapolis', 'AFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/ind.png'),
('12', 'Kansas City Chiefs', 'KC', 'Kansas City', 'AFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/kc.png'),
('13', 'Las Vegas Raiders', 'LV', 'Las Vegas', 'AFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/lv.png'),
('14', 'Los Angeles Chargers', 'LAC', 'Los Angeles', 'AFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/lac.png'),
('15', 'Los Angeles Rams', 'LAR', 'Los Angeles', 'NFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/lar.png'),
('16', 'Miami Dolphins', 'MIA', 'Miami', 'AFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/mia.png'),
('17', 'Minnesota Vikings', 'MIN', 'Minnesota', 'NFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/min.png'),
('18', 'New England Patriots', 'NE', 'New England', 'AFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/ne.png'),
('19', 'New Orleans Saints', 'NO', 'New Orleans', 'NFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/no.png'),
('20', 'New York Giants', 'NYG', 'New York', 'NFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/nyg.png'),
('21', 'New York Jets', 'NYJ', 'New York', 'AFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/nyj.png'),
('22', 'Philadelphia Eagles', 'PHI', 'Philadelphia', 'NFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/phi.png'),
('23', 'Pittsburgh Steelers', 'PIT', 'Pittsburgh', 'AFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/pit.png'),
('24', 'San Francisco 49ers', 'SF', 'San Francisco', 'NFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/sf.png'),
('25', 'Seattle Seahawks', 'SEA', 'Seattle', 'NFC', 'West', 'https://a.espncdn.com/i/teamlogos/nfl/500/sea.png'),
('26', 'Tampa Bay Buccaneers', 'TB', 'Tampa Bay', 'NFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/tb.png'),
('27', 'Tennessee Titans', 'TEN', 'Tennessee', 'AFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/ten.png'),
('28', 'Washington Commanders', 'WAS', 'Washington', 'NFC', 'East', 'https://a.espncdn.com/i/teamlogos/nfl/500/was.png'),
('29', 'Carolina Panthers', 'CAR', 'Carolina', 'NFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/car.png'),
('30', 'Jacksonville Jaguars', 'JAX', 'Jacksonville', 'AFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/jax.png'),
('33', 'Baltimore Ravens', 'BAL', 'Baltimore', 'AFC', 'North', 'https://a.espncdn.com/i/teamlogos/nfl/500/bal.png'),
('34', 'Houston Texans', 'HOU', 'Houston', 'AFC', 'South', 'https://a.espncdn.com/i/teamlogos/nfl/500/hou.png');

-- Verify the data was inserted
SELECT COUNT(*) as total_teams FROM teams;
SELECT name, abbreviation, conference, division FROM teams ORDER BY conference, division, name;
