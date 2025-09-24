import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/router.dart';

void main() {
  test('router provider builds', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    expect(router, isNotNull);
    expect(router.configuration.routes, isNotEmpty);
  });
}

