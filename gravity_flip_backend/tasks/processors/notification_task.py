from celery import shared_task


@shared_task(bind=True, autoretry_for=(ConnectionError, TimeoutError), retry_backoff=True, retry_jitter=True, max_retries=5, queue='notifications')
def deliver_notification_task(self, notification_id):
    from apps.notification.models import Notification
    from apps.notification.services.notification_service import NotificationService
    notification = Notification.objects.select_related('user').get(pk=notification_id)
    return {'id': str(NotificationService.deliver(notification).pk), 'status': notification.status}