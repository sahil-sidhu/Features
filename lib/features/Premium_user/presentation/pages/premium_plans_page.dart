import 'package:flutter/material.dart';

class PremiumPlansPage extends StatelessWidget {
  const PremiumPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Premium Plan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upgrade to Premium and Enjoy Exclusive Benefits!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // List of Premium Plans
            Expanded(
              child: ListView(
                children: [
                  premiumPlanCard("Basic Plan",
                      "Access to priority job listings", 9.99, context),
                  premiumPlanCard(
                      "Pro Plan",
                      "Higher visibility & unlimited job postings",
                      19.99,
                      context),
                  premiumPlanCard("Business Plan",
                      "Best for recruiters & companies", 29.99, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Premium Plan Card Widget
  Widget premiumPlanCard(
      String title, String benefits, double price, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(benefits, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("\$$price / month",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Upgrade Button
            ElevatedButton(
              onPressed: () {
                // Later, integrate Firebase and payments here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Upgrading to $title... (Coming soon)")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Center(
                child: Text(
                  "Upgrade to Premium",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
