import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/premium_user_repo.dart';
import 'premium_user_model.dart';

class PremiumUserRepoImpl implements PremiumUserRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> subscribeUser(String userId, String plan) async {
    await firestore.collection('premium_users').doc(userId).set({
      'userId': userId,
      'subscriptionPlan': plan,
      'expiryDate': DateTime.now().add(Duration(days: 30)).toIso8601String(),
    });
  }

  @override
  Future<bool> checkUserSubscription(String userId) async {
    var doc = await firestore.collection('premium_users').doc(userId).get();
    return doc.exists;
  }
}
