import 'dart:async';
import 'package:nfl_survival/data/billing/billing_repositories.dart';

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
}
