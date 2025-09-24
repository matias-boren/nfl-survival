import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    return AppScaffold(
      appBar: AppBar(title: const Text('NFL Survival Pool')),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: currentUserAsync.when(
                data: (user) {
                  if (user == null) {
                    return ElevatedButton(
                      onPressed: () async {
                        await ref.read(authRepositoryProvider).signInAnonymously();
                      },
                      child: const Text('Sign In Anonymously'),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome, ${user.displayName}!'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => context.go('/leagues'),
                        child: const Text('My Leagues'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.go('/news'),
                        child: const Text('News Feed'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.go('/friends'),
                        child: const Text('Friends'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.go('/settings'),
                        child: const Text('Settings'),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, st) => Text('Error: $e'),
              ),
            ),
          ),
          if (!isPremium) const BannerAdSlot(),
        ],
      ),
    );
  }
}
