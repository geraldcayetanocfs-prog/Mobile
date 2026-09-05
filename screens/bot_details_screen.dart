import 'package:flutter/material.dart';

class BotDetailsScreen extends StatelessWidget {
  const BotDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bot Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Bot Name: EBS"),
            Text("Status: Failed"),
            Text("Machine: UAT01"),
            Text("Message: SAP Login Failed"),
          ],
        ),
      ),
    );
  }
}