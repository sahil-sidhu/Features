// Packages for connecting with firebase and firestore

// bring the customer User in the domain layer of Auth feature

import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:chambas/features/Auth/domain/repository/auth_repo_interface.dart';
import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepoInterface {
  // These are singletons by default, sort of like static. Everywhere in the app, we access the same FirebaseAuth instance and same FirebaseFirestore instance.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Verfify that the user is authenticated in the firebase auth collection, if yes, store the retrieved data into the firestore "users" collection
  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        UserModel userModel = UserModel.fromFireBase(user);

        // set the user into the firestore collection
        await _firebaseFirestore.collection("users").doc(userModel.uid).get();

        return userModel;
      } else {
        throw Exception("User is null after authentication");
      }
    } catch (e) {
      throw Exception("Authentication Error: $e");
    }
  }

  // register a new user in firebase auth and in firestore under "users" collection
  @override
  Future<UserModel?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        // Convert the firebase user object into a local userModel
        UserModel userModel = UserModel.fromFireBase(user);

        // store the user in firestore under the "users" collection
        await _firebaseFirestore
            .collection("users")
            .doc(userModel.uid)
            .set(userModel.toJson());

        // create a corresponding ProfileModel
        final profileModel = ProfileModel(
          uid: userModel.uid,
          email: userModel.email,
          firstName: "New",
          lastName: "User",
          dateCreated: DateTime.now(),
        );

        // store the profile in firestore under the "profiles" collection
        await _firebaseFirestore
            .collection("profiles")
            .doc(profileModel.uid)
            .set(profileModel.toJson());

        return userModel;
      } else {
        throw Exception(("User model error during authentication"));
      }
    } catch (e) {
      throw Exception("UserModel data fetch error: $e");
    }
  }

  // sign out method
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;

      if (firebaseUser == null) {
        throw Exception("User is not authenticated");
      }

      // getting the user document from the users collection
      DocumentSnapshot firebaseUserDoc = await _firebaseFirestore
          .collection("users")
          .doc(firebaseUser.uid)
          .get();

      if (firebaseUserDoc.exists) {
        return UserModel.fromFireStore(
            firebaseUserDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception("It seems that this document doesn't exist");
      }
    } catch (e) {
      throw Exception("Error fetching user document: $e");
    }
  }
}
