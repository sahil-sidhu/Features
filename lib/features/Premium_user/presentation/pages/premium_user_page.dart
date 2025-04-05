import 'package:flutter/material.dart';

class PremiumUserPage extends StatefulWidget {
  const PremiumUserPage({super.key, required String planTitle, required List<String> benefits});

  @override
  State<PremiumUserPage> createState() => _PremiumUserPageState();
}

class _PremiumUserPageState extends State<PremiumUserPage> {
  bool _showBenefits = false;

  void _handleUpgrade() {
    setState(() {
      _showBenefits = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium User Benefits')),
      body: Center(
        child: _showBenefits
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    ' Welcome to Premium!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  FeatureTile(text: ' Access to priority job listings'),
                  FeatureTile(text: ' Higher visibility in search results'),
                  FeatureTile(text: ' Unlimited job postings'),
                  FeatureTile(text: ' Premium support access'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Unlock exclusive benefits with a Premium Account!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handleUpgrade,
                    child: const Text('Upgrade to Premium'),
                  ),
                ],
              ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String text;
  const FeatureTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
