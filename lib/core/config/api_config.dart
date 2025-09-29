/// Configuration for API usage patterns
class ApiConfig {
  // API Usage Modes
  static const bool USE_SERVER_SYNC =
      true; // Set to true to use server sync (PRODUCTION)
  static const bool USE_DIRECT_ESPN =
      false; // Set to false when using server sync

  // Server Configuration (when using server sync)
  static const String SERVER_BASE_URL =
      'https://nfl-survival-production.up.railway.app/api';

  // ESPN Direct Configuration (when using direct ESPN)
  static const int ESPN_POLLING_INTERVAL_SECONDS = 15;
  static const int ESPN_RATE_LIMIT_REQUESTS_PER_MINUTE = 4;

  // Caching Configuration
  static const int CACHE_DURATION_SECONDS = 15;
  static const bool ENABLE_CACHING = true;

  // Rate Limiting Configuration
  static const int MAX_REQUESTS_PER_USER_PER_MINUTE = 4;
  static const int MAX_CONCURRENT_USERS = 1000;

  /// Get the appropriate polling interval based on mode
  static Duration getPollingInterval() {
    if (USE_SERVER_SYNC) {
      return const Duration(seconds: 15); // Poll our server every 15 seconds
    } else {
      return const Duration(seconds: 15); // Poll ESPN directly every 15 seconds
    }
  }

  /// Check if we should use server sync
  static bool shouldUseServerSync() {
    return USE_SERVER_SYNC;
  }

  /// Check if we should use direct ESPN
  static bool shouldUseDirectESPN() {
    return USE_DIRECT_ESPN;
  }
}
