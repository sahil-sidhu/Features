import 'package:flutter/material.dart';

class PremiumPaymentPage extends StatelessWidget {
  const PremiumPaymentPage({super.key});

  void _simulatePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Upgrade to Premium",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Go Premium Today!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text("Unlock all premium features including:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                const ListTile(
                  leading: Icon(Icons.visibility, color: Colors.deepPurple),
                  title: Text("Priority Post Visibility"),
                ),
                const ListTile(
                  leading: Icon(Icons.search, color: Colors.deepPurple),
                  title: Text("Advanced Job Matching"),
                ),
                const ListTile(
                  leading: Icon(Icons.support_agent, color: Colors.deepPurple),
                  title: Text("24/7 Premium Support"),
                ),
                const ListTile(
                  leading: Icon(Icons.verified_user, color: Colors.deepPurple),
                  title: Text("Verified Badge on your Profile"),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.payment),
                  label: const Text("Pay ₹199.00"),
                  onPressed: () => _simulatePayment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Payments are secured and encrypted.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
