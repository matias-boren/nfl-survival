import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/data/models/pick.dart';
import 'package:pick1/features/league/table/league_list_screen.dart';
import 'package:pick1/widgets/app_scaffold.dart';

class ResultProcessingScreen extends ConsumerStatefulWidget {
  const ResultProcessingScreen({super.key});

  @override
  ConsumerState<ResultProcessingScreen> createState() =>
      _ResultProcessingScreenState();
}

class _ResultProcessingScreenState
    extends ConsumerState<ResultProcessingScreen> {
  String? _selectedLeagueId;
  int _selectedWeek = 4;
  bool _isProcessing = false;
  String _lastResult = '';

  @override
  Widget build(BuildContext context) {
    final leaguesAsync = ref.watch(userLeaguesProvider);
    final processResultsAsync = _selectedLeagueId != null
        ? ref.watch(
            processWeekResultsProvider((_selectedLeagueId!, _selectedWeek)),
          )
        : null;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Result Processing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_selectedLeagueId != null) {
                ref.invalidate(
                  processWeekResultsProvider((
                    _selectedLeagueId!,
                    _selectedWeek,
                  )),
                );
              }
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // League Selection
            Text(
              'Select League',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            leaguesAsync.when(
              data: (leagues) {
                if (leagues.isEmpty) {
                  return const Text('No leagues available');
                }

                return DropdownButtonFormField<String>(
                  value: _selectedLeagueId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Choose a league',
                  ),
                  items: leagues.map((league) {
                    return DropdownMenuItem<String>(
                      value: league.id,
                      child: Text(league.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLeagueId = value;
                    });
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),

            const SizedBox(height: 24),

            // Week Selection
            Text(
              'Week',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _selectedWeek.toDouble(),
                    min: 1,
                    max: 18,
                    divisions: 17,
                    label: 'Week $_selectedWeek',
                    onChanged: (value) {
                      setState(() {
                        _selectedWeek = value.toInt();
                      });
                    },
                  ),
                ),
                Text('Week $_selectedWeek'),
              ],
            ),

            const SizedBox(height: 24),

            // Process Results Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectedLeagueId != null && !_isProcessing
                    ? () => _processResults()
                    : null,
                icon: _isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(
                  _isProcessing ? 'Processing...' : 'Process Results',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Results Display
            if (processResultsAsync != null) ...[
              Text(
                'Processing Results',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              processResultsAsync.when(
                data: (summary) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'League: ${summary.leagueId}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Week: ${summary.week}'),
                          Text('Total Picks: ${summary.totalPicks}'),
                          Text('Completed Games: ${summary.completedGames}'),
                          Text(
                            'Eliminated Users: ${summary.eliminatedUsers.length}',
                          ),

                          if (summary.eliminatedUsers.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'Eliminated Users:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...summary.eliminatedUsers.map(
                              (userId) => Text('• $userId'),
                            ),
                          ],

                          const SizedBox(height: 8),
                          const Text(
                            'Processed Picks:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...summary.processedPicks.map((processedPick) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16, top: 4),
                              child: Text(
                                '${processedPick.pick.userId}: ${processedPick.pick.teamId} → ${processedPick.pickResult.name}',
                                style: TextStyle(
                                  color: _getResultColor(
                                    processedPick.pickResult,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('Processing results...'),
                      ],
                    ),
                  ),
                ),
                error: (e, st) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $e'),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // View Standings Button
            if (_selectedLeagueId != null) ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to standings screen
                    // This would be implemented with proper routing
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Standings view would open here'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.leaderboard),
                  label: const Text('View Standings'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _processResults() async {
    if (_selectedLeagueId == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Trigger the result processing
      await ref.read(
        processWeekResultsProvider((_selectedLeagueId!, _selectedWeek)).future,
      );

      setState(() {
        _lastResult = 'Results processed successfully for Week $_selectedWeek';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_lastResult), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      setState(() {
        _lastResult = 'Error processing results: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_lastResult), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Color _getResultColor(PickResult result) {
    switch (result) {
      case PickResult.WIN:
        return Colors.green;
      case PickResult.LOSE:
        return Colors.red;
      case PickResult.PENDING:
        return Colors.grey;
    }
  }
}
