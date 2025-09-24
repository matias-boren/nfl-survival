import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/auth/auth_repositories.dart';
import '../data/billing/billing_repositories.dart';
import '../data/ads/ads_service.dart';
import '../data/nfl/nfl_repositories.dart';
import '../data/leagues/league_repositories.dart';
import '../data/picks/picks_repositories.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => MockAuthRepository());
final billingRepositoryProvider = Provider<BillingRepository>((ref) => MockBillingRepository());
final adsServiceProvider = Provider<AdsService>((ref) => DevNoopAdsService());
final nflRepositoryProvider = Provider<NflDataRepository>((ref) => MockNflDataRepository());
final leagueRepositoryProvider = Provider<LeagueRepository>((ref) => MockLeagueRepository());
final picksRepositoryProvider = Provider<PicksRepository>((ref) => MockPicksRepository());

final premiumStatusProvider = StreamProvider<bool>((ref) {
  return ref.read(billingRepositoryProvider).premiumStatus();
});

