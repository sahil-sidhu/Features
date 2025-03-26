import 'package:chambas/features/Profile/domain/models/profile_model.dart';

abstract class ProfileRepoInterface {
  Future<ProfileModel?> getUserProfile(String uid);
  Future<void> updateProfile(ProfileModel updatedProfile);
}
