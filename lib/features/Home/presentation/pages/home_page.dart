import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_states.dart';
import 'package:chambas/features/Home/presentation/components/home_drawer.dart';
import 'package:chambas/features/Post/presentation/components/post_tile.dart';
import 'package:chambas/features/Post/presentation/cubit/post_cubit.dart';
import 'package:chambas/features/Post/presentation/cubit/post_states.dart';
import 'package:chambas/features/Post/presentation/pages/upload_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // grab post cubit
  late final postCubit = context.read<PostCubit>();
  late final authCubit = context.read<AuthCubit>();

  // on startup
  @override
  void initState() {
    super.initState();

    // fetch posts
    fetchAllPosts();
  }

  // call fetch all posts
  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  // delete post
  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPosts();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: const Text("POSTS"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              // upload new post button
              if (authState is Authenticated) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // navigate to the create post page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UploadPostPage();
                        },
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),

      // Drawer
      drawer: const HomeDrawer(),

      // BODY
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          // loading
          if (state is PostLoading || state is PostUploading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // loaded
          else if (state is PostLoaded) {
            final allPosts = state.posts;

            print(allPosts);

            if (allPosts.isEmpty) {
              return const Center(
                child: Text("No posts found"),
              );
            }

            // otherwise, if there are posts
            return ListView.builder(
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                // get individual post
                final post = allPosts[index];

                // post
                return PostTile(
                  post: post,
                  onDeletePressed: () => deletePost(post.postId),
                );
              },
            );
          }

          // error
          else if (state is PostError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
