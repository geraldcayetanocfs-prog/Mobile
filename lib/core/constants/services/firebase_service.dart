import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

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
}