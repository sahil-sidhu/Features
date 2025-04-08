import 'package:flutter/material.dart';

class BrandedProfilePage extends StatelessWidget {
  const BrandedProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branded Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Business Identity",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const CircleAvatar(
                radius: 40, child: Icon(Icons.business, size: 40)),
            const SizedBox(height: 10),
            const Text("Business Name: ChamBas Pvt Ltd"),
            const SizedBox(height: 5),
            const Text("Rating: ⭐⭐⭐⭐☆"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Editing not implemented")),
                );
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
