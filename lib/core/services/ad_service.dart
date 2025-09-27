import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  // Test Ad Unit IDs (replace with real ones from AdMob)
  static const String _bannerAdUnitIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String _bannerAdUnitIdIOS = 'ca-app-pub-3940256099942544/2934735716';
  static const String _interstitialAdUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String _interstitialAdUnitIdIOS = 'ca-app-pub-3940256099942544/4411468910';
  static const String _rewardedAdUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const String _rewardedAdUnitIdIOS = 'ca-app-pub-3940256099942544/1712485313';

  bool _isInitialized = false;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  // Initialize AdMob
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Skip AdMob initialization on web platform
    if (kIsWeb) {
      print('⚠️ AdMob not supported on web platform');
      _isInitialized = true;
      return;
    }
    
    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      print('✅ AdMob initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize AdMob: $e');
    }
  }

  // Get banner ad unit ID based on platform
  String get bannerAdUnitId {
    if (kIsWeb) {
      return ''; // No ads on web
    } else if (Platform.isAndroid) {
      return _bannerAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return _bannerAdUnitIdIOS;
    }
    throw UnsupportedError('Unsupported platform');
  }

  // Get interstitial ad unit ID based on platform
  String get interstitialAdUnitId {
    if (kIsWeb) {
      return ''; // No ads on web
    } else if (Platform.isAndroid) {
      return _interstitialAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return _interstitialAdUnitIdIOS;
    }
    throw UnsupportedError('Unsupported platform');
  }

  // Get rewarded ad unit ID based on platform
  String get rewardedAdUnitId {
    if (kIsWeb) {
      return ''; // No ads on web
    } else if (Platform.isAndroid) {
      return _rewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return _rewardedAdUnitIdIOS;
    }
    throw UnsupportedError('Unsupported platform');
  }

  // Load interstitial ad
  Future<void> loadInterstitialAd() async {
    if (!_isInitialized) await initialize();
    
    try {
      await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            print('✅ Interstitial ad loaded');
          },
          onAdFailedToLoad: (error) {
            print('❌ Interstitial ad failed to load: $error');
            _interstitialAd = null;
          },
        ),
      );
    } catch (e) {
      print('❌ Error loading interstitial ad: $e');
    }
  }

  // Show interstitial ad
  Future<void> showInterstitialAd() async {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('✅ Interstitial ad showed');
        },
        onAdDismissedFullScreenContent: (ad) {
          print('✅ Interstitial ad dismissed');
          ad.dispose();
          _interstitialAd = null;
          // Load next ad
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('❌ Interstitial ad failed to show: $error');
          ad.dispose();
          _interstitialAd = null;
        },
      );
      await _interstitialAd!.show();
    } else {
      print('⚠️ No interstitial ad available');
    }
  }

  // Load rewarded ad
  Future<void> loadRewardedAd() async {
    if (!_isInitialized) await initialize();
    
    try {
      await RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            print('✅ Rewarded ad loaded');
          },
          onAdFailedToLoad: (error) {
            print('❌ Rewarded ad failed to load: $error');
            _rewardedAd = null;
          },
        ),
      );
    } catch (e) {
      print('❌ Error loading rewarded ad: $e');
    }
  }

  // Show rewarded ad
  Future<bool> showRewardedAd() async {
    if (_rewardedAd != null) {
      bool rewardEarned = false;
      
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('✅ Rewarded ad showed');
        },
        onAdDismissedFullScreenContent: (ad) {
          print('✅ Rewarded ad dismissed');
          ad.dispose();
          _rewardedAd = null;
          // Load next ad
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('❌ Rewarded ad failed to show: $error');
          ad.dispose();
          _rewardedAd = null;
        },
      );
      
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          print('✅ User earned reward: ${reward.amount} ${reward.type}');
          rewardEarned = true;
        },
      );
      
      return rewardEarned;
    } else {
      print('⚠️ No rewarded ad available');
      return false;
    }
  }

  // Check if ads are available
  bool get isInterstitialAdReady => _interstitialAd != null;
  bool get isRewardedAdReady => _rewardedAd != null;

  // Dispose resources
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
