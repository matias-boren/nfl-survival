import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get env => dotenv.maybeGet('ENV') ?? 'dev';
  static String get defaultTimezone =>
      dotenv.maybeGet('DEFAULT_TIMEZONE') ?? 'Europe/Helsinki';
}
