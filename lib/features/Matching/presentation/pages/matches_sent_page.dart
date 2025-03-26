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
  late final matchCubit = context.read<MatchCubit>();

  @override
  void initState() {
    super.initState();
    // Fetch the outgoing matches for the current user (uid)
    matchCubit.getSentMatches(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sent Matches'),
      ),
      body: BlocBuilder<MatchCubit, MatchState>(builder: (context, state) {
        if (state is MatchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MatchesLoaded) {
          return ListView.builder(
            itemCount: state.matches.length,
            itemBuilder: (context, index) {
              final match = state.matches[index];
              return MatchUserTile(
                user: match,
                isSent: true, // NEW: Mark as sent match
              );
            },
          );
        } else if (state is MatchEmpty) {
          return const Center(child: Text('No matches found'));
        } else if (state is MatchError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Error fetching matches'));
        }
      }),
    );
  }
}
