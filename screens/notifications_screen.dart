import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      "process": "EBS",
      "status": "Failed",
      "message": "SAP Login Failed",
    },
    {
      "process": "AR Clearing",
      "status": "Success",
      "message": "Completed",
    },
    {
      "process": "Deposit",
      "status": "Success",
      "message": "Re-run Successful",
    },
    {
      "process": "Invoice Bot",
      "status": "Failed",
      "message": "Timeout Error",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          final bool isFailed =
              item["status"].toString().toLowerCase() == "failed";

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: ListTile(
              leading: Icon(
                isFailed
                    ? Icons.error
                    : Icons.check_circle,
                color: isFailed
                    ? Colors.red
                    : Colors.green,
              ),
              title: Text(
                "${item["process"]} ${item["status"]}",
              ),
              subtitle: Text(
                item["message"],
              ),
            ),
          );
        },
      ),
    );
  }
}