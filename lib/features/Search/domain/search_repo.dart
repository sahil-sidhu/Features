import 'package:chambas/features/Profile/domain/models/profile_model.dart';

abstract class SearchRepo {
  Future<List<ProfileModel?>> searchUsers(String query);
}
