import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/core/services/result_processing_service.dart';
import 'package:nfl_survival/core/services/standings_service.dart';
import 'package:nfl_survival/core/services/automated_result_processor.dart';
import 'package:nfl_survival/core/services/live_scores_service.dart';
import 'package:nfl_survival/core/services/server_sync_service.dart';
import 'package:nfl_survival/core/config/api_config.dart';
import 'package:nfl_survival/data/ads/ads_service.dart';
import 'package:nfl_survival/data/ads/mock_ads_service.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/auth/mock_auth_repository.dart';
import 'package:nfl_survival/data/billing/billing_repositories.dart';
import 'package:nfl_survival/data/billing/mock_billing_repository.dart';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/leagues/mock_league_repository.dart';
import 'package:nfl_survival/data/nfl/mock_nfl_repository.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/nfl/hybrid_nfl_repository.dart';
import 'package:nfl_survival/data/picks/mock_picks_repository.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';
import 'package:nfl_survival/data/news/news_repositories.dart';
import 'package:nfl_survival/data/news/mock_news_repository.dart';
import 'package:nfl_survival/data/scores/scores_repositories.dart';
import 'package:nfl_survival/data/scores/mock_scores_repository.dart';
import 'package:nfl_survival/data/friends/friends_repositories.dart';
import 'package:nfl_survival/data/friends/mock_friends_repository.dart';
import 'package:nfl_survival/data/invitations/invitation_repositories.dart';
import 'package:nfl_survival/data/invitations/mock_invitation_repository.dart';
import 'package:nfl_survival/data/users/user_repositories.dart';
import 'package:nfl_survival/data/users/mock_user_repository.dart';
import 'package:nfl_survival/data/models/user.dart';
import 'package:nfl_survival/data/models/pick.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/core/services/deadline_service.dart';
import 'package:nfl_survival/features/league/table/league_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) => MockAuthRepository());
final billingRepositoryProvider = Provider<BillingRepository>((ref) => MockBillingRepository());
final adsServiceProvider = Provider<AdsService>((ref) => MockAdsService());
final nflRepositoryProvider = Provider<NflRepository>((ref) => HybridNflRepository());
final leagueRepositoryProvider = Provider<LeagueRepository>((ref) => MockLeagueRepository());
final picksRepositoryProvider = Provider<PicksRepository>((ref) => MockPicksRepository());
final newsRepositoryProvider = Provider<NewsRepository>((ref) => MockNewsRepository());
final scoresRepositoryProvider = Provider<ScoresRepository>((ref) => MockScoresRepository());
final friendsRepositoryProvider = Provider<FriendsRepository>((ref) => MockFriendsRepository());
final invitationRepositoryProvider = Provider<InvitationRepository>((ref) => MockInvitationRepository());
final userRepositoryProvider = Provider<UserRepository>((ref) => MockUserRepository());

// Services
final deadlineServiceProvider = Provider<DeadlineService>((ref) => DeadlineService());

// Week Provider with auto-refresh
final currentWeekProvider = StreamProvider<int>((ref) {
  final deadlineService = ref.read(deadlineServiceProvider);
  return deadlineService.weekStream;
});

// Streams/Futures
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((ref) {
  return CurrentUserNotifier(ref.read(authRepositoryProvider));
});
final premiumStatusProvider = StreamProvider<bool>((ref) => ref.watch(billingRepositoryProvider).premiumStatus());

// News and Scores Providers
final newsFeedProvider = FutureProvider<List<NewsArticle>>((ref) async {
  return ref.read(newsRepositoryProvider).getLatestNews();
});

// Live scores service provider (direct ESPN polling)
final liveScoresServiceProvider = Provider<LiveScoresService>((ref) {
  final service = LiveScoresService();
  
  // Initialize with dependencies
  service.initialize(
    nflRepository: ref.read(nflRepositoryProvider),
    season: 2025,
    week: 4, // Default week, will be updated by currentWeekProvider
  );
  
  return service;
});

// Server sync service provider (server-side polling)
final serverSyncServiceProvider = Provider<ServerSyncService>((ref) {
  final service = ServerSyncService();
  
  // Initialize with server configuration
  service.initialize(
    serverBaseUrl: ApiConfig.SERVER_BASE_URL,
    season: 2025,
    week: 4, // Default week, will be updated by currentWeekProvider
  );
  
  return service;
});

