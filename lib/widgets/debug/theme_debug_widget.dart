import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers/theme_provider.dart';

class ThemeDebugWidget extends ConsumerWidget {
  const ThemeDebugWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DEBUG: Current Theme',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          Text(
            'Mode: $currentTheme',
            style: TextStyle(color: Colors.red[700]),
          ),
          ElevatedButton(
            onPressed: () {
              final notifier = ref.read(themeProvider.notifier);
              switch (currentTheme) {
                case AppThemeMode.light:
                  notifier.setTheme(AppThemeMode.darkGrey);
                  break;
                case AppThemeMode.darkGrey:
                  notifier.setTheme(AppThemeMode.dark);
                  break;
                case AppThemeMode.dark:
                  notifier.setTheme(AppThemeMode.light);
                  break;
              }
            },
            child: const Text('Cycle Theme'),
          ),
        ],
      ),
    );
  }
}
