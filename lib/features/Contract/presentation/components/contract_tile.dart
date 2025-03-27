import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Contract/domain/models/contract_model.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';
import 'package:chambas/features/Profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractTile extends StatefulWidget {
  final ContractModel contract;

  const ContractTile({super.key, required this.contract});

  @override
  State<ContractTile> createState() => _ContractTileState();
}

class _ContractTileState extends State<ContractTile> {
  late ProfileCubit profileCubit;
  String targetUserId = "";

  @override
  void initState() {
    super.initState();

    // Initialize the profile cubit
    profileCubit = context.read<ProfileCubit>();

    // Get the current user Id from AuthCubit
    final String currentUserId = context.read<AuthCubit>().currentUser!.uid;

    // Determine the target user Id
    targetUserId = widget.contract.requesterId == currentUserId
        ? widget.contract.requestedId
        : widget.contract.requesterId;

    // Fetch the profile of the target user (sent or received)
    profileCubit.getUserProfile(targetUid: targetUserId);
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
            subtitle: Text(profile.email,
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            leading: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(uid: targetUserId),
                  ),
                );
              },
              child: const Text("View Contract"),
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
