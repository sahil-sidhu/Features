/*

  Post states

*/

import 'package:chambas/features/Post/domain/model/post_model.dart';

abstract class PostState {}

// initial state
class PostInitial extends PostState {}

// loading state
class PostLoading extends PostState {}

// uploading state
class PostUploading extends PostState {}

// error
class PostError extends PostState {
  final String message;
  PostError({required this.message});
}

// success
class PostLoaded extends PostState {
  final List<PostModel> posts;
  PostLoaded({required this.posts});
}
