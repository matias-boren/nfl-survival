import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../data/models/pick.dart';
import '../../../widgets/app_scaffold.dart';

final picksHistoryProvider =
    FutureProvider.family<List<Pick>, ({String leagueId, int week})>((
      ref,
      args,
    ) async {
      return ref
          .read(picksRepositoryProvider)
          .listPicks(args.leagueId, args.week);
    });

class PicksHistoryScreen extends ConsumerWidget {
  final String leagueId;
  final int week;
  const PicksHistoryScreen({
    super.key,
    required this.leagueId,
    required this.week,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get all picks for this league across all weeks
    final allPicksAsync = ref.watch(leaguePicksProvider(leagueId));
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Picks History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(leaguePicksProvider(leagueId));
            },
          ),
        ],
      ),
      child: allPicksAsync.when(
        data: (picks) {
          if (picks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_football, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No picks made yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Make your first pick to see it here!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: picks.length,
            itemBuilder: (context, i) {
              final p = picks[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: p.result == PickResult.WIN
                        ? Colors.green
                        : p.result == PickResult.LOSE
                        ? Colors.red
                        : Colors.orange,
                    child: Icon(
                      p.result == PickResult.WIN
                          ? Icons.check
                          : p.result == PickResult.LOSE
                          ? Icons.close
                          : Icons.schedule,
                      color: Colors.white,
                    ),
                  ),
                  title: FutureBuilder<String>(
                    future: _getUserDisplayName(ref, p.userId),
                    builder: (context, snapshot) {
                      final displayName =
                          snapshot.data ??
                          'User ${p.userId.substring(0, 8)}...';
                      return Text(
                        displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  subtitle: Text('Picked ${p.teamId} • Week ${p.week}'),
                  trailing: Chip(
                    label: Text(
                      _getResultDisplayText(p.result),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getResultColor(p.result),
                  ),
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

  Color _getResultColor(PickResult? result) {
    switch (result) {
      case PickResult.WIN:
        return Colors.green;
      case PickResult.LOSE:
        return Colors.red;
      case PickResult.PENDING:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getResultIcon(PickResult? result) {
    switch (result) {
      case PickResult.WIN:
        return Icons.check;
      case PickResult.LOSE:
        return Icons.close;
      case PickResult.PENDING:
        return Icons.schedule;
      default:
        return Icons.schedule;
    }
  }

  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return '${date.month}/${date.day}/${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }

  Future<String> _getUserDisplayName(WidgetRef ref, String userId) async {
    try {
      final user = await ref.read(userRepositoryProvider).getUserById(userId);
      return user?.displayName ?? 'User ${userId.substring(0, 8)}...';
    } catch (e) {
      return 'User ${userId.substring(0, 8)}...';
    }
  }

  String _getResultDisplayText(PickResult? result) {
    switch (result) {
      case PickResult.WIN:
        return 'WIN';
      case PickResult.LOSE:
        return 'LOSE';
      case PickResult.PENDING:
        return 'AWAITING RESULT';
      default:
        return 'AWAITING RESULT';
    }
  }
}
