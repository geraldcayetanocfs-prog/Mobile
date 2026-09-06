import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/services/firebase_service.dart' as firebase_service;
import 'core/constants/services/api_service.dart';
import 'models/notification_model.dart';
import 'providers/notification_provider.dart';
import 'screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationProvider = NotificationProvider();

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(
      firebase_service.FirebaseService.handleBackgroundMessage,
    );
    final firebaseService = firebase_service.FirebaseService();
    final token = await firebaseService.init();
    firebaseService.listenForNotifications(
      notificationProvider.addNotification,
    );
    if (token != null && token.isNotEmpty) {
      try {
        await ApiService().registerDeviceToken(token);
      } catch (error) {
        debugPrint('FCM token registration skipped: $error');
      }
    }
  } on FirebaseException catch (error) {
    debugPrint('Firebase startup skipped: ${error.message}');
  } catch (error) {
    debugPrint('Firebase startup skipped: $error');
  }

  try {
    final items = await ApiService().getNotifications() as List<dynamic>;
    notificationProvider.setNotifications(
      items
          .whereType<Map<String, dynamic>>()
          .map(NotificationModel.fromJson)
          .toList(),
    );
  } catch (error) {
    debugPrint('Notification history unavailable: $error');
  }

  runApp(MyApp(notificationProvider: notificationProvider));
}

class MyApp extends StatelessWidget {
  final NotificationProvider? notificationProvider;

  const MyApp({super.key, this.notificationProvider});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UiPath Monitor',
      home: const DashboardScreen(),
    );

    if (notificationProvider == null) {
      return ChangeNotifierProvider(
        create: (_) => NotificationProvider(),
        child: app,
      );
    }

    return ChangeNotifierProvider.value(
      value: notificationProvider!,
      child: app,
    );
  }
}
