import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/providers.dart';
import '../../app/theme/theme_extensions.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Premium'),
        backgroundColor: appColors.premium ?? theme.colorScheme.tertiary,
        foregroundColor: appColors.onTertiary ?? theme.colorScheme.onTertiary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Premium unlocks multiple leagues, no ads, and advanced analytics.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Navigate to detailed premium upgrade screen
            ElevatedButton(
              onPressed: () => context.push('/premium-upgrade'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    appColors.premium ?? theme.colorScheme.tertiary,
                foregroundColor:
                    appColors.onTertiary ?? theme.colorScheme.onTertiary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Premium Features',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            // Legacy subscription button (for testing)
            OutlinedButton(
              onPressed: () async {
                final ok = await ref
                    .read(billingRepositoryProvider)
                    .startMonthlySubscription();
                if (!context.mounted) return;
                if (ok) Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    appColors.premium ?? theme.colorScheme.tertiary,
                side: BorderSide(
                  color: appColors.premium ?? theme.colorScheme.tertiary,
                ),
              ),
              child: const Text('Start monthly subscription (Legacy)'),
            ),
          ],
        ),
      ),
    );
  }
}
