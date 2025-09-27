import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nfl_survival/core/services/ad_service.dart';

class RealBannerAd extends StatefulWidget {
  final double? height;
  final AdSize? adSize;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  const RealBannerAd({
    super.key,
    this.height,
    this.adSize,
    this.margin,
    this.backgroundColor,
  });

  @override
  State<RealBannerAd> createState() => _RealBannerAdState();
}

class _RealBannerAdState extends State<RealBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    if (_isAdLoading) return;
    
    // Skip ad loading on web platform
    if (kIsWeb) {
      setState(() {
        _isAdLoading = false;
        _errorMessage = 'Ads not supported on web platform';
      });
      return;
    }
    
    setState(() {
      _isAdLoading = true;
      _errorMessage = null;
    });

    final adService = AdService();
    
    // Initialize AdMob if not already done
    adService.initialize().then((_) {
      _createBannerAd();
    }).catchError((error) {
      setState(() {
        _isAdLoading = false;
        _errorMessage = 'Failed to initialize ads: $error';
      });
    });
  }

  void _createBannerAd() {
    final adService = AdService();
    
    _bannerAd = BannerAd(
      adUnitId: adService.bannerAdUnitId,
      size: widget.adSize ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
            _isAdLoading = false;
            _errorMessage = null;
          });
          print('✅ Banner ad loaded successfully');
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            _isAdLoaded = false;
            _isAdLoading = false;
            _errorMessage = 'Failed to load ad: ${error.message}';
          });
          print('❌ Banner ad failed to load: ${error.message}');
          ad.dispose();
        },
        onAdOpened: (ad) {
          print('✅ Banner ad opened');
        },
        onAdClosed: (ad) {
          print('✅ Banner ad closed');
        },
        onAdClicked: (ad) {
          print('✅ Banner ad clicked');
        },
        onAdImpression: (ad) {
          print('✅ Banner ad impression recorded');
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Don't show ads on web for now
    if (!Platform.isAndroid && !Platform.isIOS) {
      return const SizedBox.shrink();
    }

    if (_isAdLoading) {
      return Container(
        height: widget.height ?? 50,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Container(
        height: widget.height ?? 50,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Ad unavailable',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    if (!_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

// Predefined banner ad sizes
class AdSizes {
  static const AdSize banner = AdSize.banner;
  static const AdSize largeBanner = AdSize.largeBanner;
  static const AdSize mediumRectangle = AdSize.mediumRectangle;
  static const AdSize fullBanner = AdSize.fullBanner;
  static const AdSize leaderboard = AdSize.leaderboard;
  
  // Note: wideSkyscraper and adaptiveBanner are not available in the current version
  // Using banner as fallback
  static const AdSize wideSkyscraper = AdSize.banner;
  static const AdSize adaptiveBanner = AdSize.banner;
}
