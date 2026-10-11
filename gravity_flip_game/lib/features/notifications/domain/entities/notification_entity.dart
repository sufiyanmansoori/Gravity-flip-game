import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    this.category = 'general',
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
