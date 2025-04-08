import 'package:chambas/features/Matching/presentation/components/match_user_tile.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchesReceivedPage extends StatefulWidget {
  final String uid;
  const MatchesReceivedPage({required this.uid, super.key});

  @override
  State<MatchesReceivedPage> createState() => _MatchesReceivedPageState();
}

class _MatchesReceivedPageState extends State<MatchesReceivedPage> {
  @override
  void initState() {
    super.initState();
    context.read<MatchCubit>().getIncomingMatches(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchCubit, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MatchesLoaded) {
          final receivedMatches = state.matches
              .where((match) => match.receiverId == widget.uid)
              .toList();

          if (receivedMatches.isEmpty) {
            return const Center(child: Text('No received match requests'));
          }

          return ListView.builder(
            itemCount: receivedMatches.length,
            itemBuilder: (context, index) {
              final match = receivedMatches[index];
              return MatchUserTile(
                user: match,
                isSent: false,
              );
            },
          );
        } else if (state is MatchEmpty) {
          return const Center(child: Text('No received matches'));
        } else if (state is MatchError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Unexpected error'));
        }
      },
    );
  }
}
