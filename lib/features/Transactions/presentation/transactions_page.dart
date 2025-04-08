import 'package:chambas/features/Matching/presentation/pages/matches_received_page.dart';
import 'package:chambas/features/Matching/presentation/pages/matches_sent_page.dart';
import 'package:chambas/features/Matching/data/match_repo_impl.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  final String uid;
  const TransactionsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchCubit(matchRepo: MatchRepoImpl()),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Transactions'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.send), text: 'Sent Matches'),
                Tab(
                    icon: Icon(Icons.mark_chat_read_sharp),
                    text: 'Received Matches'),
                Tab(icon: Icon(Icons.assignment), text: 'Contracts'),
                Tab(icon: Icon(Icons.assignment_turned_in), text: 'History'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MatchesSentPage(uid: uid),
              MatchesReceivedPage(uid: uid),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.business_center,
                        size: 100, color: Colors.purple),
                    SizedBox(height: 20),
                    Text(
                      'Business Account Features Coming Soon!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Advanced analytics, job boosts, and more.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.stars_rounded, size: 100, color: Colors.amber),
                    SizedBox(height: 20),
                    Text(
                      'Premium Features Coming Soon!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Access to top talent, faster hires, exclusive tools.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
