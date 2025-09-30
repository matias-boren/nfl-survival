import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/core/services/week_override_service.dart';
import 'package:nfl_survival/core/services/deadline_service.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class WeekOverrideScreen extends ConsumerStatefulWidget {
  const WeekOverrideScreen({super.key});

  @override
  ConsumerState<WeekOverrideScreen> createState() => _WeekOverrideScreenState();
}

class _WeekOverrideScreenState extends ConsumerState<WeekOverrideScreen> {
  final TextEditingController _weekController = TextEditingController();
  int? _currentOverride;

  @override
  void initState() {
    super.initState();
    _currentOverride = WeekOverrideService.getOverrideWeek();
    if (_currentOverride != null) {
      _weekController.text = _currentOverride.toString();
    }
  }

  @override
  void dispose() {
    _weekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deadlineService = DeadlineService();
    final currentWeek = deadlineService.getCurrentWeek();
    final hasOverride = WeekOverrideService.hasOverride();

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Week Override (Debug)'),
        backgroundColor: Colors.red[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: hasOverride ? Colors.orange[100] : Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Week: $currentWeek',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hasOverride 
                        ? '⚠️ Override Active: Week $_currentOverride'
                        : '✅ Using calculated week',
                      style: TextStyle(
                        color: hasOverride ? Colors.orange[800] : Colors.green[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Set Week Override',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weekController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Week Number (1-18)',
                border: OutlineInputBorder(),
                hintText: 'Enter week number for testing',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _setOverride,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Set Override'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _clearOverride,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Clear Override'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Use this to test the app with different weeks\n'
              '• Set to Week 5 to test the pick system\n'
              '• Clear override to return to normal behavior\n'
              '• This is for development/testing only',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            if (hasOverride)
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Override is active! Remember to clear it when done testing.',
                          style: TextStyle(color: Colors.red[800]),
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

  void _setOverride() {
    final weekText = _weekController.text.trim();
    if (weekText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a week number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final week = int.tryParse(weekText);
    if (week == null || week < 1 || week > 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid week number (1-18)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    WeekOverrideService.setOverrideWeek(week);
    setState(() {
      _currentOverride = week;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Week override set to $week'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearOverride() {
    WeekOverrideService.clearOverride();
    setState(() {
      _currentOverride = null;
    });
    _weekController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Week override cleared'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
