import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';
import 'package:nfl_survival/data/models/user.dart';
import 'package:nfl_survival/features/league/join/league_options_dialog.dart';

final userLeaguesProvider = FutureProvider<List<League>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];
  return ref.read(leagueRepositoryProvider).listLeaguesForUser(currentUser.id);
});

class LeagueListScreen extends ConsumerWidget {
  const LeagueListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(userLeaguesProvider);
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    return AppScaffold(
      appBar: AppBar(title: const Text('My Leagues')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show options dialog for create vs join
          LeagueOptionsDialog.show(context);
        },
        child: const Icon(Icons.add),
      ),
      child: Column(
        children: [
          Expanded(
            child: leaguesAsync.when(
              data: (leagues) {
                if (leagues.isEmpty) {
                  return const Center(child: Text('No leagues joined. Create one!'));
                }
                return ListView.builder(
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index];
                    return ListTile(
                      title: Text(league.name),
                      subtitle: Text('Season: ${league.season} | Members: ${league.memberIds.length}'),
                      onTap: () => context.go('/league/${league.id}'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          if (!isPremium) const BannerAdSlot(),
        ],
      ),
    );
  }
}
