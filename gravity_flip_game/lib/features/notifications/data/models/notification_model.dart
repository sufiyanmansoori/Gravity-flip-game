import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    this.payload,
    this.createdAt,
    this.scheduledAt,
    this.isScheduled = false,
  });

  final String id;
  final String title;
  final String body;
  final String category;
  final Map<String, dynamic>? payload;
  final DateTime? createdAt;
  final DateTime? scheduledAt;
  final bool isScheduled;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id:
          json['id'] as String? ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: json['title'] as String? ?? 'Notification',
      body: json['body'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      payload: json['payload'] != null
          ? Map<String, dynamic>.from(json['payload'] as Map)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.tryParse(json['scheduledAt'] as String)
          : null,
      isScheduled: json['isScheduled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'category': category,
      'payload': payload ?? const <String, dynamic>{},
      'createdAt': createdAt?.toUtc().toIso8601String(),
      'scheduledAt': scheduledAt?.toUtc().toIso8601String(),
      'isScheduled': isScheduled,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? category,
    Map<String, dynamic>? payload,
    DateTime? createdAt,
    DateTime? scheduledAt,
    bool? isScheduled,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    category,
    payload,
    createdAt,
    scheduledAt,
    isScheduled,
  ];
}
