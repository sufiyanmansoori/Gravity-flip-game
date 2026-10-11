import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required this._repository})
    : super(const NotificationState()) {
    on<NotificationRequested>(_onNotificationRequested);
    on<NotificationScheduled>(_onNotificationScheduled);
    on<LoadQueuedNotifications>(_onLoadQueuedNotifications);
  }

  final NotificationRepository _repository;

  Future<void> _onNotificationRequested(
    NotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    try {
      await _repository.sendNotification(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        title: event.title,
        body: event.body,
        category: event.category,
        payload: event.payload,
      );

      emit(
        state.copyWith(
          status: NotificationStatus.success,
          message: 'Notification sent successfully.',
        ),
      );
      add(const LoadQueuedNotifications());
    } catch (_) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          message: 'Failed to send notification.',
        ),
      );
    }
  }

  Future<void> _onNotificationScheduled(
    NotificationScheduled event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    try {
      await _repository.scheduleNotification(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        title: event.title,
        body: event.body,
        scheduledAt: event.scheduledAt,
        category: event.category,
        payload: event.payload,
      );

      emit(
        state.copyWith(
          status: NotificationStatus.success,
          message: 'Notification scheduled successfully.',
        ),
      );
      add(const LoadQueuedNotifications());
    } catch (_) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          message: 'Failed to schedule notification.',
        ),
      );
    }
  }

  Future<void> _onLoadQueuedNotifications(
    LoadQueuedNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    try {
      final notifications = <NotificationModel>[];
      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          message: 'Failed to load queued notifications.',
        ),
      );
    }
  }
}
