import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({
    required this.uid,
    required this.email,
  });

  // convert User to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  // factory constructors let you create objects from non-traditional sources (like firebase or firestore)

  // convert from json to User
  factory UserModel.fromFireBase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
    );
  }

  // convert from DocumentSnapShot to User
  factory UserModel.fromFireStore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] as String,
      email: data['email'] as String,
    );
  }
}
