import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../data/models/nfl.dart';
import '../../../core/utils/time.dart';

final weekGamesProvider = FutureProvider.family<List<Game>, ({int season, int week})>((ref, params) async {
  return ref.read(nflRepositoryProvider).listGames(params.season, params.week);
});

class MakePickScreen extends ConsumerWidget {
  final String leagueId;
  final int week;
  const MakePickScreen({super.key, required this.leagueId, required this.week});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(weekGamesProvider((season: 2025, week: week)));
    return Scaffold(
      appBar: AppBar(title: const Text('Make Pick')),
      body: gamesAsync.when(
        data: (games) {
          final starts = games.map((g) => TimeUtils.parseUtc(g.startIso)).toList();
          return FutureBuilder<DateTime>(
            future: DeadlineService().weekDeadlineUtc(weekStartTimesUtc: starts),
            builder: (context, snap) {
              final deadline = snap.data;
              final locked = deadline == null ? false : DeadlineService().isLocked(nowUtc: DateTime.now().toUtc(), deadlineUtc: deadline);
              return Column(
                children: [
                  if (deadline != null) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Deadline: ${TimeUtils.formatLocal(deadline.toIso8601String())}'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, i) {
                        final g = games[i];
                        return ListTile(
                          title: Text('${g.awayId} @ ${g.homeId}'),
                          subtitle: Text(TimeUtils.formatLocal(g.startIso)),
                          trailing: ElevatedButton(
                            onPressed: locked ? null : () async {
                              final auth = ref.read(authRepositoryProvider);
                              final user = await auth.currentUser() ?? await auth.signInAnonymously();
                              await ref.read(picksRepositoryProvider).submitPick(
                                leagueId: leagueId,
                                userId: user.id,
                                week: week,
                                teamId: g.homeId,
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick submitted')));
                            },
                            child: const Text('Pick home'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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

