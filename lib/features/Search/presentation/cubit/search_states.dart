import 'package:chambas/features/Profile/domain/models/profile_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProfileModel?> users;
  SearchLoaded(this.users);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
