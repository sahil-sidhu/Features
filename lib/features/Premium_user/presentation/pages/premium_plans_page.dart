import 'package:flutter/material.dart';

class PremiumPlansPage extends StatefulWidget {
  const PremiumPlansPage({super.key});

  @override
  State<PremiumPlansPage> createState() => _PremiumPlansPageState();
}

class _PremiumPlansPageState extends State<PremiumPlansPage> {
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Premium Plan'),
        centerTitle: true,
      ),
      body: selectedPlan == null
          ? _buildPlanSelection()
          : _buildPlanBenefits(selectedPlan!),
    );
  }

  Widget _buildPlanSelection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upgrade to Premium and Enjoy Exclusive Benefits!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _premiumPlanCard(
                  title: "Basic Plan",
                  benefits: "Access to priority job listings",
                  price: 9.99,
                  onPressed: () {
                    setState(() {
                      selectedPlan = "Basic";
                    });
                  },
                ),
                _premiumPlanCard(
                  title: "Pro Plan",
                  benefits: "Higher visibility & unlimited job postings",
                  price: 19.99,
                  onPressed: () {
                    setState(() {
                      selectedPlan = "Pro";
                    });
                  },
                ),
                _premiumPlanCard(
                  title: "Business Plan",
                  benefits: "Best for recruiters & companies",
                  price: 29.99,
                  onPressed: () {
                    setState(() {
                      selectedPlan = "Business";
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanBenefits(String plan) {
    List<String> features = [];
    String heading = "";

    switch (plan) {
      case "Basic":
        heading = "Welcome to Basic Plan!";
        features = [
          "Access to priority job listings",
        ];
        break;
      case "Pro":
        heading = "Welcome to Pro Plan!";
        features = [
          "Higher visibility in search results",
          "Unlimited job postings",
        ];
        break;
      case "Business":
        heading = "Welcome to Business Plan!";
        features = [
          "Best for recruiters & companies",
          "Unlimited job slots",
          "Team management tools",
        ];
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heading,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            for (var feature in features)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  feature,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedPlan = null;
                });
              },
              child: const Text("Back to Plans"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premiumPlanCard({
    required String title,
    required String benefits,
    required double price,
    required VoidCallback onPressed,
  }) {
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
            ElevatedButton(
              onPressed: onPressed,
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
