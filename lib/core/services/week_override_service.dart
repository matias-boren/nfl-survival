import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeekOverrideService {
  static int? _overrideWeek;
  
  /// Override the current week for testing purposes
  static void setOverrideWeek(int week) {
    _overrideWeek = week;
  }
  
  /// Clear the week override
  static void clearOverride() {
    _overrideWeek = null;
  }
  
  /// Get the current week, considering any override
  static int getCurrentWeek(int calculatedWeek) {
    return _overrideWeek ?? calculatedWeek;
  }
  
  /// Check if there's an active override
  static bool hasOverride() {
    return _overrideWeek != null;
  }
  
  /// Get the override week value
  static int? getOverrideWeek() {
    return _overrideWeek;
  }
}

/// Provider for the current week with override support
final currentWeekProvider = Provider<int>((ref) {
  // This would normally calculate the current week
  // For now, we'll use a simple calculation
  final now = DateTime.now();
  final seasonStart = DateTime(now.year, 9, 1); // Approximate season start
  final daysSinceStart = now.difference(seasonStart).inDays;
  final calculatedWeek = (daysSinceStart / 7).floor() + 1;
  
  return WeekOverrideService.getCurrentWeek(calculatedWeek.clamp(1, 18));
});
