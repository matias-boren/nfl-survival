import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';

void main() {
  test('core providers can be read', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(authRepositoryProvider), isNotNull);
    expect(container.read(billingRepositoryProvider), isNotNull);
    expect(container.read(adsServiceProvider), isNotNull);
    expect(container.read(nflRepositoryProvider), isNotNull);
    expect(container.read(leagueRepositoryProvider), isNotNull);
    expect(container.read(picksRepositoryProvider), isNotNull);

    // read one value from premiumStatusProvider
    final async = container.read(premiumStatusProvider);
    expect(async.hasValue || async.isLoading, isTrue);
  });
}
