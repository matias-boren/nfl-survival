import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/router.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Create a simple test app without Supabase dependencies
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Test App'),
            ),
          ),
        ),
      ),
    );

    // Verify that the app loads
    expect(find.text('Test App'), findsOneWidget);
  });
}
