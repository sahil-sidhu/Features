import 'package:flutter/material.dart';

class BusinessDashboardPage extends StatelessWidget {
  const BusinessDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Business Account")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Welcome, Business Partner!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.group_add),
            title: Text("Add Team Members"),
            subtitle: Text("Invite coworkers or HR to manage postings."),
          ),
          const ListTile(
            leading: Icon(Icons.analytics),
            title: Text("Post Analytics"),
            subtitle:
                Text("Track reach, clicks, and engagement of your job posts."),
          ),
          const ListTile(
            leading: Icon(Icons.workspace_premium),
            title: Text("Branded Profile"),
            subtitle: Text("Showcase your business identity and reviews."),
          ),
        ],
      ),
    );
  }
}
