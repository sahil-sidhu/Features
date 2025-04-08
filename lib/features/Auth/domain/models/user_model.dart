import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String? photoUrl;
  final String userType;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    this.photoUrl,
    this.userType = 'normal',
  });

  // convert User to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
      'userType': userType,
    };
  }

  // factory constructors let you create objects from non-traditional sources (like firebase or firestore)

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'] ?? '',
      photoUrl: map['photoUrl'],
      userType: map['userType'] ?? 'normal',
    );
  }
  // convert from json to User
  factory UserModel.fromFireBase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
      username: '',
      photoUrl: '',
      userType: '',
    );
  }

  // convert from DocumentSnapShot to User
  factory UserModel.fromFireStore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] as String,
      email: data['email'] as String,
      username: data['username'],
      photoUrl: data['photoUrl'],
      userType: data['userType'] ?? 'normal',
    );
  }
}
