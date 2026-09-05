class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const String webhook = '$baseUrl/webhook/uipath';
  static const String notifications =
      '$baseUrl/api/uipath/notifications';
  static const String botStatus = '$baseUrl/api/uipath/status';
}