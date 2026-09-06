import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:mobile_monitoring/providers/notification_provider.dart';
import '../widgets/summary_card.dart';
import 'notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _refreshNotifications(),
    );
  }

  Future<void> _refreshNotifications() async {
    try {
      await context.read<NotificationProvider>().refreshFromServer();
    } catch (_) {
      // Keep the last known state while the backend is unavailable.
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UiPath Monitor')),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryCard(
                  title: 'Running Bots',
                  count: '${provider.runningCount}',
                  color: Colors.blue,
                  icon: Icons.play_arrow,
                ),
                const SizedBox(height: 12),
                SummaryCard(
                  title: 'Success',
                  count: '${provider.successCount}',
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
                const SizedBox(height: 12),
                SummaryCard(
                  title: 'Faulted',
                  count: '${provider.faultedCount}',
                  color: Colors.red,
                  icon: Icons.error,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    );
                  },
                  child: const Text('Notifications'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
