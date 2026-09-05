class BotModel {
  final String process;
  final String status;
  final String machine;
  final DateTime timestamp;

  BotModel({
    required this.process,
    required this.status,
    required this.machine,
    required this.timestamp,
  });

  factory BotModel.fromJson(Map<String, dynamic> json) {
    return BotModel(
      process: json['process']?.toString() ?? 'Unknown',
      status: json['status']?.toString() ?? 'Unknown',
      machine: json['machine']?.toString() ?? 'Unknown',
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}