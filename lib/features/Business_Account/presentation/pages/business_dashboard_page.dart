import 'package:flutter/material.dart';

class BusinessDashboardPage extends StatelessWidget {
  const BusinessDashboardPage({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Business Account Dashboard"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Business Partner!",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.group_add, color: Colors.deepPurple),
                title: const Text("Add Team Members"),
                subtitle:
                    const Text("Invite coworkers or HR to manage postings."),
                onTap: () => _navigateTo(context, '/addTeam'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.analytics, color: Colors.deepPurple),
                title: const Text("Post Analytics"),
                subtitle: const Text(
                    "Track reach, clicks, and engagement of your job posts."),
                onTap: () => _navigateTo(context, '/analytics'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.workspace_premium,
                    color: Colors.deepPurple),
                title: const Text("Branded Profile"),
                subtitle:
                    const Text("Showcase your business identity and reviews."),
                onTap: () => _navigateTo(context, '/brandedProfile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
