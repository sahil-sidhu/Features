import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_states.dart';
import 'package:chambas/features/Auth/presentation/pages/auth_page.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Post/domain/model/post_model.dart';
import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';
import 'package:chambas/features/Review_Rating/presentation/pages/reviews_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTile extends StatefulWidget {
  final PostModel post;
  final void Function()? onDeletePressed;

  const PostTile(
      {super.key, required this.post, required this.onDeletePressed});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  // cubits
  late final profileCubit = context.read<ProfileCubit>();

  // check for current user owner of post
  bool isOwnPost = false;

  // current user
  UserModel? currentUser;

  // post User
  ProfileModel? postUser;

  // on startup
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
    fetchPostUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    final authState = authCubit.state;
    if (authState is Authenticated) {
      currentUser = authCubit.currentUser;
      isOwnPost = widget.post.userId == currentUser!.uid;
      print(isOwnPost);
    } else {
      currentUser = null;
      isOwnPost = false;
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> fetchPostUser() async {
    profileCubit.getUserProfile(targetUid: widget.post.userId);
  }

  // show optionsfor deletion
  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post?"),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          // delete button
          TextButton(
            onPressed: () {
              widget.onDeletePressed!();
              Navigator.of(context).pop();
            },
            child: Text(
              "Delete",
            ),
          ),
        ],
      ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileLoaded &&
            state.profileUser.uid == widget.post.userId) {
          setState(
            () {
              postUser = state.profileUser;
            },
          );
        }
      },
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Align text left
              children: [
                // Top row: Image, Title, Buttons
                Row(
                  children: [
                    // Profile Pic
                    const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person, size: 20),
                    ),
                    const SizedBox(width: 10),
                    // Job Title
                    Expanded(
                      // Prevents overflow
                      child: Text(
                        widget.post.jobTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                    ),
                    // Request Match Button
                    BlocConsumer<AuthCubit, AuthState>(
                      builder: (context, authState) {
                        if (authState is AuthInitial ||
                            authState is Unauthenticated ||
                            authState is AuthFailure) {
                          return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthPage()));
                              },
                              child: Text("Request Match"));
                        } else if (authState is Authenticated) {
                          return Row(
                            children: [
                              ElevatedButton(
                                onPressed: isOwnPost
                                    ? null // Prevents requesting a match on your own post
                                    : () {
                                        final matchCubit =
                                            context.read<MatchCubit>();
                                        matchCubit.requestMatch(
                                            currentUser!.uid,
                                            widget.post.userId,
                                            "client");

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text("Match Requested")),
                                        );
                                      },
                                child: const Icon(Icons.send),
                              ),
                              SizedBox(width: 10),
                              if (isOwnPost)
                                ElevatedButton(
                                  onPressed: showOptions,
                                  child: const Icon(Icons.delete),
                                ),
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator(
                              color: Colors.deepPurple);
                        }
                      },
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Second row: Image + Job Info
                Row(
                  children: [
                    // Profile Image
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(width: 16),
                    // Job Description & Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.jobDescription,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.post.jobLocation,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (widget.post.timestamp
                                    .toString()), // Formats timestamp
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                               TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReviewPage()),
    );
  },
  child: const Text(
    "Reviews",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.blue, // Optional: make it look like a link
    ),
  ),
),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
