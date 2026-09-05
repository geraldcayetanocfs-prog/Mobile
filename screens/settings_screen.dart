import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_monitoring/core/constants/services/firebase_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String? _token;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      final token = await _firebaseService.getToken();
      if (!mounted) return;
      setState(() {
        _token = token;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _copyToken() async {
    final token = _token;
    if (token == null || token.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: token));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('FCM token copied')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Firebase Cloud Messaging',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Use this device token when sending a test notification.'),
          const SizedBox(height: 16),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            ListTile(
              leading: const Icon(Icons.error_outline, color: Colors.red),
              title: const Text('Firebase is not available'),
              subtitle: Text(_error!),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Retry',
                onPressed: () {
                  setState(() => _loading = true);
                  _loadToken();
                },
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FCM registration token',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(_token ?? 'No token returned'),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        tooltip: 'Copy token',
                        onPressed: _copyToken,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}