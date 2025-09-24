abstract class BillingRepository {
  Stream<bool> premiumStatus();
  Future<void> restorePurchases();
  Future<bool> startMonthlySubscription();
}
