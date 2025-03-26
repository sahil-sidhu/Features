// import 'package:chambas/utils/data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';

// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:flick_video_player/flick_video_player.dart';
// // import 'package:table_calendar/table_calendar.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geolocator/geolocator.dart';

// bool _isUsernameTaken(String username) {
//   for (var user in User.users) {
//     if (user.username == username) {
//       return true;
//     }
//   }
//   return false;
// }

// class User {
//   String? username;
//   String? password;
//   String? email;
//   String? beltColor;

//   User({this.username, this.password, this.email, this.beltColor});

//   static final List<User> users = [
//     User(
//         username: 'user1',
//         password: 'pass1',
//         email: 'user1@example.com',
//         beltColor: 'White'),
//     User(
//         username: 'user2',
//         password: 'pass2',
//         email: 'user2@example.com',
//         beltColor: 'Yellow'),
//   ];

//   User? login(String username, String password) {
//     for (var user in users) {
//       if (user.username == username && user.password == password) {
//         return user;
//       }
//     }
//     return null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'password': password,
//       'email': email,
//       'beltColor': beltColor,
//     };
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       username: json['username'],
//       password: json['password'],
//       email: json['email'],
//       beltColor: json['beltColor'],
//     );
//   }

//   static Future<void> saveUser(User user) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userJson = jsonEncode(user.toJson());
//     await prefs.setString('user_${user.username}', userJson);
//   }

//   static Future<User?> loadUser(String username) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userJson = prefs.getString('user_$username');
//     Map<String, dynamic> userMap = jsonDecode(userJson);
//     return User.fromJson(userMap);
//     return null;
//   }

//   static Future<void> saveUsers(List<User> users) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> userJsonList =
//         users.map((user) => jsonEncode(user.toJson())).toList();
//     await prefs.setStringList('users', userJsonList);
//   }

//   static Future<List<User>> loadUsers() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? userJsonList = prefs.getStringList('users');
//     return userJsonList
//         .map((userJson) => User.fromJson(jsonDecode(userJson)))
//         .toList();
//     return [];
//   }
// }
