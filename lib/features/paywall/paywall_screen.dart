import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/providers.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Premium'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Premium unlocks multiple leagues, no ads, live scores, and advanced analytics.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // Navigate to detailed premium upgrade screen
            ElevatedButton(
              onPressed: () => context.push('/premium-upgrade'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Premium Features',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Legacy subscription button (for testing)
            OutlinedButton(
              onPressed: () async {
                final ok = await ref.read(billingRepositoryProvider).startMonthlySubscription();
                if (!context.mounted) return;
                if (ok) Navigator.of(context).pop();
              },
              child: const Text('Start monthly subscription (Legacy)'),
            ),
          ],
        ),
      ),
    );
  }
}

