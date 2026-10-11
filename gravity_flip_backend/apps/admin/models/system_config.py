from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class SystemConfig(TimeStampedModel):
    key = models.CharField(max_length=120, unique=True)
    value = models.JSONField(default=dict)
    description = models.TextField(blank=True, default='')
    is_public = models.BooleanField(default=False)
    updated_by = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='updated_system_configs')

    class Meta:
        db_table = 'gravity_system_configs'