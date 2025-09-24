import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';

class PremiumGate extends ConsumerWidget {
  final Widget gatedChild;
  final String featureName;

  const PremiumGate({
    super.key,
    required this.gatedChild,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    if (isPremium) {
      return gatedChild;
    }

    return Stack(
      children: [
        // Blurred content
        AbsorbPointer(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.withValues(alpha: 0.6),
                BlendMode.saturation,
              ),
              child: gatedChild,
            ),
          ),
        ),
        // Premium CTA overlay
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Unlock $featureName with Premium!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/paywall'),
                  child: const Text('Go Premium'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
