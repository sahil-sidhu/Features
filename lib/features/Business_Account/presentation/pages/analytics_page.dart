import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Analytics")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Analytics Overview",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.visibility),
              title: Text("Total Views"),
              trailing: Text("324"),
            ),
            const ListTile(
              leading: Icon(Icons.thumb_up),
              title: Text("Engagement Rate"),
              trailing: Text("85%"),
            ),
            const ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Average Viewing Time"),
              trailing: Text("2 min 30 sec"),
            ),
          ],
        ),
      ),
    );
  }
}
