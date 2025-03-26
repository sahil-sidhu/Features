import 'package:chambas/features/Post/domain/model/post_model.dart';

abstract class PostRepoInteface {
  Future<List<PostModel>> fetchAllPosts();
  Future<void> createPost(PostModel post);
  Future<void> deletePost(String postId);
  Future<List<PostModel>> fetchUserPostsByUserId(String userId);
}
