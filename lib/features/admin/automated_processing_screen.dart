import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/core/services/automated_result_processor.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class AutomatedProcessingScreen extends ConsumerWidget {
  const AutomatedProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processor = ref.watch(automatedResultProcessorProvider);
    
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Automated Processing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Manually trigger processing
              processor.processNow();
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Automated Result Processing',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This service automatically processes NFL game results and updates pick outcomes across all leagues.',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: processor.timer != null ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          processor.timer != null 
                              ? 'Running (every 15 minutes)' 
                              : 'Stopped',
                          style: TextStyle(
                            color: processor.timer != null ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: processor.isProcessing ? Colors.orange : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          processor.isProcessing 
                              ? 'Currently Processing...' 
                              : 'Idle',
                          style: TextStyle(
                            color: processor.isProcessing ? Colors.orange : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                            onPressed: processor.timer == null 
                                ? () => processor.startProcessing()
                                : null,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start Processing'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: processor.timer != null 
                                ? () => processor.stopProcessing()
                                : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop Processing'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Manually trigger processing
                          processor.processNow();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Process Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Processing Statistics',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Processed Games: ${processor.processedGames.length}'),
                    const SizedBox(height: 4),
                    Text('Last Processed: ${processor.processedGames.isNotEmpty ? processor.processedGames.last : 'None'}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
