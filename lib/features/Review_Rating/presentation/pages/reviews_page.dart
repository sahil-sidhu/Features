import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'name': 'Aman Gill',
        'rating': 5,
        'comment': 'Great service, highly professional!',
        'date': 'April 1, 2025'
      },
      {
        'name': 'Nimrat Kaur',
        'rating': 4,
        'comment': 'Good work, but arrived 10 minutes late.',
        'date': 'March 29, 2025'
      },
      {
        'name': 'Yograj Singh',
        'rating': 3,
        'comment': 'Average experience. Could be better.',
        'date': 'March 27, 2025'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("User Reviews")),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(review['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['comment'] as String),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < (review['rating'] as int)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    review['date'] as String,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
