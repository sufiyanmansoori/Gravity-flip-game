import '../repositories/notification_repository.dart';

class SendNotificationUseCase {
  const SendNotificationUseCase(this.repository);

  final NotificationRepository repository;

  Future<void> call({
    required String id,
    required String title,
    required String body,
    String category = 'general',
    Map<String, dynamic>? payload,
  }) async {
    await repository.sendNotification(
      id: id,
      title: title,
      body: body,
      category: category,
      payload: payload,
    );
  }
}
