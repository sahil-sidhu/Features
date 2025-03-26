import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/business_repo.dart';
import 'business_account_model.dart';

class BusinessRepoImpl implements BusinessRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createBusinessAccount(BusinessAccountModel business) async {
    await firestore
        .collection('business_accounts')
        .doc(business.businessId)
        .set(business.toMap());
  }

  @override
  Future<List<BusinessAccountModel>> fetchBusinessAccounts() async {
    var snapshot = await firestore.collection('business_accounts').get();
    return snapshot.docs
        .map((doc) => BusinessAccountModel.fromMap(doc.data()))
        .toList();
  }
}
