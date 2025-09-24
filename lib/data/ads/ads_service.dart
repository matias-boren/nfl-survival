import 'package:flutter/widgets.dart';

abstract class AdsService {
  Future<void> init();
  Widget banner();
}

class DevNoopAdsService implements AdsService {
  @override
  Future<void> init() async {}

  @override
  Widget banner() {
    return const SizedBox.shrink();
  }
}

