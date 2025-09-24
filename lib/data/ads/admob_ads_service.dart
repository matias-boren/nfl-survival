import 'package:flutter/material.dart';
import 'package:nfl_survival/data/ads/ads_service.dart';

class AdMobAdsService implements AdsService {
  @override
  Future<void> init() async {
    // TODO: Initialize MobileAds when dependency is added
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget banner() {
    // TODO: Implement actual AdMob banner ad when dependency is added
    return Container(
      height: 50,
      color: Colors.green[100],
      alignment: Alignment.center,
      child: const Text('AdMob Banner (Placeholder)'),
    );
  }
}
