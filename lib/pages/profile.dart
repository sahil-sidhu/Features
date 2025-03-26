import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final user = {
    "profilePicture": "carpentry.jpg",
    "name": "Fernando Sanchez Gutierrez",
    "title": "Local Craftsman & Developer",
    "bio": "Passionate about connecting people with the skills they need.",
    "email": "fer.work117@gmail.com",
    "phone": "123-456-7890",
    "location": "Kitchener, Ontario",
    "services": ["Carpentry", "Painting", "Landscaping"],
    "portfolio": [
      {"image": "carpentry.jpg", "description": "Custom Deck"},
      {"image": "carpentry.jpg", "description": "Interior Painting"},
    ],
  };

  MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(user["profilePicture"] as String),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user["name"] as String,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user["title"] as String,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Bio Section
            Text(
              "About Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(user["bio"]! as String, style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            // Contact Section
            Text(
              "Contact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Email: ${user["email"]!}", style: TextStyle(fontSize: 16)),
            Text("Phone: ${user["phone"]!}", style: TextStyle(fontSize: 16)),
            Text("Location: ${user["location"]!}",
                style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            // Services Section
            Text(
              "Services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (user["services"] as List<String>)
                  .map<Widget>((service) =>
                      Text("• $service", style: TextStyle(fontSize: 16)))
                  .toList(),
            ),

            SizedBox(height: 20),

            // Portfolio Section
            Text(
              "Portfolio",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: (user["portfolio"] as List).length,
              itemBuilder: (context, index) {
                final item = (user["portfolio"] as List)[index];
                return Column(
                  children: [
                    Image.asset(
                      user["profilePicture"] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                    SizedBox(height: 4),
                    Text(item["description"]!, style: TextStyle(fontSize: 14)),
                  ],
                );
              },
            ),

            SizedBox(height: 20),

            // Edit Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Edit Profile Page
                },
                child: Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
