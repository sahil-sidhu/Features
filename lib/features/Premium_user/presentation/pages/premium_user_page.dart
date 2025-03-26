import 'package:flutter/material.dart';

class PremiumUserPage extends StatelessWidget {
  const PremiumUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium User Benefits')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Unlock exclusive benefits with a Premium Account!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment or subscription logic
              },
              child: const Text('Upgrade to Premium'),
            ),
          ],
        ),
      ),
    );
  }
}
