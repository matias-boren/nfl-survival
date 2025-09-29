import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('basic router test', () {
    // Test basic router functionality without Supabase dependencies
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home'))),
        ),
      ],
    );

    expect(router, isNotNull);
    expect(router.configuration.routes, isNotEmpty);
  });
}
