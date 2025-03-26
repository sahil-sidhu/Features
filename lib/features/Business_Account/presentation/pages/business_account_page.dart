import 'package:flutter/material.dart';

class BusinessAccountPage extends StatelessWidget {
  const BusinessAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create a Business Account to post multiple jobs!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement business profile creation logic
              },
              child: const Text('Create Business Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
