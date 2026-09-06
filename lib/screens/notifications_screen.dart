import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_monitoring/providers/notification_provider.dart';
import 'package:mobile_monitoring/widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (!provider.hasNotifications) {
            return const Center(
              child: Text('No notifications received yet'),
            );
          }

          return ListView.builder(
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return NotificationCard(
                title:
                    '${notification.process} ${notification.status}',
                body:
                    '${notification.message} • ${notification.machine}',
              );
            },
          );
        },
      ),
    );
  }
}
