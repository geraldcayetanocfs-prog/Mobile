class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://mobile-jfjy.onrender.com',
  );

  static const String webhook = '$baseUrl/webhook/uipath';
  static const String registerDevice = '$baseUrl/api/devices/register';
  static const String notifications =
      '$baseUrl/api/uipath/notifications';
  static const String botStatus = '$baseUrl/api/uipath/status';
}