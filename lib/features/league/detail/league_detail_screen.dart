import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../data/models/league.dart';
import 'package:go_router/go_router.dart';

final leagueProvider = FutureProvider.family<League, String>((ref, id) async {
  return ref.read(leagueRepositoryProvider).getLeague(id);
});

class LeagueDetailScreen extends ConsumerWidget {
  final String leagueId;
  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagueAsync = ref.watch(leagueProvider(leagueId));
    return leagueAsync.when(
      data: (league) => Scaffold(
        appBar: AppBar(title: Text(league.name)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Season ${league.season} • Members ${league.memberIds.length}'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.go('/picks/${league.id}/1'),
                child: const Text('Make Pick (Week 1)'),
              )
            ],
          ),
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

