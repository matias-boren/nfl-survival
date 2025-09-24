import 'dart:async';

abstract class BillingRepository {
  Stream<bool> premiumStatus();
  Future<void> restorePurchases();
  Future<bool> startMonthlySubscription();
}

class MockBillingRepository implements BillingRepository {
  final _controller = StreamController<bool>.broadcast();
  bool _isPremium = false;

  MockBillingRepository() {
    _controller.add(_isPremium);
  }

  @override
  Stream<bool> premiumStatus() => _controller.stream;

  @override
  Future<void> restorePurchases() async {
    _controller.add(_isPremium);
  }

  @override
  Future<bool> startMonthlySubscription() async {
    _isPremium = true;
    _controller.add(true);
    return true;
  }
}

