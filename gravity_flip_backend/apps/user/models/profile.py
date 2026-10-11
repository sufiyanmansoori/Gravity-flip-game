from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class UserProfile(TimeStampedModel):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_profile')
    display_name = models.CharField(max_length=120, blank=True, default='')
    avatar_url = models.URLField(max_length=500, blank=True, default='')
    bio = models.TextField(max_length=500, blank=True, default='')
    country = models.CharField(max_length=2, blank=True, default='')
    timezone = models.CharField(max_length=64, default='UTC')
    birth_year = models.PositiveSmallIntegerField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_user_profiles'

    def __str__(self):
        return self.display_name or self.user.username