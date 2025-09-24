import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/pick.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';

class LeagueStanding {
  final String userId;
  final String displayName;
  final int wins;
  final int losses;
  final List<String> usedTeams;
  final String? lastPickTeam;
  final PickResult? lastPickResult;

  LeagueStanding({
    required this.userId,
    required this.displayName,
    required this.wins,
    required this.losses,
    required this.usedTeams,
    this.lastPickTeam,
    this.lastPickResult,
  });

  int get totalPicks => wins + losses;
  double get winPercentage => totalPicks > 0 ? wins / totalPicks : 0.0;
}

final leagueStandingsProvider = FutureProvider.family<List<LeagueStanding>, String>((ref, leagueId) async {
  // Mock standings data
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    LeagueStanding(
      userId: 'user1',
      displayName: 'Alice Johnson',
      wins: 3,
      losses: 0,
      usedTeams: ['KC', 'BUF', 'SF'],
      lastPickTeam: 'SF',
      lastPickResult: PickResult.WIN,
    ),
    LeagueStanding(
      userId: 'user2',
      displayName: 'Bob Smith',
      wins: 2,
      losses: 1,
      usedTeams: ['DAL', 'PHI', 'LAR'],
      lastPickTeam: 'LAR',
      lastPickResult: PickResult.LOSE,
    ),
    LeagueStanding(
      userId: 'user3',
      displayName: 'Charlie Brown',
      wins: 2,
      losses: 0,
      usedTeams: ['GB', 'MIA'],
      lastPickTeam: 'MIA',
      lastPickResult: PickResult.WIN,
    ),
    LeagueStanding(
      userId: 'user4',
      displayName: 'Diana Prince',
      wins: 1,
      losses: 1,
      usedTeams: ['NE', 'NYG'],
      lastPickTeam: 'NYG',
      lastPickResult: PickResult.LOSE,
    ),
  ];
});

class LeagueStandingsScreen extends ConsumerWidget {
  final String leagueId;
  const LeagueStandingsScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standingsAsync = ref.watch(leagueStandingsProvider(leagueId));
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('League Standings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(leagueStandingsProvider(leagueId));
            },
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: standingsAsync.when(
              data: (standings) {
                if (standings.isEmpty) {
                  return const Center(
                    child: Text('No standings data available'),
                  );
                }
                
                // Sort by wins (descending), then by win percentage
                standings.sort((a, b) {
                  if (a.wins != b.wins) return b.wins.compareTo(a.wins);
                  return b.winPercentage.compareTo(a.winPercentage);
                });

                return ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final standing = standings[index];
                    final rank = index + 1;
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getRankColor(rank),
                          child: Text(
                            '$rank',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          standing.displayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${standing.wins}W - ${standing.losses}L (${(standing.winPercentage * 100).toStringAsFixed(1)}%)'),
                            if (standing.lastPickTeam != null)
                              Text(
                                'Last pick: ${standing.lastPickTeam} (${standing.lastPickResult?.name ?? 'PENDING'})',
                                style: TextStyle(
                                  color: _getResultColor(standing.lastPickResult),
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${standing.usedTeams.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'teams used',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _showUserDetails(context, standing);
                        },
                      ),
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

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.brown.shade300;
      default:
        return Colors.blue.shade300;
    }
  }

  Color _getResultColor(PickResult? result) {
    switch (result) {
      case PickResult.WIN:
        return Colors.green;
      case PickResult.LOSE:
        return Colors.red;
      case PickResult.PUSH:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showUserDetails(BuildContext context, LeagueStanding standing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(standing.displayName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Record: ${standing.wins}W - ${standing.losses}L'),
            Text('Win %: ${(standing.winPercentage * 100).toStringAsFixed(1)}%'),
            const SizedBox(height: 8),
            const Text('Teams Used:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(standing.usedTeams.join(', ')),
            if (standing.lastPickTeam != null) ...[
              const SizedBox(height: 8),
              const Text('Last Pick:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${standing.lastPickTeam} (${standing.lastPickResult?.name ?? 'PENDING'})'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
