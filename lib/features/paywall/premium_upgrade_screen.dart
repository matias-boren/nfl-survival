import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/app/theme/theme_extensions.dart';

class PremiumUpgradeScreen extends ConsumerStatefulWidget {
  const PremiumUpgradeScreen({super.key});

  @override
  ConsumerState<PremiumUpgradeScreen> createState() =>
      _PremiumUpgradeScreenState();
}

class _PremiumUpgradeScreenState extends ConsumerState<PremiumUpgradeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _upgradeToPremium() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate premium upgrade (replace with real payment processing)
      await Future.delayed(const Duration(seconds: 2));

      // Update premium status
      await ref.read(authRepositoryProvider).updatePremiumStatus(true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Welcome to Premium!'),
            backgroundColor: const Color(0xFF76ABAE),
          ),
        );

        // Navigate back
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: const Color(0xFFFF6B6B),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Premium'),
        backgroundColor: appColors.premium ?? theme.colorScheme.tertiary,
        foregroundColor: appColors.onTertiary ?? theme.colorScheme.onTertiary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Premium header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (appColors.premium ?? theme.colorScheme.tertiary)
                        .withOpacity(0.8),
                    (appColors.premium ?? theme.colorScheme.tertiary),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.star, size: 64, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),
                  const Text(
                    'Pick1 Premium',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEEEEEE),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Unlock all features and remove ads',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Features list
            const Text(
              'Premium Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _buildFeatureItem(
              icon: Icons.visibility,
              title: 'Advanced Analytics',
              description: 'Detailed performance insights and statistics',
            ),
            _buildFeatureItem(
              icon: Icons.analytics,
              title: 'Advanced Analytics',
              description: 'Detailed statistics and insights',
            ),
            _buildFeatureItem(
              icon: Icons.group,
              title: 'Unlimited Leagues',
              description: 'Join and create unlimited leagues',
            ),
            _buildFeatureItem(
              icon: Icons.notifications,
              title: 'Push Notifications',
              description: 'Get notified about game results and updates',
            ),
            _buildFeatureItem(
              icon: Icons.block,
              title: 'Ad-Free Experience',
              description: 'Enjoy the app without any advertisements',
            ),

            const SizedBox(height: 32),

            // Upgrade button
            ElevatedButton(
              onPressed: _isLoading ? null : _upgradeToPremium,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    appColors.premium ?? theme.colorScheme.tertiary,
                foregroundColor:
                    appColors.onTertiary ?? theme.colorScheme.onTertiary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          appColors.onTertiary ?? theme.colorScheme.onTertiary,
                        ),
                      ),
                    )
                  : const Text(
                      'Upgrade to Premium - \$4.99/month',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),

            const SizedBox(height: 16),

            // Restore purchases button
            OutlinedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Restore purchases feature coming soon',
                          ),
                          backgroundColor: const Color(0xFFFFD93D),
                        ),
                      );
                    },
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    appColors.premium ?? theme.colorScheme.tertiary,
                side: BorderSide(
                  color: appColors.premium ?? theme.colorScheme.tertiary,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Restore Purchases',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 24),

            // Terms and privacy
            Text(
              'By upgrading, you agree to our Terms of Service and Privacy Policy. Subscription automatically renews unless cancelled at least 24 hours before the end of the current period.',
              style: const TextStyle(fontSize: 12, color: Color(0xFF76ABAE)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  (appColors.premiumContainer ??
                          theme.colorScheme.tertiaryContainer)
                      .withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: appColors.premium ?? theme.colorScheme.tertiary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF76ABAE),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
