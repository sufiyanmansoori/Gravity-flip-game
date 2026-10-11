from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class UserPreferences(TimeStampedModel):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_preferences')
    language = models.CharField(max_length=10, default='en')
    theme = models.CharField(max_length=20, default='system')
    reduced_motion = models.BooleanField(default=False)
    vibration_enabled = models.BooleanField(default=True)
    sound_enabled = models.BooleanField(default=True)
    analytics_enabled = models.BooleanField(default=True)

    class Meta:
        db_table = 'gravity_user_preferences'