// Real-time live scores stream provider (configurable)
final liveScoresProvider = StreamProvider<List<LiveScore>>((ref) {
  final currentWeekAsync = ref.watch(currentWeekProvider);
  final currentWeek = currentWeekAsync.valueOrNull ?? 4;
  
  if (ApiConfig.shouldUseServerSync()) {
    // Use server sync (recommended for production)
    final service = ref.read(serverSyncServiceProvider);
    service.updateWeek(currentWeek);
    
    if (!service.isRunning) {
      service.startSyncing();
    }
    
    return service.scoresStream;
  } else {
    // Use direct ESPN polling (current implementation)
    final service = ref.read(liveScoresServiceProvider);
    service.updateWeek(currentWeek);
    
    if (!service.isRunning) {
      service.startPolling();
    }
    
    return service.scoresStream;
  }
});


// Current User Notifier
class CurrentUserNotifier extends StateNotifier<User?> {
  final AuthRepository _authRepository;
  
  CurrentUserNotifier(this._authRepository) : super(null) {
    _init();
  }
  
  void _init() {
    _authRepository.currentUser().listen((user) {
      state = user;
    });
  }
  
  Future<void> signIn(String email, String password) async {
    final user = await _authRepository.signInWithEmail(email, password);
    state = user;
  }
  
  Future<void> signOut() async {
    await _authRepository.signOut();
    state = null;
  }
}

// User pick provider for a specific league and week
final userPickProvider = FutureProvider.family<String?, (String leagueId, int week)>((ref, params) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return null;
  
  try {
    final pick = await ref.read(picksRepositoryProvider).getUserPick(
      params.$1,
      currentUser.id,
      params.$2,
    );
    return pick?.teamId;
  } catch (e) {
    return null;
  }
});

// All user picks for current week across all leagues
final userPicksForWeekProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];
  
  final userLeagues = await ref.read(userLeaguesProvider.future);
  final picks = <Map<String, dynamic>>[];
  
  for (final league in userLeagues) {
    try {
      final pick = await ref.read(picksRepositoryProvider).getUserPick(
        league.id,
        currentUser.id,
        1, // Current week
      );
      if (pick != null) {
        picks.add({
          'leagueName': league.name,
          'leagueId': league.id,
          'teamId': pick.teamId,
        });
      }
    } catch (e) {
      // Skip leagues with errors
    }
  }
  
  return picks;
});

// Testing provider to easily toggle premium status
final premiumToggleProvider = Provider<void Function()>((ref) {
  return () {
    final billingRepo = ref.read(billingRepositoryProvider) as MockBillingRepository;
    billingRepo.togglePremiumStatus();
  };
});

// Provider for deadline status using NFL repository
final deadlineStatusProvider = FutureProvider.family<String, int>((ref, week) async {
  try {
    final nflRepo = ref.read(nflRepositoryProvider);
    final deadline = await nflRepo.getPickDeadline(week);
    
    if (deadline == null) {
      return 'Week has passed';
    }
    
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
  } catch (e) {
    print('Error getting deadline status: $e');
    return 'Error getting deadline';
  }
});

// Result processing service provider
final resultProcessingServiceProvider = Provider<ResultProcessingService>((ref) {
  return ResultProcessingService(
    picksRepository: ref.read(picksRepositoryProvider),
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
  );
});

// Standings service provider
final standingsServiceProvider = Provider<StandingsService>((ref) {
  return StandingsService(
    picksRepository: ref.read(picksRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  );
});

// Provider to process results for a specific week and league
final processWeekResultsProvider = FutureProvider.family<ResultProcessingSummary, (String leagueId, int week)>((ref, params) async {
  final service = ref.read(resultProcessingServiceProvider);
  return await service.processWeekResults(
    leagueId: params.$1,
    week: params.$2,
  );
});

// Provider to calculate league standings
final leagueStandingsProvider = FutureProvider.family<List<LeagueStanding>, String>((ref, leagueId) async {
  final standingsService = ref.read(standingsServiceProvider);
  final league = await ref.read(leagueRepositoryProvider).getLeague(leagueId);
  if (league == null) return [];
  
  return await standingsService.calculateLeagueStandings(
    leagueId: leagueId,
    league: league,
  );
});

// Provider to get all picks for a league
final leaguePicksProvider = FutureProvider.family<List<Pick>, String>((ref, leagueId) async {
  return await ref.read(picksRepositoryProvider).getLeaguePicks(leagueId);
});

// Automated result processor provider
final automatedResultProcessorProvider = Provider<AutomatedResultProcessor>((ref) {
  final processor = AutomatedResultProcessor();
  
  // Initialize with dependencies
  processor.initialize(
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
    picksRepository: ref.read(picksRepositoryProvider),
  );
  
  return processor;
});
