import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Notification(TimeStampedModel):
    class Channel(models.TextChoices):
        IN_APP = 'in_app', 'In app'
        EMAIL = 'email', 'Email'
        SMS = 'sms', 'SMS'
        PUSH = 'push', 'Push'

    class Status(models.TextChoices):
        PENDING = 'pending', 'Pending'
        SENT = 'sent', 'Sent'
        FAILED = 'failed', 'Failed'
        SKIPPED = 'skipped', 'Skipped'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_notifications')
    template = models.ForeignKey('gravity_notification.NotificationTemplate', null=True, blank=True, on_delete=models.SET_NULL, related_name='notifications')
    channel = models.CharField(max_length=16, choices=Channel.choices, default=Channel.IN_APP)
    category = models.CharField(max_length=32, default='system')
    subject = models.CharField(max_length=255, blank=True, default='')
    body = models.TextField()
    status = models.CharField(max_length=16, choices=Status.choices, default=Status.PENDING)
    is_read = models.BooleanField(default=False)
    idempotency_key = models.CharField(max_length=120)
    provider_reference = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)
    sent_at = models.DateTimeField(null=True, blank=True)
    failure_reason = models.TextField(blank=True, default='')

    class Meta:
        db_table = 'gravity_notifications'
        ordering = ['-created_at']
        constraints = [models.UniqueConstraint(fields=['user', 'channel', 'idempotency_key'], name='unique_notification_delivery')]
        indexes = [models.Index(fields=['user', 'is_read', '-created_at']), models.Index(fields=['status', 'channel'])]