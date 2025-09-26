import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/features/league/table/league_list_screen.dart';

final leagueProvider = FutureProvider.family<League, String>((ref, leagueId) async {
  print('leagueProvider: Fetching league $leagueId');
  final league = await ref.read(leagueRepositoryProvider).getLeague(leagueId);
  print('leagueProvider: Got league ${league.name} with ${league.memberIds.length} members');
  return league;
});

class LeagueDetailScreen extends ConsumerWidget {
  final String leagueId;
  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagueAsync = ref.watch(leagueProvider(leagueId));
    final currentUser = ref.watch(currentUserProvider);
    
    return leagueAsync.when(
      data: (league) {
        // Check if user is still a member of this league
        if (currentUser != null && !currentUser.joinedLeagueIds.contains(leagueId)) {
          // User is no longer a member, redirect to leagues list
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/leagues');
          });
          return const AppScaffold(child: Center(child: CircularProgressIndicator()));
        }
        
        return AppScaffold(
        appBar: AppBar(
          title: Text(league.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.invalidate(leagueProvider(leagueId));
              },
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // League Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'League Information',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text('Season ${league.season}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            league.visibility == LeagueVisibility.PUBLIC 
                                ? Icons.public 
                                : Icons.lock,
                            size: 16, 
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Text(league.visibility == LeagueVisibility.PUBLIC ? 'Public' : 'Private'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Text(
                'Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Make Pick Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/league/$leagueId/pick'),
                  icon: const Icon(Icons.sports_football),
                  label: const Text('Make Pick'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // View Picks History Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/league/$leagueId/picks-history'),
                  icon: const Icon(Icons.history),
                  label: const Text('View Picks History'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // View Standings Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/league/$leagueId/standings'),
                  icon: const Icon(Icons.leaderboard),
                  label: const Text('View Standings'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // League Chat Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/league/$leagueId/chat'),
                  icon: const Icon(Icons.chat),
                  label: const Text('League Chat'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Manage Invitations Button (only for private leagues)
              if (league.visibility == LeagueVisibility.PRIVATE) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/league/$leagueId/invitations'),
                    icon: const Icon(Icons.group_add),
                    label: const Text('Manage Invitations'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              
              // Leave League Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showLeaveLeagueDialog(context, ref, leagueId),
                  icon: const Icon(Icons.exit_to_app, color: Colors.red),
                  label: const Text('Leave League', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
        );
      },
      loading: () => const AppScaffold(child: Center(child: CircularProgressIndicator())),
      error: (e, st) => AppScaffold(child: Center(child: Text('Error: $e'))),
    );
  }

  void _showLeaveLeagueDialog(BuildContext context, WidgetRef ref, String leagueId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave League'),
        content: const Text(
          'Are you sure you want to leave this league? You will lose all your progress and picks in this league.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _leaveLeague(context, ref, leagueId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave League'),
          ),
        ],
      ),
    );
  }

  Future<void> _leaveLeague(BuildContext context, WidgetRef ref, String leagueId) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Leaving league...'),
          backgroundColor: Colors.blue,
        ),
      );

      // Leave the league
      await ref.read(leagueRepositoryProvider).leaveLeague(leagueId, currentUser.id);

      // Update user's joined leagues
      final updatedUser = currentUser.copyWith(
        joinedLeagueIds: currentUser.joinedLeagueIds.where((id) => id != leagueId).toList(),
      );
      ref.read(currentUserProvider.notifier).state = updatedUser;

      // Invalidate providers to refresh data
      ref.invalidate(userLeaguesProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully left the league'),
            backgroundColor: Colors.orange,
          ),
        );
        // Navigate back to leagues list
        context.go('/leagues');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to leave league: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
