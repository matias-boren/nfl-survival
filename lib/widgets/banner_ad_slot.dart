import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';

class BannerAdSlot extends ConsumerWidget {
  const BannerAdSlot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(premiumStatusProvider);

    if (isPremium) {
      return const SizedBox.shrink(); // No ads for premium users
    }

    // Placeholder for banner ad
    return Container(
      height: 50,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Text('AD BANNER (Freemium)'),
    );
  }
}
