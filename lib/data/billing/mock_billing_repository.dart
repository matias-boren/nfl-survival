import 'dart:async';
import 'package:pick1/data/billing/billing_repositories.dart';

class MockBillingRepository implements BillingRepository {
  final _premiumStatusController = StreamController<bool>.broadcast();
  bool _isPremium = false;

  MockBillingRepository() {
    _premiumStatusController.add(_isPremium);
  }

  @override
  Stream<bool> premiumStatus() => _premiumStatusController.stream;

  @override
  Future<void> restorePurchases() async {
    await Future.delayed(const Duration(seconds: 1));
    _isPremium = true;
    _premiumStatusController.add(_isPremium);
  }

  @override
  Future<bool> startMonthlySubscription() async {
    await Future.delayed(const Duration(seconds: 2));
    _isPremium = true;
    _premiumStatusController.add(_isPremium);
    return _isPremium;
  }

  // Testing method to toggle premium status
  void togglePremiumStatus() {
    _isPremium = !_isPremium;
    _premiumStatusController.add(_isPremium);
  }

  // Testing method to set specific premium status
  void setPremiumStatus(bool isPremium) {
    _isPremium = isPremium;
    _premiumStatusController.add(_isPremium);
  }
}
