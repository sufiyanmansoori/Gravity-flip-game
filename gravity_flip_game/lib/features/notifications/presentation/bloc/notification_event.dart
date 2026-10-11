import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => const [];
}

class NotificationRequested extends NotificationEvent {
  const NotificationRequested({
    required this.title,
    required this.body,
    this.category = 'general',
    this.payload,
  });

  final String title;
  final String body;
  final String category;
  final Map<String, dynamic>? payload;

  @override
  List<Object?> get props => [title, body, category, payload];
}

class NotificationScheduled extends NotificationEvent {
  const NotificationScheduled({
    required this.title,
    required this.body,
    required this.scheduledAt,
    this.category = 'general',
    this.payload,
  });

  final String title;
  final String body;
  final DateTime scheduledAt;
  final String category;
  final Map<String, dynamic>? payload;

  @override
  List<Object?> get props => [title, body, scheduledAt, category, payload];
}

class LoadQueuedNotifications extends NotificationEvent {
  const LoadQueuedNotifications();
}
