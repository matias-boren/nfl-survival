import 'dart:async';
import 'package:nfl_survival/data/billing/billing_repositories.dart';

class RevenueCatBillingRepository implements BillingRepository {
  final _premiumStatusController = StreamController<bool>.broadcast();

  RevenueCatBillingRepository() {
    _premiumStatusController.add(false);
  }

  @override
  Stream<bool> premiumStatus() => _premiumStatusController.stream;

  @override
  Future<void> restorePurchases() async {
    // TODO: Implement RevenueCat when dependency is added
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<bool> startMonthlySubscription() async {
    // TODO: Implement RevenueCat when dependency is added
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }
}
