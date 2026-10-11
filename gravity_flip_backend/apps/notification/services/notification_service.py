from django.db import IntegrityError, transaction
from django.utils import timezone

from ..models import Notification
from .email_service import EmailService
from .push_service import PushService
from .sms_service import SMSService
from .notification_template_service import NotificationTemplateService


class NotificationService:
    channels = {'email': EmailService, 'sms': SMSService, 'push': PushService}

    @staticmethod
    def allowed(user, channel, category):
        if channel == Notification.Channel.IN_APP:
            return True
        settings = getattr(user, 'gravity_notification_settings', None)
        if not settings:
            return False
        if channel == 'email' and not settings.email_enabled:
            return False
        if channel == 'push' and not settings.push_enabled:
            return False
        if category == 'achievement' and not settings.achievement_notifications:
            return False
        if category == 'leaderboard' and not settings.leaderboard_notifications:
            return False
        if category == 'marketing' and not settings.marketing_notifications:
            return False
        return True

    @classmethod
    @transaction.atomic
    def create(cls, *, user, channel, category, idempotency_key, subject='', body='', template=None, context=None, metadata=None):
        if template:
            subject, body = NotificationTemplateService.render(template, context or {})
        if not cls.allowed(user, channel, category):
            status = Notification.Status.SKIPPED
        else:
            status = Notification.Status.PENDING
        try:
            notification, created = Notification.objects.get_or_create(user=user, channel=channel, idempotency_key=idempotency_key, defaults={'template': template, 'category': category, 'subject': subject, 'body': body, 'status': status, 'metadata': metadata or {}})
        except IntegrityError:
            notification = Notification.objects.get(user=user, channel=channel, idempotency_key=idempotency_key)
            created = False
        return notification, created

    @classmethod
    @transaction.atomic
    def deliver(cls, notification):
        if notification.status in {Notification.Status.SENT, Notification.Status.SKIPPED}:
            return notification
        if notification.channel == Notification.Channel.IN_APP:
            result = {'accepted': True}
        else:
            result = cls.channels[notification.channel].send(user=notification.user, subject=notification.subject, body=notification.body, metadata=notification.metadata) if notification.channel == 'push' else cls.channels[notification.channel].send(user=notification.user, subject=notification.subject, body=notification.body) if notification.channel == 'email' else cls.channels[notification.channel].send(user=notification.user, body=notification.body)
        notification.status = Notification.Status.SENT
        notification.sent_at = timezone.now()
        notification.provider_reference = str(result.get('recipient', ''))
        notification.save(update_fields=['status', 'sent_at', 'provider_reference', 'updated_at'])
        return notification

    @staticmethod
    @transaction.atomic
    def mark_read(notification):
        notification.is_read = True
        notification.save(update_fields=['is_read', 'updated_at'])
        return notification