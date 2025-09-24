import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';

final leagueProvider = FutureProvider.family<League, String>((ref, id) async {
  return ref.read(leagueRepositoryProvider).getLeague(id);
});

class LeagueDetailScreen extends ConsumerWidget {
  final String leagueId;
  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagueAsync = ref.watch(leagueProvider(leagueId));
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    return leagueAsync.when(
      data: (league) => AppScaffold(
        appBar: AppBar(title: Text(league.name)),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Season ${league.season}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text('Members: ${league.memberIds.length}'),
                            Text('Visibility: ${league.visibility.name}'),
                            Text('Max Losses: ${league.settings.maxLosses}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.go('/picks/${league.id}/1'),
                          icon: const Icon(Icons.sports_football),
                          label: const Text('Make Pick (Week 1)'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => context.go('/picks/${league.id}/1/history'),
                          icon: const Icon(Icons.history),
                          label: const Text('Picks History'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => context.go('/league/${league.id}/standings'),
                          icon: const Icon(Icons.leaderboard),
                          label: const Text('Standings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!isPremium) const BannerAdSlot(),
          ],
        ),
      ),
      loading: () => const AppScaffold(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => AppScaffold(
        child: Center(child: Text('Error: $e')),
      ),
    );
  }
}
