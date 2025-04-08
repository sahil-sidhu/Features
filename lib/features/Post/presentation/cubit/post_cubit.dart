import 'dart:typed_data';

import 'package:chambas/features/Post/data/post_repo_impl.dart';
import 'package:chambas/features/Post/domain/model/post_model.dart';
import 'package:chambas/features/Post/presentation/cubit/post_states.dart';
import 'package:chambas/features/Storage/data/storage_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepoImpl postRepo;
  final StorageRepoImpl storageRepo;

  PostCubit({
    required this.postRepo,
    required this.storageRepo,
  }) : super(PostInitial());

  // Load posts (alias to fetchAllPosts for external use)
  void loadPosts() {
    fetchAllPosts();
  }

  // create a new post
  Future<void> createPost(PostModel post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      if (imagePath != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepo.uploadPostImageMobile(imagePath, post.postId);
      } else if (imageBytes != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepo.uploadPostImageWeb(imageBytes, post.postId);
      }

      final newPost = post.update(imageUrl: imageUrl);
      await postRepo.createPost(newPost);
      fetchAllPosts();
    } catch (e) {
      emit(PostError(message: "Error creating post: $e"));
    }
  }

  // fetch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: "Error fetching posts: $e"));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      emit(PostLoading());
      await postRepo.deletePost(postId);
      fetchAllPosts();
    } catch (e) {
      emit(PostError(message: "Error deleting post: $e"));
    }
  }
}
