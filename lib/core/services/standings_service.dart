import 'package:nfl_survival/data/models/pick.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';
import 'package:nfl_survival/data/users/user_repositories.dart';

class StandingsService {
  final PicksRepository _picksRepository;
  final UserRepository _userRepository;

  StandingsService({
    required PicksRepository picksRepository,
    required UserRepository userRepository,
  }) : _picksRepository = picksRepository,
       _userRepository = userRepository;

  /// Calculate standings for a specific league
  Future<List<LeagueStanding>> calculateLeagueStandings({
    required String leagueId,
    required League league,
  }) async {
    print('Calculating standings for league $leagueId');

    // Get all picks for this league
    final allPicks = await _picksRepository.getLeaguePicks(leagueId);
    print('Found ${allPicks.length} total picks for league');

    // Group picks by user
    final userPicks = <String, List<Pick>>{};
    for (final pick in allPicks) {
      userPicks.putIfAbsent(pick.userId, () => []).add(pick);
    }

    print('Found ${userPicks.length} users with picks');

    // Calculate standings for each user
    final standings = <LeagueStanding>[];

    for (final userId in userPicks.keys) {
      try {
        final user = await _userRepository.getUserById(userId);
        if (user == null) continue;

        final userPickList = userPicks[userId]!;
        final standing = await _calculateUserStanding(
          userId: userId,
          displayName: user.displayName,
          picks: userPickList,
          league: league,
        );

        standings.add(standing);
      } catch (e) {
        print('Error calculating standing for user $userId: $e');
      }
    }

    // Sort standings based on league rules (points-based tiebreaker)
    _sortStandings(standings, league);

    return standings;
  }

  Future<LeagueStanding> _calculateUserStanding({
    required String userId,
    required String displayName,
    required List<Pick> picks,
    required League league,
  }) async {
    // Sort picks by week
    picks.sort((a, b) => a.week.compareTo(b.week));

    // Calculate wins and losses
    int wins = 0;
    int losses = 0;
    final usedTeams = <String>[];
    String? lastPickTeam;
    PickResult? lastPickResult;

    for (final pick in picks) {
      if (pick.result == PickResult.WIN) {
        wins++;
        usedTeams.add(pick.teamId);
      } else if (pick.result == PickResult.LOSE) {
        losses++;
        usedTeams.add(pick.teamId);
      }

      // Track last pick
      if (pick.week == picks.last.week) {
        lastPickTeam = pick.teamId;
        lastPickResult = pick.result;
      }
    }

    // Check if user is eliminated
    final isEliminated = _isUserEliminated(
      losses: losses,
      league: league,
      picks: picks,
    );

    // Get user's points from league
    final points = league.memberPoints[userId] ?? 0;

    return LeagueStanding(
      userId: userId,
      displayName: displayName,
      wins: wins,
      losses: losses,
      usedTeams: usedTeams,
      lastPickTeam: lastPickTeam,
      lastPickResult: lastPickResult,
      isEliminated: isEliminated,
      currentStreak: _calculateCurrentStreak(picks),
      longestStreak: _calculateLongestStreak(picks),
      points: points,
    );
  }

  bool _isUserEliminated({
    required int losses,
    required League league,
    required List<Pick> picks,
  }) {
    // Check max losses rule
    if (losses > league.settings.maxLosses) {
      return true;
    }

    // Check auto-eliminate on no pick rule
    if (league.settings.autoEliminateOnNoPick) {
      // Check if user missed any required picks
      final currentWeek = _getCurrentWeek();
      for (int week = 1; week <= currentWeek; week++) {
        final hasPick = picks.any((pick) => pick.week == week);
        if (!hasPick) {
          return true;
        }
      }
    }

    return false;
  }

  int _calculateCurrentStreak(List<Pick> picks) {
    if (picks.isEmpty) return 0;

    // Sort by week descending to get most recent first
    final sortedPicks = List<Pick>.from(picks)
      ..sort((a, b) => b.week.compareTo(a.week));

    int streak = 0;
    for (final pick in sortedPicks) {
      if (pick.result == PickResult.WIN) {
        streak++;
      } else if (pick.result == PickResult.LOSE) {
        break;
      }
    }

    return streak;
  }

  int _calculateLongestStreak(List<Pick> picks) {
    if (picks.isEmpty) return 0;

    // Sort by week ascending
    final sortedPicks = List<Pick>.from(picks)
      ..sort((a, b) => a.week.compareTo(b.week));

    int longestStreak = 0;
    int currentStreak = 0;

    for (final pick in sortedPicks) {
      if (pick.result == PickResult.WIN) {
        currentStreak++;
        longestStreak = currentStreak > longestStreak
            ? currentStreak
            : longestStreak;
      } else if (pick.result == PickResult.LOSE) {
        currentStreak = 0;
      }
    }

    return longestStreak;
  }

  void _sortStandings(List<LeagueStanding> standings, League league) {
    standings.sort((a, b) {
      // First, sort by elimination status (non-eliminated first)
      if (a.isEliminated != b.isEliminated) {
        return a.isEliminated ? 1 : -1;
      }

      // Then by wins (descending)
      if (a.wins != b.wins) {
        return b.wins.compareTo(a.wins);
      }

      // Then by win percentage
      final aWinPercentage = a.totalPicks > 0 ? a.wins / a.totalPicks : 0.0;
      final bWinPercentage = b.totalPicks > 0 ? b.wins / b.totalPicks : 0.0;
      if (aWinPercentage != bWinPercentage) {
        return bWinPercentage.compareTo(aWinPercentage);
      }

      // Points-based tiebreaker (new system)
      final aPoints = league.memberPoints[a.userId] ?? 0;
      final bPoints = league.memberPoints[b.userId] ?? 0;
      if (aPoints != bPoints) {
        return bPoints.compareTo(aPoints);
      }

      // Final tiebreaker: longest streak
      if (a.longestStreak != b.longestStreak) {
        return b.longestStreak.compareTo(a.longestStreak);
      }

      // Ultimate tiebreaker: alphabetical by display name
      return a.displayName.compareTo(b.displayName);
    });
  }

  int _getCurrentWeek() {
    // This should match the current week logic from DeadlineService
    final now = DateTime.now();
    final seasonStart = DateTime(2025, 9, 4); // NFL 2025 season start
    final daysSinceStart = now.difference(seasonStart).inDays;
    return (daysSinceStart / 7).floor() + 1;
  }
}

class LeagueStanding {
  final String userId;
  final String displayName;
  final int wins;
  final int losses;
  final List<String> usedTeams;
  final String? lastPickTeam;
  final PickResult? lastPickResult;
  final bool isEliminated;
  final int currentStreak;
  final int longestStreak;
  final int points;

  LeagueStanding({
    required this.userId,
    required this.displayName,
    required this.wins,
    required this.losses,
    required this.usedTeams,
    this.lastPickTeam,
    this.lastPickResult,
    required this.isEliminated,
    required this.currentStreak,
    required this.longestStreak,
    required this.points,
  });

  int get totalPicks => wins + losses;
  double get winPercentage => totalPicks > 0 ? wins / totalPicks : 0.0;
}
