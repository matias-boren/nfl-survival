import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../data/models/pick.dart';
import '../../../widgets/app_scaffold.dart';

final picksHistoryProvider = FutureProvider.family<List<Pick>, ({String leagueId, int week})>((ref, args) async {
  return ref.read(picksRepositoryProvider).listPicks(args.leagueId, args.week);
});

class PicksHistoryScreen extends ConsumerWidget {
  final String leagueId;
  final int week;
  const PicksHistoryScreen({super.key, required this.leagueId, required this.week});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picksAsync = ref.watch(picksHistoryProvider((leagueId: leagueId, week: week)));
    return AppScaffold(
      appBar: AppBar(title: Text('Picks - Week $week')),
      child: picksAsync.when(
        data: (picks) => ListView.builder(
          itemCount: picks.length,
          itemBuilder: (context, i) {
            final p = picks[i];
            return ListTile(
              title: Text(p.userId),
              subtitle: Text('Team ${p.teamId} • ${p.result?.name ?? 'PENDING'}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

