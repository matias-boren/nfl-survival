import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class DeadlineService {
  // Computes the pick deadline for a given week and season
  Future<DateTime> getPickDeadline(int season, int week) async {
    // Mock implementation - in real app, this would fetch from NFL API
    return DateTime.now().add(const Duration(days: 7));
  }

  // Checks if the pick is locked for a given week and season
  Future<bool> isPickLocked(int season, int week) async {
    final deadline = await getPickDeadline(season, week);
    return DateTime.now().toUtc().isAfter(deadline);
  }

  // Formats a UTC DateTime to local time in a readable format
  String formatUtcToLocal(String utcIsoString) {
    final dateTime = DateTime.parse(utcIsoString).toLocal();
    final formatter = DateFormat('EEE, MMM d, h:mm a', dotenv.env['DEFAULT_LOCALE'] ?? 'en_US');
    return formatter.format(dateTime);
  }
}
