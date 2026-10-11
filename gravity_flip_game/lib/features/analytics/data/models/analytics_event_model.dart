import 'package:equatable/equatable.dart';

class AnalyticsEventModel extends Equatable {
  const AnalyticsEventModel({
    required this.name,
    required this.timestamp,
    this.userId,
    this.properties = const <String, dynamic>{},
  });

  final String name;
  final DateTime timestamp;
  final String? userId;
  final Map<String, dynamic> properties;

  factory AnalyticsEventModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsEventModel(
      name: json['name'] as String? ?? 'unknown_event',
      timestamp:
          DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.now(),
      userId: json['userId'] as String?,
      properties: Map<String, dynamic>.from(
        json['properties'] as Map? ?? const {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'userId': userId,
      'properties': properties,
    };
  }

  AnalyticsEventModel copyWith({
    String? name,
    DateTime? timestamp,
    String? userId,
    Map<String, dynamic>? properties,
  }) {
    return AnalyticsEventModel(
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      properties: properties ?? this.properties,
    );
  }

  @override
  List<Object?> get props => [name, timestamp, userId, properties];
}
