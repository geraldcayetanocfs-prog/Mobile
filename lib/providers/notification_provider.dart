import 'package:flutter/foundation.dart';

import '../models/notification_model.dart';
import '../core/constants/services/api_service.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => [..._notifications];

  bool get hasNotifications => _notifications.isNotEmpty;

  int get runningCount => _latestByProcessCount({'running', 'in progress'});

  int get successCount => _latestByProcessCount({
    'success',
    'succeeded',
    'successful',
    'completed',
  });

  int get faultedCount => _latestByProcessCount({'failed', 'faulted', 'error'});

  int _latestByProcessCount(Set<String> statuses) {
    final latestByProcess = <String, NotificationModel>{};
    for (final notification in _notifications) {
      latestByProcess.putIfAbsent(notification.process, () => notification);
    }

    return latestByProcess.values
        .where(
          (notification) =>
              statuses.contains(notification.status.trim().toLowerCase()),
        )
        .length;
  }

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

  Future<void> refreshFromServer() async {
    final items = await ApiService().getNotifications() as List<dynamic>;
    setNotifications(
      items
          .whereType<Map<String, dynamic>>()
          .map(NotificationModel.fromJson)
          .toList(),
    );
  }
}
