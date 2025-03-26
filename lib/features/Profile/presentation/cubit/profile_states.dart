/*

PROFILE STATES

*/

import 'package:chambas/features/Profile/domain/models/profile_model.dart';

abstract class ProfileStates {}

// initial state
class ProfileInitial extends ProfileStates {}

// loading state
class ProfileLoading extends ProfileStates {}

// Loaded stated
class ProfileLoaded extends ProfileStates {
  final ProfileModel profileUser;
  ProfileLoaded(this.profileUser);
}

// error state
class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}
