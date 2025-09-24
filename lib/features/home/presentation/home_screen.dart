import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../widgets/banner_ad_slot.dart';
import '../../../widgets/app_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumAsync = ref.watch(premiumStatusProvider);
    final isPremium = premiumAsync.value ?? false;
    return AppScaffold(
      appBar: AppBar(title: const Text('Home')),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authRepositoryProvider).signInAnonymously();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in')));
                    },
                    child: const Text('Sign in anonymously'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/leagues');
                    },
                    child: const Text('Go to Leagues'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                    child: const Text('Settings'),
                  ),
                ],
              ),
            ),
          ),
          BannerAdSlot(show: !isPremium),
        ],
      ),
    );
  }
}

