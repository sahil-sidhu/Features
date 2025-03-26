import 'package:chambas/features/Matching/domain/models/match_request_model.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart'; // Assuming you have a ProfileCubit to fetch profile data
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';
import 'package:chambas/features/Profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchUserTile extends StatefulWidget {
  final MatchRequestModel user;
  final bool isSent; // Flag to determine if this is a sent request

  const MatchUserTile({super.key, required this.user, required this.isSent});

  @override
  State<MatchUserTile> createState() => _MatchUserTileState();
}

class _MatchUserTileState extends State<MatchUserTile> {
  late final matchCubit = context.read<MatchCubit>();
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = context.read<ProfileCubit>();

    // Fetch the profile of the target user (sent or received)
    final targetUserId =
        widget.isSent ? widget.user.requestedId : widget.user.requesterId;
    profileCubit.getUserProfile(targetUid: targetUserId);
  }

  void acceptMatch() {
    matchCubit.acceptMatch(widget.user.matchId, widget.user.requestedId);
  }

  void declineMatch() {
    matchCubit.declineMatch(widget.user.matchId, widget.user.requestedId);
  }

  void cancelMatch() {
    matchCubit.cancelMatch(widget.user.matchId, widget.user.requesterId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, profileState) {
        if (profileState is ProfileLoading) {
          return const ListTile(
            title: CircularProgressIndicator(),
            subtitle: Text("Loading profile..."),
          );
        } else if (profileState is ProfileLoaded) {
          final profile = profileState.profileUser;

          return ListTile(
            title: Text(profile.firstName),
            subtitle: Text(profile.email),
            subtitleTextStyle:
                TextStyle(color: Theme.of(context).colorScheme.primary),
            leading: widget.isSent
                ? ElevatedButton(
                    onPressed: cancelMatch,
                    child: const Text("Cancel Request"),
                  )
                : ElevatedButton(
                    onPressed: acceptMatch,
                    child: const Text("Accept"),
                  ),
            trailing: widget.isSent
                ? null // No decline button for sent requests
                : ElevatedButton(
                    onPressed: declineMatch,
                    child: const Text("Decline"),
                  ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                    uid: widget.isSent
                        ? widget.user.requestedId
                        : widget.user.requesterId),
              ),
            ),
          );
        } else if (profileState is ProfileError) {
          return ListTile(
            title: const Text("Error loading profile"),
            subtitle: Text(profileState.message),
          );
        } else {
          return const ListTile(
            title: Text("No Profile Data"),
            subtitle: Text("Unable to load profile data"),
          );
        }
      },
    );
  }
}
