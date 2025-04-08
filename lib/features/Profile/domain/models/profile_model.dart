import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel extends UserModel {
  // Basic info
  final String firstName;
  final String lastName;

  // Profile details
  final String? profilePicturePath;
  final bool? isServiceProvider;
  final String? phone;
  final String? title;
  final String? description;
  final List<String>? portfolioImages; // List of image URLs
  final List<String>? skills; // List of Skill IDs
  final List<String>? friendsList; // List of user IDs

  // Jobs tracking
  final List<String>? openContracts; // Active contract IDs
  final List<String>? contractHistory; // Completed contract IDs
  final String? subscriptionStatus;

  // Address fields
  final String? unitNumber;
  final String? streetNumber;
  final String? streetName;
  final String? city;
  final String? stateOrProvince;
  final String? zipOrPostal;

  // Reviews and ratings
  final List<String>? reviews; // Review IDs

  // Matches between user 1 -> contract <- user 2
  final List<String>? matches; // IDs of matches for this user

  // Timestamp
  final DateTime dateCreated;

  ProfileModel({
    required String uid,
    required String email,
    String username = '',
    String? photoUrl,
    String userType = 'normal',
    required this.firstName,
    required this.lastName,
    this.profilePicturePath,
    this.isServiceProvider,
    this.phone,
    this.title,
    this.description,
    this.skills,
    this.streetNumber,
    this.streetName,
    this.city,
    this.stateOrProvince,
    this.zipOrPostal,
    this.subscriptionStatus,
    this.unitNumber,
    this.openContracts = const [],
    this.matches = const [],
    this.contractHistory = const [],
    this.reviews = const [],
    this.friendsList = const [],
    this.portfolioImages = const [],
    required this.dateCreated,
  }) : super(
          uid: uid,
          email: email,
          username: username,
          photoUrl: photoUrl,
          userType: userType,
        );

  // Location
  String get location {
    final parts = [
      unitNumber,
      streetNumber,
      streetName,
      city,
      stateOrProvince,
      zipOrPostal
    ];
    final nonNullParts =
        parts.where((part) => part != null && part.isNotEmpty).toList();
    return nonNullParts.join(" ");
  }

  // Method to update profile user
  ProfileModel update({
    String? firstName,
    String? lastName,
    List<String>? openContracts,
    List<String>? matches,
    String? subscriptionStatus,
    String? profilePicturePath,
    bool? isServiceProvider,
    String? phone,
    String? title,
    String? description,
    List<String>? skills,
    String? unitNumber,
    String? streetNumber,
    String? streetName,
    String? city,
    String? stateOrProvince,
    String? zipOrPostal,
    List<String>? contractHistory,
    List<String>? reviews,
    List<String>? friendsList,
    List<String>? portfolioImages,
  }) {
    return ProfileModel(
        uid: uid,
        email: email,
        username: username,
        photoUrl: photoUrl,
        userType: userType,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profilePicturePath: profilePicturePath ?? this.profilePicturePath,
        isServiceProvider: isServiceProvider ?? this.isServiceProvider,
        phone: phone ?? this.phone,
        title: title ?? this.title,
        description: description ?? this.description,
        skills: skills ?? this.skills,
        streetNumber: streetNumber ?? this.streetNumber,
        streetName: streetName ?? this.streetName,
        city: city ?? this.city,
        stateOrProvince: stateOrProvince ?? this.stateOrProvince,
        zipOrPostal: zipOrPostal ?? this.zipOrPostal,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        openContracts: openContracts ?? this.openContracts,
        matches: matches ?? this.matches,
        contractHistory: contractHistory ?? this.contractHistory,
        reviews: reviews ?? this.reviews,
        friendsList: friendsList ?? this.friendsList,
        portfolioImages: portfolioImages ?? this.portfolioImages,
        dateCreated: dateCreated,
        unitNumber: unitNumber ?? this.unitNumber);
  }

  // Convert ProfileModel to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "photoUrl": photoUrl,
      "userType": userType,
      "firstName": firstName,
      "lastName": lastName,
      "profilePicturePath": profilePicturePath,
      "isServiceProvider": isServiceProvider,
      "phone": phone,
      "title": title,
      "description": description,
      "skills": skills,
      "streetNumber": streetNumber,
      "streetName": streetName,
      "city": city,
      "stateOrProvince": stateOrProvince,
      "zipOrPostal": zipOrPostal,
      "subscriptionStatus": subscriptionStatus,
      "openContracts": openContracts,
      "matches": matches,
      "contractHistory": contractHistory,
      "reviews": reviews,
      "dateCreated": dateCreated,
      "friendsList": friendsList,
      "portfolioImages": portfolioImages,
      "unitNumber": unitNumber,
    };
  }

  // Convert from DocumentSnapshot to ProfileModel
  factory ProfileModel.fromFireStore(Map<String, dynamic> data) {
    return ProfileModel(
      uid: data['uid'],
      email: data['email'],
      username: data['username'] ?? '',
      photoUrl: data['photoUrl'],
      userType: data['userType'] ?? 'normal',
      firstName: data['firstName'] as String? ?? "",
      lastName: data['lastName'] as String? ?? "",
      profilePicturePath: data['profilePicturePath'] as String?,
      isServiceProvider: data['isServiceProvider'] as bool? ?? false,
      phone: data['phone'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      skills: (data['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      streetNumber: data['streetNumber'] as String?,
      streetName: data['streetName'] as String?,
      city: data['city'] as String?,
      stateOrProvince: data['stateOrProvince'] as String?,
      zipOrPostal: data['zipOrPostal'] as String?,
      subscriptionStatus: data['subscriptionStatus'] as String?,
      openContracts: (data['openContracts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      matches: (data['matches'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      contractHistory: (data['contractHistory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      reviews: (data['reviews'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      friendsList: (data['friendsList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      portfolioImages: (data['portfolioImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      dateCreated: (data['dateCreated'] as Timestamp).toDate(),
      unitNumber: data['unitNumber'] as String?,
    );
  }
}
