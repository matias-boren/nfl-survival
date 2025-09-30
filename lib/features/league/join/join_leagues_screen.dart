import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/data/models/league.dart';
import 'package:pick1/widgets/app_scaffold.dart';

class JoinLeaguesScreen extends ConsumerWidget {
  const JoinLeaguesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicLeaguesAsync = ref.watch(publicLeaguesProvider);
    final currentUser = ref.watch(currentUserProvider);

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Join Public Leagues'),
        leading: IconButton(
          onPressed: () => context.go('/leagues'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      child: publicLeaguesAsync.when(
        data: (leagues) {
          if (leagues.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.public_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Public Leagues Available',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Be the first to create a public league!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/create-league'),
                    icon: const Icon(Icons.add),
                    label: const Text('Create League'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              final league = leagues[index];
              final isAlreadyJoined =
                  currentUser?.joinedLeagueIds.contains(league.id) ?? false;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isAlreadyJoined
                        ? Colors.green
                        : Colors.blue,
                    child: Icon(
                      isAlreadyJoined ? Icons.check : Icons.public,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    league.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Owner: ${league.ownerId.length > 8 ? '${league.ownerId.substring(0, 8)}...' : league.ownerId}',
                      ),
                      Text('Season: ${league.season}'),
                      Text('Max Losses: ${league.settings.maxLosses}'),
                      Text('Tiebreaker: Points For'),
                    ],
                  ),
                  trailing: isAlreadyJoined
                      ? const Chip(
                          label: Text('Joined'),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white),
                        )
                      : ElevatedButton(
                          onPressed: () => _joinLeague(context, ref, league.id),
                          child: const Text('Join'),
                        ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading leagues: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(publicLeaguesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _joinLeague(
    BuildContext context,
    WidgetRef ref,
    String leagueId,
  ) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    // Check freemium limits
    final isPremium = ref.read(premiumStatusProvider);
    if (!isPremium && currentUser.joinedLeagueIds.length >= 1) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Free users can only join 1 league. Upgrade to Premium for unlimited leagues!',
            ),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 4),
          ),
        );
        // Navigate to paywall
        context.go('/paywall');
      }
      return;
    }

    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Joining league...'),
          backgroundColor: Colors.blue,
        ),
      );

      // Join the league
      await ref
          .read(leagueRepositoryProvider)
          .joinLeague(leagueId, currentUser.id);

      // Update user's joined leagues
      final updatedUser = currentUser.copyWith(
        joinedLeagueIds: [...currentUser.joinedLeagueIds, leagueId],
      );
      ref.read(currentUserProvider.notifier).state = updatedUser;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully joined the league!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to leagues list
        context.go('/leagues');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to join league: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

// Provider for public leagues
final publicLeaguesProvider = FutureProvider<List<League>>((ref) async {
  return ref.read(leagueRepositoryProvider).getPublicLeagues();
});
