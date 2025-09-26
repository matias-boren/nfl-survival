import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('basic provider test', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Test basic provider functionality
    final testProvider = Provider<String>((ref) => 'test');
    final value = container.read(testProvider);
    expect(value, equals('test'));
  });
}
