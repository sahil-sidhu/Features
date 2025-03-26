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

  // create a new post
  Future<void> createPost(PostModel post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      // handle image upload for mobile platforms using file path
      if (imagePath != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepo.uploadPostImageMobile(imagePath, post.postId);
      }

      // handle image upload for web
      else if (imageBytes != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepo.uploadPostImageWeb(imageBytes, post.postId);
      }

      // give image url to post
      final newPost = post.update(imageUrl: imageUrl);

      // create post in the backend
      postRepo.createPost(newPost);

      // re-fetch all postst
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
      fetchAllPosts(); // might need to remove this later since this is from copilot and not the tutorial
    } catch (e) {
      emit(PostError(message: "Error deleting post: $e"));
    }
  }
}
