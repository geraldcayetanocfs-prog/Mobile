import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import '../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UiPath Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SummaryCard(
              title: 'Running Bots',
              count: '2',
              color: Colors.blue,
              icon: Icons.play_arrow,
            ),
            const SizedBox(height: 12),
            const SummaryCard(
              title: 'Success',
              count: '10',
              color: Colors.green,
              icon: Icons.check_circle,
            ),
            const SizedBox(height: 12),
            const SummaryCard(
              title: 'Failed',
              count: '1',
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
      ),
    );
  }
}
