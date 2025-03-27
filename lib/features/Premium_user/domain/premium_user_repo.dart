abstract class PremiumUserRepo {
  Future<void> subscribeUser(String userId, String plan);
  Future<bool> checkUserSubscription(String userId);
}
