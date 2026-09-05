import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:mobile_monitoring/models/notification_model.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  Future<String?> init() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      if (kDebugMode) {
        debugPrint('Firebase notification permission denied');
      }
      return null;
    }

    final token = await _firebaseMessaging.getToken();

    if (kDebugMode) {
      debugPrint('FCM Token: $token');
    }

    return token;
  }

  Future<String?> getToken() async {
    return _firebaseMessaging.getToken();
  }

  void listenForNotifications(
    void Function(NotificationModel notification) onNotification,
  ) {
    FirebaseMessaging.onMessage.listen((message) {
      final data = message.data;
      onNotification(
        NotificationModel(
          process: data['process']?.toString() ?? 'Firebase',
          status: data['status']?.toString() ?? 'Received',
          message: data['message']?.toString() ??
              message.notification?.body ??
              'New notification received',
          machine: data['machine']?.toString() ?? 'Unknown',
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Background FCM message received: ${message.messageId}');
  }
}