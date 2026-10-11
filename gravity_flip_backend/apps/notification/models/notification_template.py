from django.db import models

from apps.core.models import TimeStampedModel


class NotificationTemplate(TimeStampedModel):
    class Channel(models.TextChoices):
        IN_APP = 'in_app', 'In app'
        EMAIL = 'email', 'Email'
        SMS = 'sms', 'SMS'
        PUSH = 'push', 'Push'

    code = models.SlugField(max_length=100, unique=True)
    channel = models.CharField(max_length=16, choices=Channel.choices)
    subject = models.CharField(max_length=255, blank=True, default='')
    body = models.TextField()
    is_active = models.BooleanField(default=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_notification_templates'

    def __str__(self):
        return f'{self.code} ({self.channel})'