import 'package:chambas/features/Post/domain/model/post_model.dart';
import 'package:chambas/features/Post/domain/repository/post_repo_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepoImpl implements PostRepoInteface {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Store the posts in a collection called 'posts'
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  @override
  Future<void> createPost(PostModel post) async {
    try {
      await postsCollection.doc(post.postId).set(post.toJson());
    } catch (e) {
      throw Exception("Error creating posts: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  @override
  Future<List<PostModel>> fetchAllPosts() async {
    try {
      // get all posts with most recent posts at the top, convert this to get by radius later since these will be the job posts
      final postsSnapshot =
          await postsCollection.orderBy('timestamp', descending: true).get();

      // convert each firestore document from a json to a list of posts
      final List<PostModel> allPosts = postsSnapshot.docs
          .map((doc) =>
              PostModel.fromFireStore(doc.data() as Map<String, dynamic>))
          .toList();

      return allPosts;
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }

  @override
  Future<List<PostModel>> fetchUserPostsByUserId(String userId) async {
    try {
      // fetch posts snapshot with this uid
      final postsSnpashot =
          await postsCollection.where('userId', isEqualTo: userId).get();

      // map firestone document to a list of posts
      final List<PostModel> userPosts = postsSnpashot.docs
          .map((doc) =>
              PostModel.fromFireStore(doc.data() as Map<String, dynamic>))
          .toList();

      return userPosts;
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }
}
