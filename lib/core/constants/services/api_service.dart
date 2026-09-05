import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_endpoints.dart';

class ApiService {
  Future<dynamic> getBotStatus() async {
    final response = await http.get(Uri.parse(ApiEndpoints.botStatus));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to load bot status: ${response.statusCode}');
  }

  Future<dynamic> getNotifications() async {
    final response =
        await http.get(Uri.parse(ApiEndpoints.notifications));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed to load notifications: ${response.statusCode}',
    );
  }

  Future<dynamic> sendWebhook(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.webhook),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception('Webhook failed: ${response.statusCode}');
  }

  Future<void> registerDeviceToken(String token) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.registerDevice),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Device registration failed: ${response.statusCode}');
    }
  }
}
