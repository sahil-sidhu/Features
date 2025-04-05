import 'package:flutter/material.dart';

class BusinessAccountPage extends StatefulWidget {
  const BusinessAccountPage({super.key});

  @override
  State<BusinessAccountPage> createState() => _BusinessAccountPageState();
}

class _BusinessAccountPageState extends State<BusinessAccountPage> {
  bool _showFeatures = false;

  void _handleCreateProfile() {
    setState(() {
      _showFeatures = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Account')),
      body: Center(
        child: _showFeatures
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    " Welcome to Business Account!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  FeatureTile(text: "📄 Post unlimited jobs"),
                  FeatureTile(text: "📊 View analytics on your services"),
                  FeatureTile(text: "🔝 Priority matching to top of the list"),
                  FeatureTile(text: "📁 Access service history"),
                  FeatureTile(text: "💬 Premium support access"),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create a Business Account to post multiple jobs!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handleCreateProfile,
                    child: const Text('Create Business Profile'),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
