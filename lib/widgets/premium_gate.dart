import 'package:flutter/material.dart';

class PremiumGate extends StatelessWidget {
  final bool isPremium;
  final Widget child;
  final VoidCallback? onUpgrade;
  const PremiumGate({super.key, required this.isPremium, required this.child, this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    if (isPremium) return child;
    return Stack(
      children: [
        Opacity(opacity: 0.3, child: child),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Premium feature'),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: onUpgrade, child: const Text('Go Premium')),
              ],
            ),
          ),
        )
      ],
    );
  }
}

