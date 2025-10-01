import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick1/core/services/result_processing_service.dart';
import 'package:pick1/core/services/standings_service.dart';
import 'package:pick1/core/services/automated_result_processor.dart';
import 'package:pick1/core/services/weekly_data_refresh_service.dart';
import 'package:pick1/core/services/elimination_service.dart';
import 'package:pick1/core/services/automated_news_generator.dart';
import 'package:pick1/core/config/news_config.dart';
// Live score services removed
import 'package:pick1/data/ads/ads_service.dart';
import 'package:pick1/data/ads/mock_ads_service.dart';
import 'package:pick1/data/auth/auth_repositories.dart';
import 'package:pick1/data/auth/supabase_auth_repository.dart';
import 'package:pick1/data/billing/billing_repositories.dart';
import 'package:pick1/data/billing/mock_billing_repository.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/data/leagues/supabase_league_repository.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';
import 'package:pick1/data/nfl/hybrid_nfl_repository.dart';
import 'package:pick1/data/picks/supabase_picks_repository.dart';
import 'package:pick1/data/picks/picks_repositories.dart';
import 'package:pick1/data/news/news_repositories.dart';
import 'package:pick1/data/news/supabase_news_repository.dart';
import 'package:pick1/data/news/mock_news_repository.dart';
import 'package:pick1/data/friends/friends_repositories.dart';
import 'package:pick1/data/friends/mock_friends_repository.dart';
import 'package:pick1/data/invitations/invitation_repositories.dart';
import 'package:pick1/data/invitations/supabase_invitation_repository.dart';
import 'package:pick1/data/invitations/mock_invitation_repository.dart';
import 'package:pick1/data/teams/team_repositories.dart';
import 'package:pick1/data/teams/supabase_team_repository.dart';
import 'package:pick1/data/teams/supabase_team_record_repository.dart';
import 'package:pick1/core/services/team_service.dart';
import 'package:pick1/core/services/automated_data_refresh_service.dart';
import 'package:pick1/data/users/user_repositories.dart';
import 'package:pick1/data/users/supabase_user_repository.dart';
import 'package:pick1/data/chat/chat_repositories.dart';
import 'package:pick1/data/chat/supabase_chat_repository.dart';
import 'package:pick1/data/models/user.dart';
import 'package:pick1/data/models/pick.dart';
// NFL models import removed - LiveScore functionality removed
import 'package:pick1/data/models/chat_message.dart';
import 'package:pick1/core/services/deadline_service.dart';
import 'package:pick1/features/league/table/league_list_screen.dart';

// Repositories
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => SupabaseAuthRepository(),
);
final billingRepositoryProvider = Provider<BillingRepository>(
  (ref) => MockBillingRepository(),
);
final adsServiceProvider = Provider<AdsService>((ref) => MockAdsService());
final nflRepositoryProvider = Provider<NflRepository>((ref) {
  return HybridNflRepository();
});
final leagueRepositoryProvider = Provider<LeagueRepository>(
  (ref) => SupabaseLeagueRepository(),
);
final picksRepositoryProvider = Provider<PicksRepository>(
  (ref) => SupabasePicksRepository(),
);
final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => SupabaseChatRepository(),
);
final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => SupabaseNewsRepository(),
);
final friendsRepositoryProvider = Provider<FriendsRepository>(
  (ref) => MockFriendsRepository(),
);
final invitationRepositoryProvider = Provider<InvitationRepository>(
  (ref) => SupabaseInvitationRepository(),
);

// Team Repositories
final teamRepositoryProvider = Provider<TeamRepository>(
  (ref) => SupabaseTeamRepository(),
);
final teamRecordRepositoryProvider = Provider<TeamRecordRepository>(
  (ref) => SupabaseTeamRecordRepository(),
);

