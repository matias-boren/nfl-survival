import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'billing_repositories.dart';

class RevenueCatBillingRepository implements BillingRepository {
  final _controller = StreamController<bool>.broadcast();
  bool _isPremium = false;

  RevenueCatBillingRepository() {
    _init();
  }

  Future<void> _init() async {
    try {
      final customerInfo = await rc.Purchases.getCustomerInfo();
      _isPremium = customerInfo.entitlements.active.isNotEmpty;
      _controller.add(_isPremium);
    } catch (e) {
      _controller.add(false);
    }
  }

  @override
  Stream<bool> premiumStatus() => _controller.stream;

  @override
  Future<void> restorePurchases() async {
    try {
      final customerInfo = await rc.Purchases.restorePurchases();
      _isPremium = customerInfo.entitlements.active.isNotEmpty;
      _controller.add(_isPremium);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Future<bool> startMonthlySubscription() async {
    try {
      final offerings = await rc.Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        final package = offerings.current!.availablePackages.first;
        final customerInfo = await rc.Purchases.purchasePackage(package);
        _isPremium = customerInfo.entitlements.active.isNotEmpty;
        _controller.add(_isPremium);
        return _isPremium;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
