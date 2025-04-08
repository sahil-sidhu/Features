import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final String? imageUrl;
  final bool isAvailable;
  final DateTime timestamp;
  final double? rating;

  PostModel({
    required this.postId,
    required this.userId,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    this.imageUrl,
    required this.isAvailable,
    required this.timestamp,
    this.rating,
  });

  /// Creates a new instance with updated fields
  PostModel update({
    String? jobTitle,
    String? jobDescription,
    String? jobLocation,
    String? imageUrl,
    bool? isAvailable,
    DateTime? timestamp,
  }) {
    return PostModel(
      postId: postId,
      userId: userId,
      jobTitle: jobTitle ?? this.jobTitle,
      jobDescription: jobDescription ?? this.jobDescription,
      jobLocation: jobLocation ?? this.jobLocation,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "userId": userId,
      "jobTitle": jobTitle,
      "jobDescription": jobDescription,
      "jobLocation": jobLocation,
      "imageUrl": imageUrl,
      "isAvailable": isAvailable,
      "timestamp":
          Timestamp.fromDate(timestamp), // Store as Firestore Timestamp
    };
  }

  /// Factory constructor to create an instance from Firestore data
  factory PostModel.fromFireStore(Map<String, dynamic> data) {
    return PostModel(
      postId: data['postId'] ?? '',
      userId: data['userId'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      jobDescription: data['jobDescription'] ?? '',
      jobLocation: data['jobLocation'] ?? '',
      imageUrl: data['imageUrl'],
      isAvailable: data['isAvailable'] ?? false,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      rating: (data['rating'] as num?)?.toDouble(),
    );
  }
}
