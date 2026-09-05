import 'package:flutter/foundation.dart';

import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => [..._notifications];

  bool get hasNotifications => _notifications.isNotEmpty;

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void setNotifications(List<NotificationModel> items) {
    _notifications
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
