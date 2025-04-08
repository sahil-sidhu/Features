import 'package:chambas/features/Matching/presentation/components/match_user_tile.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchesSentPage extends StatefulWidget {
  final String uid;
  const MatchesSentPage({required this.uid, super.key});

  @override
  State<MatchesSentPage> createState() => _MatchesSentPageState();
}

class _MatchesSentPageState extends State<MatchesSentPage> {
  @override
  void initState() {
    super.initState();
    context.read<MatchCubit>().getSentMatches(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchCubit, MatchState>(builder: (context, state) {
      if (state is MatchLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MatchesLoaded) {
        final sentMatches = state.matches
            .where((match) => match.senderId == widget.uid)
            .toList();

        if (sentMatches.isEmpty) {
          return const Center(child: Text('No sent match requests'));
        }

        return ListView.builder(
          itemCount: sentMatches.length,
          itemBuilder: (context, index) {
            final match = sentMatches[index];
            return MatchUserTile(
              user: match,
              isSent: true,
            );
          },
        );
      } else if (state is MatchEmpty) {
        return const Center(child: Text('No sent matches'));
      } else if (state is MatchError) {
        return Center(child: Text('Error: ${state.message}'));
      } else {
        return const Center(child: Text('Unexpected error'));
      }
    });
  }
}
