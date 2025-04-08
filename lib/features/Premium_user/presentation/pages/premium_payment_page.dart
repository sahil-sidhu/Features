import 'package:flutter/material.dart';

class PremiumPaymentPage extends StatelessWidget {
  const PremiumPaymentPage({super.key});

  void _simulatePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful"),
        content: const Text("Thank you for upgrading to Premium!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Premium Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Upgrade to Premium",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Enjoy benefits like:", style: TextStyle(fontSize: 18)),
            const ListTile(
              leading: Icon(Icons.rocket),
              title: Text("Priority Post Visibility"),
            ),
            const ListTile(
              leading: Icon(Icons.search),
              title: Text("Advanced Job Matching"),
            ),
            const ListTile(
              leading: Icon(Icons.support_agent),
              title: Text("24/7 Premium Support"),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text("Pay ₹199.00"),
              onPressed: () => _simulatePayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
