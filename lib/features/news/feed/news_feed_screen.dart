import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../widgets/premium_gate.dart';
import '../../../widgets/app_scaffold.dart';

class NewsFeedScreen extends ConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumAsync = ref.watch(premiumStatusProvider);
    final isPremium = premiumAsync.value ?? false;
    return AppScaffold(
      appBar: AppBar(title: const Text('News')),
      child: ListView(
        children: [
          const ListTile(title: Text('Mock article: Week 1 preview')), 
          PremiumGate(
            isPremium: isPremium,
            onUpgrade: () => Navigator.of(context).pushNamed('/paywall'),
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: Colors.green)),
              child: const Text('Live score widget (premium)'),
            ),
          ),
        ],
      ),
    );
  }
}

