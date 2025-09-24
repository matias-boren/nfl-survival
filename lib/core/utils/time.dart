import 'package:intl/intl.dart';

class TimeUtils {
  static DateTime parseUtc(String iso) => DateTime.parse(iso).toUtc();
  static String formatLocal(String iso) {
    final dt = parseUtc(iso).toLocal();
    return DateFormat.yMMMd().add_Hm().format(dt);
  }
}

class DeadlineService {
  Future<DateTime> weekDeadlineUtc({required List<DateTime> weekStartTimesUtc}) async {
    weekStartTimesUtc.sort();
    final earliest = weekStartTimesUtc.first;
    return earliest.subtract(const Duration(minutes: 5));
  }

  bool isLocked({required DateTime nowUtc, required DateTime deadlineUtc}) {
    return nowUtc.isAfter(deadlineUtc);
  }
}

