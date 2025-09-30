import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/widgets/app_scaffold.dart';

class AutomatedProcessingScreen extends ConsumerStatefulWidget {
  const AutomatedProcessingScreen({super.key});

  @override
  ConsumerState<AutomatedProcessingScreen> createState() => _AutomatedProcessingScreenState();
}

class _AutomatedProcessingScreenState extends ConsumerState<AutomatedProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    final dataRefreshService = ref.watch(automatedDataRefreshServiceProvider);

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Automated Processing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger manual refresh
              dataRefreshService.processResultsManually();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Manual processing triggered'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          dataRefreshService.isRunning ? Icons.play_circle : Icons.pause_circle,
                          color: dataRefreshService.isRunning ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Automated Data Refresh Service',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dataRefreshService.isRunning 
                        ? '🟢 Running - Checks every 30 minutes' 
                        : '🔴 Stopped',
                      style: TextStyle(
                        color: dataRefreshService.isRunning ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: dataRefreshService.isRunning 
                            ? () {
                                dataRefreshService.stopService();
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Service stopped')),
                                );
                              }
                            : () {
                                dataRefreshService.startService();
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Service started')),
                                );
                              },
                          child: Text(dataRefreshService.isRunning ? 'Stop Service' : 'Start Service'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            dataRefreshService.processResultsManually();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Manual processing triggered')),
                            );
                          },
                          child: const Text('Process Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Service Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How It Works',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The Automated Data Refresh Service:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Runs every 30 minutes to check for finalized games'),
                    const Text('• Processes results 6 hours before the week\'s endDate'),
                    const Text('• Updates team records and processes pick results'),
                    const Text('• Processes all leagues automatically'),
                    const SizedBox(height: 16),
                    const Text(
                      'Timing:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Week endDate: Retrieved from ESPN API'),
                    const Text('• Processing starts: 6 hours before endDate'),
                    const Text('• Example: If week ends at 2025-10-01T06:59Z, processing starts at 2025-10-01T00:59Z'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Current Week Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Week Info',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This information is fetched from the ESPN API:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Current week number'),
                    const Text('• Current season year'),
                    const Text('• Week endDate (when processing will start)'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // This would show current week info
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Current week info would be displayed here'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text('Check Current Week'),
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
}