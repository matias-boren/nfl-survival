import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeagueOptionsDialog extends StatelessWidget {
  const LeagueOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('League Options'),
      content: const Text(
        'Choose how you want to participate in leagues:',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        // Create League Option
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/create-league');
            },
            icon: const Icon(Icons.add_circle),
            label: const Text('Create New League'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Join Public Leagues Option
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/join-leagues');
            },
            icon: const Icon(Icons.public),
            label: const Text('Join Public Leagues'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: Colors.green,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Cancel Option
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LeagueOptionsDialog(),
    );
  }
}
