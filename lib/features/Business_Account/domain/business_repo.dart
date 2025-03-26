import 'package:chambas/features/Business_Account/data/business_account_model.dart';

abstract class BusinessRepo {
  Future<void> createBusinessAccount(BusinessAccountModel business);
  Future<List<BusinessAccountModel>> fetchBusinessAccounts();
}
