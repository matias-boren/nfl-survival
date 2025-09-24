import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Premium')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Premium unlocks multiple leagues, no ads, live scores.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final ok = await ref.read(billingRepositoryProvider).startMonthlySubscription();
                if (!context.mounted) return;
                if (ok) Navigator.of(context).pop();
              },
              child: const Text('Start monthly subscription'),
            ),
          ],
        ),
      ),
    );
  }
}

