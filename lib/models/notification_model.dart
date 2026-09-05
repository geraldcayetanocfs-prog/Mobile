class NotificationModel {
  final String process;
  final String status;
  final String message;
  final String machine;
  final DateTime timestamp;

  NotificationModel({
    required this.process,
    required this.status,
    required this.message,
    required this.machine,
    required this.timestamp,
  });

  bool get isError => status.toLowerCase() == 'failed';

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      process: json['process']?.toString() ?? 'Unknown',
      status: json['status']?.toString() ?? 'Unknown',
      message: json['message']?.toString() ?? '',
      machine: json['machine']?.toString() ?? 'Unknown',
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'process': process,
      'status': status,
      'message': message,
      'machine': machine,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
