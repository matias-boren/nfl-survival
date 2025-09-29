import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/widgets/real_banner_ad.dart';

class BannerAdSlot extends ConsumerWidget {
  final double? height;
  final EdgeInsets? margin;
  final AdSize? adSize;

  const BannerAdSlot({super.key, this.height, this.margin, this.adSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(premiumStatusProvider);

    if (isPremium) {
      return const SizedBox.shrink(); // No ads for premium users
    }

    // Skip ads on web platform
    if (kIsWeb) {
      return const SizedBox.shrink(); // No ads on web
    }

    // Show real banner ad for freemium users on mobile
    return RealBannerAd(
      height: height ?? 50,
      margin: margin,
      adSize: adSize ?? AdSizes.banner,
      backgroundColor: Colors.grey[100],
    );
  }
}
