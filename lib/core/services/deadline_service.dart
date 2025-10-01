import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeadlineService {
  static final DeadlineService _instance = DeadlineService._internal();
  factory DeadlineService() => _instance;
  DeadlineService._internal();

  Timer? _refreshTimer;
  final StreamController<int> _weekController =
      StreamController<int>.broadcast();
  final http.Client _client = http.Client();
  int? _cachedWeek;

  Stream<int> get weekStream => _weekController.stream;

  void startAutoRefresh() {
    // Initialize week immediately
    _checkForNewWeek();
    
    // Refresh every 5 minutes to check for new weeks
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _checkForNewWeek();
    });
  }

  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  void _checkForNewWeek() async {
    try {
      // Get current week from ESPN API
      final currentWeek = await _getCurrentWeekFromEspn();
      if (currentWeek != null && currentWeek != _cachedWeek) {
        _cachedWeek = currentWeek;
        _weekController.add(currentWeek);
        print('📅 Week updated to: $currentWeek');
      }
    } catch (e) {
      print('❌ Error getting current week from ESPN: $e');
      // Fallback to calculated week
      final fallbackWeek = getCurrentWeek();
      _weekController.add(fallbackWeek);
    }
  }

  /// Get current week from ESPN API
  Future<int?> _getCurrentWeekFromEspn() async {
    try {
      final response = await _client.get(
        Uri.parse('https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final week = data['week']?['number'];
        print('📅 ESPN API returned week: $week');
        return week;
      } else {
        print('❌ ESPN API returned status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching week from ESPN API: $e');
      return null;
    }
  }

  int getCurrentWeek() {
    // Return cached week if available, otherwise calculate
    if (_cachedWeek != null) {
      return _cachedWeek!;
    }
    
    // Simple week calculation - fallback only
    final now = DateTime.now();
    final seasonStart = DateTime(now.year, 9, 1); // Approximate season start
    final daysSinceStart = now.difference(seasonStart).inDays;
    final calculatedWeek = (daysSinceStart / 7).floor() + 1;
    final week = calculatedWeek.clamp(1, 18); // NFL regular season is 18 weeks
    
    return week;
  }

  DateTime? getPickDeadline(int week) {
    final now = DateTime.now();
    final currentWeek = getCurrentWeek();
    print('getPickDeadline: week=$week, currentWeek=$currentWeek, now=$now');

    if (week < currentWeek) {
      print('Week $week is before current week $currentWeek, returning null');
      return null; // Week has already passed
    }

    // For current week and future weeks, we need to get the first game's kickoff time
    // This will be handled by the NFL repository in the pickLockedProvider
    return null; // This will be overridden by the NFL repository
  }

  bool isPickDeadlinePassed(int week) {
    final deadline = getPickDeadline(week);
    print(
      'isPickDeadlinePassed: week=$week, deadline=$deadline, now=${DateTime.now()}',
    );
    if (deadline == null) {
      print('Deadline is null, returning true');
      return true;
    }
    final isPassed = DateTime.now().isAfter(deadline);
    print('Deadline passed: $isPassed');
    return isPassed;
  }

  String formatUtcToLocal(String utcString) {
    try {
      final utc = DateTime.parse(utcString);
      final local = utc.toLocal();
      return '${local.month}/${local.day} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return utcString;
    }
  }

  String getDeadlineStatus(int week) {
    final deadline = getPickDeadline(week);
    if (deadline == null) return 'Week has passed';

    final now = DateTime.now();
    final timeLeft = deadline.difference(now);

    if (timeLeft.isNegative) {
      return 'Deadline passed';
    }

    final days = timeLeft.inDays;
    final hours = timeLeft.inHours % 24;
    final minutes = timeLeft.inMinutes % 60;

    if (days > 0) {
      return '$days days, $hours hours left';
    } else if (hours > 0) {
      return '$hours hours, $minutes minutes left';
    } else {
      return '$minutes minutes left';
    }
  }

  String getTimeUntilKickoff(DateTime gameTime) {
    final now = DateTime.now();
    final difference = gameTime.difference(now);

    if (difference.isNegative) {
      return 'Game started';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m until kickoff';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m until kickoff';
    } else {
      return '${minutes}m until kickoff';
    }
  }

  // Check if we should auto-advance to next week
  bool shouldAdvanceToNextWeek() {
    final now = DateTime.now();
    final currentWeek = getCurrentWeek();

    // Check if all games for current week are finalized
    // This would typically check with the NFL API to see if all games are complete
    // For now, we'll use a simple time-based check
    final weekEnd = DateTime(
      2025,
      9,
      3,
    ).add(Duration(days: (currentWeek * 7) + 1)); // Tuesday of next week
    return now.isAfter(weekEnd);
  }

  // Get the next week number
  int getNextWeek() {
    final currentWeek = getCurrentWeek();
    return currentWeek + 1;
  }

  void dispose() {
    _refreshTimer?.cancel();
    _weekController.close();
  }
}

final deadlineServiceProvider = Provider<DeadlineService>((ref) {
  final service = DeadlineService();
  service.startAutoRefresh();
  ref.onDispose(() => service.dispose());
  return service;
});
