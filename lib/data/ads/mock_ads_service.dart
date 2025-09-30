import 'package:flutter/material.dart';
import 'package:pick1/data/ads/ads_service.dart';

class MockAdsService implements AdsService {
  @override
  Future<void> init() async {
    // Mock: Simulate ad service initialization
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget banner() {
    return Container(
      height: 50,
      color: Colors.blueGrey[100],
      alignment: Alignment.center,
      child: const Text('Mock Ad Banner'),
    );
  }
}