// Team Service
final teamServiceProvider = Provider<TeamService>((ref) {
  return TeamService(
    teamRepository: ref.read(teamRepositoryProvider),
    teamRecordRepository: ref.read(teamRecordRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
  );
});

// Automated Data Refresh Service
final automatedDataRefreshServiceProvider = Provider<AutomatedDataRefreshService>((ref) {
  final service = AutomatedDataRefreshService();
  service.initialize(
    resultProcessingService: ref.read(resultProcessingServiceProvider),
    teamService: ref.read(teamServiceProvider),
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
  );
  return service;
});
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => SupabaseUserRepository(),
);

// Services
final deadlineServiceProvider = Provider<DeadlineService>(
  (ref) => DeadlineService(),
);

// Week Provider with auto-refresh
final currentWeekProvider = StreamProvider<int>((ref) {
  final deadlineService = ref.read(deadlineServiceProvider);
  return deadlineService.weekStream;
});

// Streams/Futures
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((
  ref,
) {
  return CurrentUserNotifier(ref.read(authRepositoryProvider));
});

// Authentication state provider that includes initialization status
final authStateProvider = Provider<({User? user, bool isInitialized})>((ref) {
  final notifier = ref.watch(currentUserProvider.notifier);
  final user = ref.watch(currentUserProvider);
  return (user: user, isInitialized: notifier.isInitialized);
});
final premiumStatusProvider = Provider<bool>((ref) {
  // Use select to only watch the isPremium field, reducing rebuilds
  final isPremium = ref.watch(
    currentUserProvider.select((user) => user?.isPremium ?? false),
  );
  print('💰 Premium status provider - isPremium: $isPremium');
  return isPremium;
});

// News and Scores Providers
final newsFeedProvider = FutureProvider<List<NewsArticle>>((ref) async {
  return ref.read(newsRepositoryProvider).getLatestNews();
});

// Automated News Generator
final newsGeneratorProvider = Provider<AutomatedNewsGenerator>((ref) {
  return AutomatedNewsGenerator(
    openAIApiKey: NewsConfig.openAIApiKey,
  );
});

// Live scores functionality removed to fix CI issues

// Current User Notifier
class CurrentUserNotifier extends StateNotifier<User?> {
  final AuthRepository _authRepository;
  bool _isInitialized = false;

  CurrentUserNotifier(this._authRepository) : super(null) {
    _init();
  }

  void _init() {
    _authRepository.currentUser().listen((user) {
      print(
        '👤 CurrentUserNotifier - User changed: ${user?.email}, isPremium: ${user?.isPremium}',
      );
      state = user;
      _isInitialized = true;
    });
  }

  bool get isInitialized => _isInitialized;

  Future<void> signIn(String email, String password) async {
    print('🔐 Signing in user: $email');
    final user = await _authRepository.signInWithEmail(email, password);
    print('✅ Sign in successful - isPremium: ${user.isPremium}');
    state = user;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = null;
  }
}

// User pick provider for a specific league and week
final userPickProvider =
    FutureProvider.family<String?, (String leagueId, int week)>((
      ref,
      params,
    ) async {
      final currentUser = ref.watch(currentUserProvider);
      if (currentUser == null) return null;

      try {
        final pick = await ref
            .read(picksRepositoryProvider)
            .getUserPick(params.$1, currentUser.id, params.$2);
        return pick?.teamId;
      } catch (e) {
        return null;
      }
    });

