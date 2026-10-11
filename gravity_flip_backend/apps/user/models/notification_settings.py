from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class NotificationSettings(TimeStampedModel):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_notification_settings')
    push_enabled = models.BooleanField(default=True)
    email_enabled = models.BooleanField(default=True)
    achievement_notifications = models.BooleanField(default=True)
    leaderboard_notifications = models.BooleanField(default=True)
    marketing_notifications = models.BooleanField(default=False)

    class Meta:
        db_table = 'gravity_notification_settings'