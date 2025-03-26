import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Profile/domain/repository/profile_repo_interface.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';
import 'package:chambas/features/Storage/domain/storage_repo_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepoInterface profileRepoInterface;
  final StorageRepoInterface storageRepoInterface;
  final AuthCubit authCubit;

  // constructor
  ProfileCubit(
      {required this.profileRepoInterface,
      required this.storageRepoInterface,
      required this.authCubit})
      : super(ProfileInitial());

  Future<void> getUserProfile({String? targetUid}) async {
    try {
      emit(ProfileLoading());

      final uid = targetUid ??
          authCubit.currentUser
              ?.uid; // Use targetUid if provided, else use currentUser
      if (uid == null) {
        emit(ProfileError("User not authenticated or target UID missing"));
        return;
      }

      final profile = await profileRepoInterface.getUserProfile(uid);
      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        emit(ProfileError("Profile not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String uid,
    bool? isServiceProvider,
    String? firstName,
    String? lastName,
    String? profilePicturePath,
    String? phone,
    String? title,
    String? description,
    List<String>? skills,
    String? unitNumber,
    String? streetNumber,
    String? streetName,
    String? city,
    String? stateOrProvince,
    String? zipOrPostal,
    String? subscriptionStatus,
    List<String>? openContracts,
    List<String>? matches,
    List<String>? contractHistory,
    List<String>? reviews,
    List<String>? friendsList,
    List<String>? portfolioImages,
  }) async {
    emit(ProfileLoading());
    try {
      // Fetch the current profile
      final currentUser = await profileRepoInterface.getUserProfile(uid);

      if (currentUser != null) {
        // Create an updated profile with the new values
        final updatedProfile = currentUser.update(
          firstName: firstName,
          lastName: lastName,
          profilePicturePath: profilePicturePath,
          isServiceProvider: isServiceProvider,
          phone: phone,
          title: title,
          description: description,
          skills: skills,
          unitNumber: unitNumber,
          streetNumber: streetNumber,
          streetName: streetName,
          city: city,
          stateOrProvince: stateOrProvince,
          zipOrPostal: zipOrPostal,
          subscriptionStatus: subscriptionStatus,
          openContracts: openContracts,
          matches: matches,
          contractHistory: contractHistory,
          reviews: reviews,
          friendsList: friendsList,
          portfolioImages: portfolioImages,
        );

        // Update the profile in Firestore
        await profileRepoInterface.updateProfile(updatedProfile);

        // Emit the updated profile
        emit(ProfileLoaded(updatedProfile));
      } else {
        emit(ProfileError("Current user not found"));
      }
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}
