import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:chambas/features/Profile/domain/repository/profile_repo_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepoImpl implements ProfileRepoInterface {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileModel?> getUserProfile(String uid) async {
    try {
      // get the document for profile from firestore
      final userProfileDoc =
          await firebaseFirestore.collection('profiles').doc(uid).get();

      if (userProfileDoc.exists) {
        final profileData = userProfileDoc.data();

        if (profileData != null) {
          return ProfileModel.fromFireStore(profileData);
        } else {
          throw Exception("Profile data is empty.");
        }
      } else {
        throw Exception("Profile doest not exist yet.");
      }
    } catch (e) {
      throw Exception("Error connection to 'profiles' collection: $e");
    }
  }

  @override
  Future<void> updateProfile(ProfileModel updatedProfile) async {
    try {
      // convert updated profile to json format to store in firestore
      await firebaseFirestore
          .collection('profiles')
          .doc(updatedProfile.uid)
          .update(updatedProfile.toJson());
    } catch (e) {
      throw Exception("Error connection to 'profiles' collection: $e");
    }
  }
}
