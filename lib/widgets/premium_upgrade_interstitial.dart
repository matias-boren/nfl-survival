import 'package:flutter/foundation.dart';
import 'package:nfl_survival/core/services/ad_service.dart';

class PremiumUpgradeInterstitial {
  static final AdService _adService = AdService();
  static bool _isLoading = false;

  // Show interstitial ad before premium upgrade
  static Future<void> showBeforeUpgrade() async {
    if (_isLoading) return;

    // Skip ads on web platform
    if (kIsWeb) {
      print('⚠️ Ads not supported on web platform');
      return;
    }

    _isLoading = true;

    try {
      // Load ad if not already loaded
      if (!_adService.isInterstitialAdReady) {
        await _adService.loadInterstitialAd();
        // Wait a bit for ad to load
        await Future.delayed(const Duration(seconds: 1));
      }

      // Show ad if available
      if (_adService.isInterstitialAdReady) {
        await _adService.showInterstitialAd();
      }
    } catch (e) {
      print('❌ Error showing premium upgrade interstitial: $e');
    } finally {
      _isLoading = false;
    }
  }

  // Show rewarded ad for premium features
  static Future<bool> showRewardedForFeature() async {
    if (_isLoading) return false;

    // Skip ads on web platform
    if (kIsWeb) {
      print('⚠️ Ads not supported on web platform');
      return false;
    }

    _isLoading = true;

    try {
      // Load ad if not already loaded
      if (!_adService.isRewardedAdReady) {
        await _adService.loadRewardedAd();
        // Wait a bit for ad to load
        await Future.delayed(const Duration(seconds: 1));
      }

      // Show ad if available
      if (_adService.isRewardedAdReady) {
        return await _adService.showRewardedAd();
      }
    } catch (e) {
      print('❌ Error showing rewarded ad: $e');
    } finally {
      _isLoading = false;
    }

    return false;
  }

  // Preload ads for better performance
  static Future<void> preloadAds() async {
    // Skip ads on web platform
    if (kIsWeb) {
      print('⚠️ Ads not supported on web platform');
      return;
    }

    try {
      await _adService.loadInterstitialAd();
      await _adService.loadRewardedAd();
    } catch (e) {
      print('❌ Error preloading ads: $e');
    }
  }
}
