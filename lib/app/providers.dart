import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/data/ads/ads_service.dart';
import 'package:nfl_survival/data/ads/mock_ads_service.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/auth/mock_auth_repository.dart';
import 'package:nfl_survival/data/billing/billing_repositories.dart';
import 'package:nfl_survival/data/billing/mock_billing_repository.dart';
import 'package:nfl_survival/data/friends/friends_repositories.dart';
import 'package:nfl_survival/data/friends/mock_friends_repository.dart';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/leagues/mock_league_repository.dart';
import 'package:nfl_survival/data/nfl/mock_nfl_repository.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/picks/mock_picks_repository.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';
import 'package:nfl_survival/core/utils/time.dart';

// Repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) => MockAuthRepository());
final billingRepositoryProvider = Provider<BillingRepository>((ref) => MockBillingRepository());
final adsServiceProvider = Provider<AdsService>((ref) => MockAdsService());
final nflDataRepositoryProvider = Provider<NflDataRepository>((ref) => MockNflDataRepository());
final leagueRepositoryProvider = Provider<LeagueRepository>((ref) => MockLeagueRepository());
final picksRepositoryProvider = Provider<PicksRepository>((ref) => MockPicksRepository());
final friendsRepositoryProvider = Provider<FriendsRepository>((ref) => MockFriendsRepository());

// Services
final deadlineServiceProvider = Provider<DeadlineService>((ref) => DeadlineService());

// Streams/Futures
final currentUserProvider = StreamProvider((ref) => ref.watch(authRepositoryProvider).currentUser());
final premiumStatusProvider = StreamProvider<bool>((ref) => ref.watch(billingRepositoryProvider).premiumStatus());
