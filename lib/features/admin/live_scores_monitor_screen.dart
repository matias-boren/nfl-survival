import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/core/services/live_scores_service.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class LiveScoresMonitorScreen extends ConsumerWidget {
  const LiveScoresMonitorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveScoresAsync = ref.watch(liveScoresProvider);
    final service = ref.watch(liveScoresServiceProvider);
    
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Live Scores Monitor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Manually trigger a score update
              service.getCurrentScores();
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Scores Service Status',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: service.isRunning ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          service.isRunning 
                              ? 'Polling every 15 seconds' 
                              : 'Stopped',
                          style: TextStyle(
                            color: service.isRunning ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Real-time updates for live games',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Controls Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Controls',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: service.isRunning 
                                ? null 
                                : () => service.startPolling(),
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start Polling'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: service.isRunning 
                                ? () => service.stopPolling()
                                : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop Polling'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Live Scores Display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Live Scores',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    liveScoresAsync.when(
                      data: (scores) {
                        if (scores.isEmpty) {
                          return const Center(
                            child: Text('No scores available'),
                          );
                        }
                        
                        final liveGames = scores.where((score) => score.isLive).toList();
                        final completedGames = scores.where((score) => score.status == 'FINAL').toList();
                        final scheduledGames = scores.where((score) => score.status == 'SCHEDULED').toList();
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Summary
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStatItem('Live', liveGames.length, Colors.red),
                                  _buildStatItem('Final', completedGames.length, Colors.green),
                                  _buildStatItem('Scheduled', scheduledGames.length, Colors.blue),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Live Games
                            if (liveGames.isNotEmpty) ...[
                              Text(
                                'Live Games (${liveGames.length})',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ...liveGames.map((score) => _buildScoreCard(score, isLive: true)),
                              const SizedBox(height: 16),
                            ],
                            
                            // Recent Final Games
                            if (completedGames.isNotEmpty) ...[
                              Text(
                                'Recent Final Games (${completedGames.length})',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ...completedGames.take(3).map((score) => _buildScoreCard(score, isLive: false)),
                            ],
                          ],
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Text('Error loading scores: $error'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(LiveScore score, {required bool isLive}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isLive ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isLive ? Colors.red : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            
            // Teams and score
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${score.awayTeam.abbreviation} @ ${score.homeTeam.abbreviation}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (score.homeScore != null && score.awayScore != null)
                    Text(
                      '${score.awayScore} - ${score.homeScore}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            
            // Status and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  score.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isLive ? Colors.red : Colors.grey,
                  ),
                ),
                if (score.timeRemaining != null && score.timeRemaining!.isNotEmpty)
                  Text(
                    score.timeRemaining!,
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
