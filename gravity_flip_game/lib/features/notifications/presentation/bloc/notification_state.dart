import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

enum NotificationStatus { initial, loading, success, error }

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const <NotificationModel>[],
    this.message,
  });

  final NotificationStatus status;
  final List<NotificationModel> notifications;
  final String? message;

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationModel>? notifications,
    String? message,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, notifications, message];
}
