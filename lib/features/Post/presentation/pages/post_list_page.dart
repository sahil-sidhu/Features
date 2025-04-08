import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import '../../../Post/domain/model/post_model.dart';
import '../../../Post/presentation/cubit/post_cubit.dart';
import '../../../Post/presentation/cubit/post_states.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchAllPosts();
  }

  void requestMatch(
      BuildContext context,
      String receiverId,
      String postId,
      String requesterID,
      String requesterId,
      String requestedId,
      String requesterRole) {
    final senderId = context.read<AuthCubit>().currentUser?.uid;
    if (senderId != null) {
      context.read<MatchCubit>().requestMatch(
            requesterId,
            requestedId,
            senderId,
            receiverId,
            postId,
            requesterRole,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Match request sent!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("You must be logged in to request a match.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Posts"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final filteredPosts = state.posts
                .where((post) =>
                    post.jobTitle
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    post.jobDescription
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                .toList();

            return ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.jobTitle,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(post.jobDescription),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            Text(post.jobLocation),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            Text(post.rating != null
                                ? post.rating!.toStringAsFixed(1)
                                : "No rating"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => requestMatch(
                              context,
                              post.userId ?? '',
                              post.postId,
                              context.read<AuthCubit>().currentUser!.uid,
                              context.read<AuthCubit>().currentUser!.uid,
                              post.userId ?? '',
                              "client",
                            ),
                            child: const Text("Request Match"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load posts'));
          }
        },
      ),
    );
  }
}
