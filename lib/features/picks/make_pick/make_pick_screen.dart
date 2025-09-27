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
      child: Column(
        children: [
          // Show previously picked teams
          _buildPreviousPicksSection(ref, currentWeek),
          
          // Games list
          Expanded(
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
                                isDeadlinePassed ? Icons.lock : Icons.access_time,
                                color: isDeadlinePassed ? Colors.red : Colors.blue,
                                size: 24,
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
                                      deadlineStatus,
                                      style: TextStyle(
                                        color: isDeadlinePassed ? Colors.red[700] : Colors.blue[700],
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
                    // Show user's current pick
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
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
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
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
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
                                      const SizedBox(width: 16),
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
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${game.awayScore ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        'VS',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        '${game.homeScore ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        game.status.name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: game.status == GameStatus.FINAL ? Colors.green : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (game.quarter != null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          'Q${game.quarter}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
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
          ),
        ],
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
    
    // Check if this team was already picked in previous weeks
    final userPickedTeamsAsync = ref.watch(userPickedTeamIdsProvider(leagueId));
    final userPickedTeams = userPickedTeamsAsync.valueOrNull ?? <String>{};
    final isAlreadyPicked = userPickedTeams.contains(teamId);
    
    print('_buildTeamSelection: teamId=$teamId, selectedTeamId=$selectedTeamId, isSelected=$isSelected, deadlinePassed=$isDeadlinePassed, alreadyPicked=$isAlreadyPicked');
    
    return GestureDetector(
      onTap: (isDeadlinePassed || isAlreadyPicked) 
        ? () {
            // Show helpful message for disabled teams
            if (isAlreadyPicked) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$teamId was already picked in a previous week!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        : () async {
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
          ref.invalidate(userPickedTeamIdsProvider(leagueId));
          ref.invalidate(userPreviousPicksProvider(leagueId));
          
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
            : isAlreadyPicked
              ? Colors.red.withOpacity(0.3)
              : (isSelected ? Colors.green : (isOpponentSelected ? Colors.grey.withOpacity(0.3) : Colors.blue.withOpacity(0.1))),
          border: Border.all(
            color: isDeadlinePassed 
              ? Colors.grey
              : isAlreadyPicked
                ? Colors.red
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
                  : isAlreadyPicked
                    ? Colors.red[700]
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
            ] else if (isAlreadyPicked) ...[
              const SizedBox(height: 4),
              Text(
                'ALREADY PICKED',
                style: TextStyle(
                  color: Colors.red[700],
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

  Widget _buildPreviousPicksSection(WidgetRef ref, int currentWeek) {
    final userPreviousPicksAsync = ref.watch(userPreviousPicksProvider(leagueId));
    
    return userPreviousPicksAsync.when(
      data: (previousPicks) {
        if (previousPicks.isEmpty) {
          return const SizedBox.shrink(); // Don't show anything if no previous picks
        }
        
        // Filter out current week's pick
        final pastPicks = previousPicks.where((pick) => pick.week < currentWeek).toList();
        
        if (pastPicks.isEmpty) {
          return const SizedBox.shrink();
        }
        
        return Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Teams Already Picked:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: pastPicks.map((pick) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TeamLogoService.buildTeamLogo(
                        teamAbbreviation: pick.teamId,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${pick.teamId} (Week ${pick.week})',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
    );
  }
}