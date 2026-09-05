import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/constants/services/firebase_service.dart'
    as firebase_service;
import 'screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firebaseService = firebase_service.FirebaseService();
  await firebaseService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UiPath Monitor',
      home: const DashboardScreen(),
    );
  }
}
