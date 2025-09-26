import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/pick.dart';

class PointsCalculationService {
  /// Calculate points for a pick - simply the score of the picked team
  /// ARI wins 24-20 → user gets 24 points
  /// GB wins 13-7 → user gets 13 points
  static int calculatePickPoints({
    required int homeScore,
    required int awayScore,
    required String pickedTeam,
    required String homeTeam,
    required String awayTeam,
  }) {
    // Return the score of the team the user picked
    if (pickedTeam == homeTeam) {
      return homeScore;
    } else if (pickedTeam == awayTeam) {
      return awayScore;
    } else {
      return 0; // Should not happen
    }
  }
  
  /// Update league member points after processing game results
  /// Only add points for winning picks (the score of the picked team)
  static Map<String, int> updateLeaguePoints({
    required Map<String, int> currentPoints,
    required List<Pick> picks,
    required int homeScore,
    required int awayScore,
    required String homeTeam,
    required String awayTeam,
  }) {
    final updatedPoints = Map<String, int>.from(currentPoints);
    
    for (final pick in picks) {
      // Only add points for winning picks
      if (pick.result == PickResult.WIN) {
        final points = calculatePickPoints(
          homeScore: homeScore,
          awayScore: awayScore,
          pickedTeam: pick.teamId,
          homeTeam: homeTeam,
          awayTeam: awayTeam,
        );
        
        updatedPoints[pick.userId] = (updatedPoints[pick.userId] ?? 0) + points;
      }
    }
    
    return updatedPoints;
  }
  
  /// Get league standings sorted by points (for tiebreaker)
  static List<Map<String, dynamic>> getLeagueStandingsByPoints({
    required League league,
    required Map<String, String> userDisplayNames,
  }) {
    final standings = <Map<String, dynamic>>[];
    
    for (final memberId in league.memberIds) {
      final points = league.memberPoints[memberId] ?? 0;
      final displayName = userDisplayNames[memberId] ?? 'Unknown User';
      
      standings.add({
        'userId': memberId,
        'displayName': displayName,
        'points': points,
      });
    }
    
    // Sort by points (descending), then by display name (ascending) for consistency
    standings.sort((a, b) {
      final pointsComparison = (b['points'] as int).compareTo(a['points'] as int);
      if (pointsComparison != 0) return pointsComparison;
      return (a['displayName'] as String).compareTo(b['displayName'] as String);
    });
    
    return standings;
  }
}
