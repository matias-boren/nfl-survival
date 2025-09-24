import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumAsync = ref.watch(premiumStatusProvider);
    final isPremium = premiumAsync.value ?? false;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Premium: ${isPremium ? 'Yes' : 'No'}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/paywall'),
              child: const Text('Manage Subscription'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await ref.read(billingRepositoryProvider).restorePurchases();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Purchases restored')));
              },
              child: const Text('Restore Purchases'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authRepositoryProvider).signOut();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed out')));
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

