import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class ModerationCase(TimeStampedModel):
    class Status(models.TextChoices):
        OPEN = 'open', 'Open'
        REVIEWING = 'reviewing', 'Reviewing'
        RESOLVED = 'resolved', 'Resolved'
        DISMISSED = 'dismissed', 'Dismissed'

    class Action(models.TextChoices):
        NONE = 'none', 'None'
        WARN = 'warn', 'Warn'
        SUSPEND = 'suspend', 'Suspend'
        BAN = 'ban', 'Ban'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    subject = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='moderation_cases')
    reporter = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='reported_cases')
    assigned_to = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='assigned_moderation_cases')
    reason = models.CharField(max_length=255)
    details = models.TextField(blank=True, default='')
    status = models.CharField(max_length=16, choices=Status.choices, default=Status.OPEN)
    action = models.CharField(max_length=16, choices=Action.choices, default=Action.NONE)
    resolution = models.TextField(blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_moderation_cases'
        ordering = ['-created_at']
        indexes = [models.Index(fields=['status', '-created_at']), models.Index(fields=['subject', 'status'])]