import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/core/services/team_logo_service.dart';

final gamesForWeekProvider = FutureProvider.family<List<Game>, int>((ref, week) async {
  return ref.read(nflRepositoryProvider).listGames(season: 2025, week: week);
});

final pickLockedProvider = FutureProvider.family<bool, int>((ref, week) async {
  try {
    // Get the deadline from the NFL repository (first game kickoff time)
    final nflRepo = ref.read(nflRepositoryProvider);
    final deadline = await nflRepo.getPickDeadline(week);
    
    if (deadline == null) {
      print('No deadline found for week $week, picks are locked');
      return true;
    }
    
    final now = DateTime.now();
    final isPassed = now.isAfter(deadline);
    print('Pick deadline for week $week: $deadline, now: $now, passed: $isPassed');
    return isPassed;
  } catch (e) {
    print('Error checking pick deadline: $e');
    return true; // Lock picks if there's an error
  }
});

class MakePickScreen extends ConsumerWidget {
  final String leagueId;
  const MakePickScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Always use current week from provider
    final currentWeekAsync = ref.watch(currentWeekProvider);
    final currentWeek = currentWeekAsync.valueOrNull ?? 4; // Default to week 4
    
    final gamesAsync = ref.watch(gamesForWeekProvider(currentWeek));
    final pickLockedAsync = ref.watch(pickLockedProvider(currentWeek));
    final currentUserAsync = ref.watch(currentUserProvider);
    final userPickAsync = ref.watch(userPickProvider((leagueId, currentWeek)));

    return AppScaffold(
      appBar: AppBar(title: Text('Make Pick - Week $currentWeek')),
      child: gamesAsync.when(
        data: (games) {
          final isLocked = pickLockedAsync.valueOrNull ?? false;
          if (isLocked) {
            return const Center(
              child: Text('Picks are locked for this week!'),
            );
          }
          
          return Column(
            children: [
              // Show deadline information
              Consumer(
                builder: (context, ref, child) {
                  final deadlineStatusAsync = ref.watch(deadlineStatusProvider(currentWeek));
                  final deadlineStatus = deadlineStatusAsync.valueOrNull ?? 'Loading...';
                  final pickLockedAsync = ref.watch(pickLockedProvider(currentWeek));
                  final isDeadlinePassed = pickLockedAsync.valueOrNull ?? true;
                  
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDeadlinePassed ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: isDeadlinePassed ? Colors.red : Colors.blue),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isDeadlinePassed ? Icons.access_time_filled : Icons.access_time,
                          color: isDeadlinePassed ? Colors.red : Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isDeadlinePassed ? 'Pick Deadline Passed' : 'Pick Deadline',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDeadlinePassed ? Colors.red : Colors.blue,
                                ),
                              ),
                              Text(
                                isDeadlinePassed ? 'You can no longer make picks for this week' : deadlineStatus,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDeadlinePassed ? Colors.red : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Show current pick status
              if (userPickAsync.valueOrNull != null)
                Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You have picked: ${userPickAsync.valueOrNull}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemExtent: 200.0, // Fixed height for better performance
                  cacheExtent: 1000.0, // Cache more items for smooth scrolling
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return Card(
                      key: ValueKey(game.id), // Stable key for better widget recycling
                      margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Text(
              'Week $currentWeek - ${ref.read(deadlineServiceProvider).formatUtcToLocal(game.date.toIso8601String())}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Away Team (Left side)
                          Expanded(
                            child: _buildTeamSelection(
                              context,
                              ref,
                              game.awayTeam.abbreviation,
                              game.homeTeam.abbreviation,
                              userPickAsync.valueOrNull,
                              game.id,
                              currentWeek,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '@',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Home Team (Right side)
                          Expanded(
                            child: _buildTeamSelection(
                              context,
                              ref,
                              game.homeTeam.abbreviation,
                              game.awayTeam.abbreviation,
                              userPickAsync.valueOrNull,
                              game.id,
                              currentWeek,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildTeamSelection(
    BuildContext context,
    WidgetRef ref,
    String teamId,
    String opponentId,
    String? selectedTeamId,
    String gameId,
    int currentWeek,
  ) {
    final isSelected = selectedTeamId == teamId;
    final isOpponentSelected = selectedTeamId == opponentId;
    final pickLockedAsync = ref.watch(pickLockedProvider(currentWeek));
    final isDeadlinePassed = pickLockedAsync.valueOrNull ?? true;
    
    print('_buildTeamSelection: teamId=$teamId, selectedTeamId=$selectedTeamId, isSelected=$isSelected, deadlinePassed=$isDeadlinePassed');
    
    return GestureDetector(
      onTap: isDeadlinePassed ? null : () async {
        final currentUser = ref.read(currentUserProvider);
        if (currentUser != null) {
          await ref.read(picksRepositoryProvider).submitPick(
                leagueId: leagueId,
                userId: currentUser.id,
                week: currentWeek,
                teamId: teamId,
              );
          
          // Invalidate providers to refresh data
          ref.invalidate(userPickProvider);
          ref.invalidate(userPicksForWeekProvider);
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Picked $teamId!')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isDeadlinePassed 
            ? Colors.grey.withOpacity(0.3)
            : (isSelected ? Colors.green : (isOpponentSelected ? Colors.grey.withOpacity(0.3) : Colors.blue.withOpacity(0.1))),
          border: Border.all(
            color: isDeadlinePassed 
              ? Colors.grey
              : (isSelected ? Colors.green : (isOpponentSelected ? Colors.grey : Colors.blue)),
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            TeamLogoService.buildTeamLogo(
              teamAbbreviation: teamId,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              teamId,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDeadlinePassed 
                  ? Colors.grey[600]
                  : (isSelected ? Colors.white : (isOpponentSelected ? Colors.grey[600] : Colors.blue)),
              ),
            ),
            if (isDeadlinePassed) ...[
              const SizedBox(height: 4),
              Text(
                'DEADLINE PASSED',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ] else if (!isSelected) ...[
              const SizedBox(height: 4),
              Text(
                'PICK',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ] else ...[
              const SizedBox(height: 4),
              Text(
                'SELECTED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
