import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class AnalyticsSession(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='analytics_sessions')
    session_key = models.CharField(max_length=100, unique=True)
    started_at = models.DateTimeField()
    last_seen_at = models.DateTimeField()
    ended_at = models.DateTimeField(null=True, blank=True)
    event_count = models.PositiveIntegerField(default=0)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_analytics_sessions'
        indexes = [models.Index(fields=['user', '-last_seen_at'])]