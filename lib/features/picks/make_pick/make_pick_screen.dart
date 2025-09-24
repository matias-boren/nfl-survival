import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

final gamesForWeekProvider = FutureProvider.family<List<Game>, int>((ref, week) async {
  return ref.read(nflDataRepositoryProvider).listGames(2025, week); // Mock season 2025
});

final pickLockedProvider = FutureProvider.family<bool, int>((ref, week) async {
  return ref.read(deadlineServiceProvider).isPickLocked(2025, week); // Mock season 2025
});

class MakePickScreen extends ConsumerWidget {
  final String leagueId;
  final int week;
  const MakePickScreen({super.key, required this.leagueId, required this.week});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesForWeekProvider(week));
    final pickLockedAsync = ref.watch(pickLockedProvider(week));
    final currentUserAsync = ref.watch(currentUserProvider);

    return AppScaffold(
      appBar: AppBar(title: Text('Make Pick - Week $week')),
      child: gamesAsync.when(
        data: (games) {
          final isLocked = pickLockedAsync.valueOrNull ?? false;
          if (isLocked) {
            return const Center(
              child: Text('Picks are locked for this week!'),
            );
          }
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text('${game.homeId} vs ${game.awayId}'),
                subtitle: Text(ref.read(deadlineServiceProvider).formatUtcToLocal(game.startIso)),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final currentUser = currentUserAsync.value;
                    if (currentUser != null) {
                      await ref.read(picksRepositoryProvider).submitPick(
                            leagueId: leagueId,
                            userId: currentUser.id,
                            week: week,
                            teamId: game.homeId, // Example: always pick home team
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pick submitted!')),
                      );
                    }
                  },
                  child: const Text('Pick Home'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
