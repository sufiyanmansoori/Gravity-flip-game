import '../repositories/notification_repository.dart';

class ScheduleNotificationUseCase {
  const ScheduleNotificationUseCase(this.repository);

  final NotificationRepository repository;

  Future<void> call({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String category = 'general',
    Map<String, dynamic>? payload,
  }) async {
    await repository.scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledAt: scheduledAt,
      category: category,
      payload: payload,
    );
  }
}
