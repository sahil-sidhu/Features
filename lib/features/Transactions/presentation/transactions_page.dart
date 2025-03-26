import 'package:chambas/features/Matching/presentation/pages/matches_received_page.dart';
import 'package:chambas/features/Matching/presentation/pages/matches_sent_page.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  final String uid;
  const TransactionsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            MatchesSentPage(uid: uid), // Pass the uid to Sent Matches page
            // ContractsPage(uid: uid), // If you have a Contracts page, pass the uid as well
            MatchesReceivedPage(uid: uid),
            Placeholder(),
            // FinishedContractsPage(uid: uid), // Same for History page
            Placeholder()
          ],
        ),
      ),
    );
  }
}
