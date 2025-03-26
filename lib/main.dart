import 'package:chambas/app.dart';
import 'package:chambas/config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure the widgets binding is initialized first (required for async operations in Flutter)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with specific platform configurations (configured through Firebase console)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app after initializing Firebase and UI auth
  runApp(MyApp());
}
