import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Post/presentation/components/post_tile.dart';
import 'package:chambas/features/Post/presentation/cubit/post_cubit.dart';
import 'package:chambas/features/Post/presentation/cubit/post_states.dart';
import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';
import 'package:chambas/features/Profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthCubit authCubit = context.read<AuthCubit>();
  late final ProfileCubit profileCubit = context.read<ProfileCubit>();
  late UserModel? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    final profileUid = widget.uid;
    // Dispatch the event to load the profile when the widget initializes.
    if (currentUser != null) {
      // Load the logged-in user's profile
      profileCubit.getUserProfile(targetUid: currentUser!.uid);
    } else {
      // Handle the case where the user is not authenticated
      // For example, navigate to the login page
      profileCubit.getUserProfile(targetUid: profileUid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileError) {
          return Scaffold(
            body: Center(child: Text("Error: ${state.message}")),
          );
        } else if (state is ProfileLoaded) {
          final user = state.profileUser;
          return _buildProfileScaffold(user);
        } else {
          // ProfileInitial or no profile loaded yet
          return const Scaffold(
            body: Center(child: Text("No profile found.")),
          );
        }
      },
    );
  }

  Widget _buildProfileScaffold(ProfileModel user) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // Use first name, or a fallback if empty
          user.firstName.isNotEmpty ? user.firstName : "Profile",
        ),
      ),
      // Button to edit
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditProfilePage(user: user)),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            // PROFILE IMAGE SECTION
            // Centered image at top
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  // Only apply DecorationImage if we have a URL:
                  image: (user.profilePicturePath != null)
                      ? DecorationImage(
                          image: NetworkImage(user.profilePicturePath!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                // If there's no image, show an icon in the center
                child: (user.profilePicturePath == null)
                    ? const Icon(
                        Icons.person,
                        size: 160,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),

            //  NAME / TITLE / DESCRIPTION
            Center(
              child: Column(
                children: [
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.title != null && user.title!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        user.title!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  if (user.description != null && user.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        user.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CONTACT INFORMATION
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(user.email ?? "No Email"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(user.phone ?? "No Phone"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(_buildAddressText(user)),
                    ),
                  ],
                ),
              ),
            ),

            //  SKILLS & SERVICES
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Skills and Services",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    if (user.skills != null && user.skills!.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: user.skills!
                            .map((skill) => Chip(label: Text(skill)))
                            .toList(),
                      )
                    else
                      const Text("No skills listed."),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.work,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text("Service Provider"),
                      trailing: Switch(
                        value: user.isServiceProvider ?? false,
                        onChanged: (val) {
                          context.read<ProfileCubit>().updateProfile(
                                uid: user.uid,
                                isServiceProvider: val,
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //  PORTFOLIO SECTION
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Portfolio",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    if (user.portfolioImages != null &&
                        user.portfolioImages!.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: user.portfolioImages!.length,
                        itemBuilder: (context, index) {
                          final imageUrl = user.portfolioImages![index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const Text("No portfolio images."),
                  ],
                ),
              ),
            ),

            //  POSTS SECTION
            _buildPostsSection(user),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsSection(ProfileModel user) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          final userPosts =
              state.posts.where((post) => post.userId == user.uid).toList();

          if (userPosts.isEmpty) {
            return const Text("No posts found.");
          }

          return ListView.builder(
            itemCount: userPosts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final post = userPosts[index];
              return PostTile(
                post: post,
                onDeletePressed: () =>
                    context.read<PostCubit>().deletePost(post.userId),
              );
            },
          );
        } else {
          return const Text("No posts found.");
        }
      },
    );
  }

  // Build a single address line from multiple fields
  String _buildAddressText(ProfileModel user) {
    final parts = [
      user.unitNumber,
      user.streetNumber,
      user.streetName,
      user.city,
      user.stateOrProvince,
      user.zipOrPostal,
    ].where((p) => p != null && p.isNotEmpty).toList();

    if (parts.isEmpty) return "No Address";
    return parts.join(", ");
  }
}
