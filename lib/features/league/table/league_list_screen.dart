import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../data/models/league.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/app_scaffold.dart';
import '../../../widgets/banner_ad_slot.dart';

final userLeaguesProvider = FutureProvider.autoDispose<List<League>>((ref) async {
  final auth = ref.read(authRepositoryProvider);
  final user = await auth.currentUser() ?? await auth.signInAnonymously();
  return ref.read(leagueRepositoryProvider).listLeaguesForUser(user.id);
});

class LeagueListScreen extends ConsumerWidget {
  const LeagueListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(userLeaguesProvider);
    final premiumAsync = ref.watch(premiumStatusProvider);
    final isPremium = premiumAsync.value ?? false;
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Leagues'),
        actions: [
          IconButton(
            onPressed: () async {
              final auth = ref.read(authRepositoryProvider);
              final user = await auth.currentUser() ?? await auth.signInAnonymously();
              final existing = await ref.read(leagueRepositoryProvider).listLeaguesForUser(user.id);
              if (!isPremium && existing.isNotEmpty) {
                if (!context.mounted) return;
                context.go('/paywall');
                return;
              }
              final settings = isPremium
                  ? const LeagueSettings(
                      maxLosses: 1,
                      allowTeamReuse: false,
                      autoEliminateOnNoPick: true,
                      minTeams: 2,
                      tiebreaker: Tiebreaker.LAST_LONGEST_STREAK,
                    )
                  : const LeagueSettings(
                      maxLosses: 0,
                      allowTeamReuse: false,
                      autoEliminateOnNoPick: true,
                      minTeams: 2,
                      tiebreaker: Tiebreaker.LAST_LONGEST_STREAK,
                    );
              final league = League(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: 'My League',
                ownerId: user.id,
                visibility: LeagueVisibility.PUBLIC,
                settings: settings,
                season: 2025,
                createdAtIso: DateTime.now().toUtc().toIso8601String(),
                memberIds: [user.id],
              );
              await ref.read(leagueRepositoryProvider).createLeague(league);
              ref.invalidate(userLeaguesProvider);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Create league',
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: leaguesAsync.when(
              data: (leagues) => ListView.builder(
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  final l = leagues[index];
                  return ListTile(
                    title: Text(l.name),
                    subtitle: Text('Members: ${l.memberIds.length}'),
                    onTap: () => context.go('/league/${l.id}'),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          BannerAdSlot(show: !isPremium),
        ],
      ),
    );
  }
}

