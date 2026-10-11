abstract class NotificationRepository {
  Future<void> initialize();

  Future<void> sendNotification({
    required String id,
    required String title,
    required String body,
    String category = 'general',
    Map<String, dynamic>? payload,
  });

  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String category = 'general',
    Map<String, dynamic>? payload,
  });
}
