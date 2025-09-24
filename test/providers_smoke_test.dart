import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';

void main() {
  test('core providers can be read', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Test AuthRepository
    final authRepo = container.read(authRepositoryProvider);
    expect(authRepo, isNotNull);

    // Test BillingRepository
    final billingRepo = container.read(billingRepositoryProvider);
    expect(billingRepo, isNotNull);

    // Test AdsService
    final adsService = container.read(adsServiceProvider);
    expect(adsService, isNotNull);

    // Test NflDataRepository
    final nflDataRepo = container.read(nflDataRepositoryProvider);
    expect(nflDataRepo, isNotNull);

    // Test LeagueRepository
    final leagueRepo = container.read(leagueRepositoryProvider);
    expect(leagueRepo, isNotNull);

    // Test PicksRepository
    final picksRepo = container.read(picksRepositoryProvider);
    expect(picksRepo, isNotNull);

    // Test FriendsRepository
    final friendsRepo = container.read(friendsRepositoryProvider);
    expect(friendsRepo, isNotNull);

    // Test DeadlineService
    final deadlineService = container.read(deadlineServiceProvider);
    expect(deadlineService, isNotNull);

    // Test currentUserProvider (stream)
    final currentUser = await container.read(currentUserProvider.future);
    expect(currentUser, isNull); // Initially null for mock

    // Test premiumStatusProvider (stream)
    final isPremium = await container.read(premiumStatusProvider.future);
    expect(isPremium, isFalse); // Initially false for mock
  });
}