// All user picks for current week across all leagues
final userPicksForWeekProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];

  final userLeagues = await ref.read(userLeaguesProvider.future);
  final picks = <Map<String, dynamic>>[];

  for (final league in userLeagues) {
    try {
      final pick = await ref
          .read(picksRepositoryProvider)
          .getUserPick(
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
  return () async {
    final authRepo = ref.read(authRepositoryProvider) as SupabaseAuthRepository;
    final currentUser = ref.read(currentUserProvider);

    if (currentUser != null) {
      // Toggle premium status
      final newPremiumStatus = !currentUser.isPremium;
      await authRepo.updatePremiumStatus(newPremiumStatus);

      // Refresh the current user to get updated data
      // The currentUser stream will automatically update
    }
  };
});

// Chat messages provider
final leagueChatProvider = StreamProvider.family<List<ChatMessage>, String>((
  ref,
  leagueId,
) {
  final chatRepo = ref.read(chatRepositoryProvider);
  return chatRepo.getChatMessages(leagueId);
});

// Provider for deadline status using NFL repository
final deadlineStatusProvider = FutureProvider.family<String, int>((
  ref,
  week,
) async {
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
final resultProcessingServiceProvider = Provider<ResultProcessingService>((
  ref,
) {
  return ResultProcessingService(
    picksRepository: ref.read(picksRepositoryProvider),
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
    teamService: ref.read(teamServiceProvider),
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
final processWeekResultsProvider =
    FutureProvider.family<ResultProcessingSummary, (String leagueId, int week)>(
      (ref, params) async {
        final service = ref.read(resultProcessingServiceProvider);
        return await service.processWeekResults(
          leagueId: params.$1,
          week: params.$2,
        );
      },
    );

// Provider to calculate league standings
final leagueStandingsProvider =
    FutureProvider.family<List<LeagueStanding>, String>((ref, leagueId) async {
      final standingsService = ref.read(standingsServiceProvider);
      final league = await ref
          .read(leagueRepositoryProvider)
          .getLeague(leagueId);

      return await standingsService.calculateLeagueStandings(
        leagueId: leagueId,
        league: league,
      );
    });

// Provider to get all picks for a league
final leaguePicksProvider = FutureProvider.family<List<Pick>, String>((
  ref,
  leagueId,
) async {
  return await ref.read(picksRepositoryProvider).getLeaguePicks(leagueId);
});

// Automated result processor provider
final automatedResultProcessorProvider = Provider<AutomatedResultProcessor>((
  ref,
) {
  final processor = AutomatedResultProcessor();

  // Initialize with dependencies
  processor.initialize(
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
    picksRepository: ref.read(picksRepositoryProvider),
    ref: ref,
  );

  return processor;
});

// User's previous picks for a specific league (to prevent duplicate team selection)
final userPreviousPicksProvider = FutureProvider.family<List<Pick>, String>((
  ref,
  leagueId,
) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];

  return ref
      .read(picksRepositoryProvider)
      .getUserPicksForLeague(currentUser.id, leagueId);
});

// User's previously picked team IDs for a specific league
final userPickedTeamIdsProvider = FutureProvider.family<Set<String>, String>((
  ref,
  leagueId,
) async {
  final previousPicks = await ref.watch(
    userPreviousPicksProvider(leagueId).future,
  );
  return previousPicks.map((pick) => pick.teamId).toSet();
});

// Weekly data refresh service provider
final weeklyDataRefreshServiceProvider = Provider<WeeklyDataRefreshService>((
  ref,
) {
  final service = WeeklyDataRefreshService();

  // Initialize with dependencies
  service.initialize(
    leagueRepository: ref.read(leagueRepositoryProvider),
    nflRepository: ref.read(nflRepositoryProvider),
    picksRepository: ref.read(picksRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
    ref: ref,
  );

  return service;
});

// Elimination service provider
final eliminationServiceProvider = Provider<EliminationService>((ref) {
  return EliminationService(
    picksRepository: ref.read(picksRepositoryProvider),
    leagueRepository: ref.read(leagueRepositoryProvider),
    deadlineService: ref.read(deadlineServiceProvider),
  );
});

// Check if current user is eliminated from a league
final isUserEliminatedProvider = FutureProvider.family<bool, String>((
  ref,
  leagueId,
) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return false;

  return ref.read(eliminationServiceProvider).isUserEliminated(
    userId: currentUser.id,
    leagueId: leagueId,
  );
});
