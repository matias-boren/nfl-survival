import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/data/models/nfl.dart';
import 'package:pick1/widgets/app_scaffold.dart';
import 'package:pick1/widgets/banner_ad_slot.dart';
import 'package:pick1/features/league/table/league_list_screen.dart';
import 'package:pick1/features/league/join/league_options_dialog.dart';
import 'package:pick1/core/services/team_logo_service.dart';

final nextWeekGamesProvider = FutureProvider<List<Game>>((ref) async {
  print('nextWeekGamesProvider called');
  final currentWeekAsync = ref.watch(currentWeekProvider);
  final currentWeek = currentWeekAsync.valueOrNull ?? 4; // Default to week 4
  print('Current week: $currentWeek');
  // Get current week's games
  final games = await ref
      .read(nflRepositoryProvider)
      .listGames(season: 2025, week: currentWeek);
  print(
    'nextWeekGamesProvider got ${games.length} games for week $currentWeek',
  );
  return games;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final gamesAsync = ref.watch(nextWeekGamesProvider);
    final isPremium = ref.watch(premiumStatusProvider);
    final userPicksAsync = ref.watch(userPicksForWeekProvider);

    // Debug output
    print('HomeScreen build - currentUser: $currentUser');
    print('HomeScreen build - gamesAsync: ${gamesAsync.runtimeType}');
    print('HomeScreen build - isPremium: $isPremium');

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Pick1'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      child: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back, ${currentUser?.displayName?.isNotEmpty == true ? currentUser!.displayName : currentUser?.email?.split('@').first ?? 'User'}!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Ready to make your pick?',
                                  style: const TextStyle(
                                    color: Color(0xFF76ABAE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Your Picks Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Picks This Week',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                ref.invalidate(userPicksForWeekProvider);
                              },
                              icon: const Icon(Icons.refresh),
                              tooltip: 'Refresh picks',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        userPicksAsync.when(
                          data: (picks) {
                            print('HomeScreen - userPicksAsync data: $picks');
                            if (picks.isEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.orange.withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.warning,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Text(
                                            'You haven\'t picked a team yet this week',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Consumer(
                                      builder: (context, ref, child) {
                                        final deadlineService = ref.read(
                                          deadlineServiceProvider,
                                        );
                                        final currentWeekAsync = ref.watch(
                                          currentWeekProvider,
                                        );
                                        final currentWeek =
                                            currentWeekAsync.valueOrNull ?? 4;
                                        final timeLeftAsync = ref.watch(
                                          deadlineStatusProvider(currentWeek),
                                        );
                                        final timeLeft =
                                            timeLeftAsync.valueOrNull ??
                                            'Loading...';
                                        return Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              color: Colors.blue,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Time left to make picks: $timeLeft',
                                              style: TextStyle(
                                                color: Colors.blue[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Column(
                              children: picks
                                  .map(
                                    (pick) => Card(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Text(
                                            pick['teamId'].substring(0, 1),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '${pick['teamId']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text('${pick['leagueName']}'),
                                        trailing: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, st) => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.3),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.error, color: Colors.red),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Error loading picks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Make Pick Section
                        Text(
                          'This Week\'s Pick',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              // Check if user has any leagues
                              final userLeagues = await ref.read(
                                userLeaguesProvider.future,
                              );
                              if (userLeagues.isEmpty) {
                                // No leagues, show options dialog
                                LeagueOptionsDialog.show(context);
                              } else {
                                // Has leagues, show league selection screen
                                context.go('/select-league');
                              }
                            },
                            icon: const Icon(Icons.sports_football),
                            label: const Text('Choose Your Team'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Schedule Section
                        Consumer(
                          builder: (context, ref, child) {
                            final currentWeekAsync = ref.watch(
                              currentWeekProvider,
                            );
                            final currentWeek =
                                currentWeekAsync.valueOrNull ?? 4;
                            return Text(
                              'Week $currentWeek Schedule',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        gamesAsync.when(
                          data: (games) {
                            if (games.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No games scheduled for this week.',
                                ),
                              );
                            }
                            return Column(
                              children: games
                                  .map(
                                    (game) => _buildGameCard(
                                      context,
                                      game,
                                      isPremium,
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, st) =>
                              Center(child: Text('Error loading games: $e')),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isPremium) const BannerAdSlot(),
              ],
            ),
    );
  }

  Widget _buildGameCard(BuildContext context, Game game, bool isPremium) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Week ${game.week}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(game.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    game.status.name,
                    style: TextStyle(
                      color: _getStatusColor(game.status),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Away team with logo
                Expanded(
                  child: Row(
                    children: [
                      TeamLogoService.buildTeamLogo(
                        teamAbbreviation: game.awayTeam.abbreviation,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          game.awayTeam.abbreviation,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                // VS or Score
                if (game.awayScore != null &&
                    game.homeScore != null &&
                    isPremium)
                  Text(
                    '${game.awayScore} - ${game.homeScore}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else if (!isPremium &&
                    (game.awayScore != null || game.homeScore != null))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Premium Feature',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const Text(
                    'VS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                // Home team with logo
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          game.homeTeam.abbreviation,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TeamLogoService.buildTeamLogo(
                        teamAbbreviation: game.homeTeam.abbreviation,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatGameTime(game.date.toIso8601String()),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final deadlineService = ref.read(deadlineServiceProvider);
                    
                    // For completed games, show "Final" instead of time
                    if (game.status == GameStatus.FINAL) {
                      return Text(
                        'Final',
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                    
                    // For in-progress games, show "In Progress"
                    if (game.status == GameStatus.IN_PROGRESS) {
                      return Text(
                        'In Progress',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                    
                    // For scheduled games, show time until kickoff
                    final timeUntilKickoff = deadlineService
                        .getTimeUntilKickoff(game.date);
                    return Text(
                      timeUntilKickoff,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(GameStatus status) {
    switch (status) {
      case GameStatus.SCHEDULED:
        return Colors.blue;
      case GameStatus.IN_PROGRESS:
        return Colors.red;
      case GameStatus.FINAL:
        return Colors.green;
    }
  }

  String _formatGameTime(String startIso) {
    try {
      final dateTime = DateTime.parse(startIso).toLocal();
      final formatter = DateTime.now().toString().contains('PM')
          ? 'EEE, MMM d, h:mm a'
          : 'EEE, MMM d, HH:mm';
      return dateTime.toString().split(' ')[0] +
          ' ' +
          dateTime.toString().split(' ')[1].substring(0, 5);
    } catch (e) {
      return 'Time TBD';
    }
  }
}
