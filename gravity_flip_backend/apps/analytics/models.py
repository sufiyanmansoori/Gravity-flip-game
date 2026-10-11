from __future__ import annotations

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class EventLog(TimeStampedModel):
    EVENT_TYPE_CHOICES = [
        ('page_view', 'Page View'),
        ('game_start', 'Game Start'),
        ('game_end', 'Game End'),
        ('purchase', 'Purchase'),
        ('login', 'Login'),
        ('logout', 'Logout'),
    ]

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True, related_name='event_logs')
    event_type = models.CharField(max_length=50, choices=EVENT_TYPE_CHOICES)
    route = models.CharField(max_length=255, blank=True, default='')
    payload = models.JSONField(default=dict, blank=True)
    ip_address = models.GenericIPAddressField(blank=True, null=True)

    class Meta:
        db_table = 'event_logs'
        ordering = ['-created_at']

    def __str__(self) -> str:
        return f'{self.event_type} - {self.user.username if self.user else "anonymous"}'


class AnalyticsSnapshot(TimeStampedModel):
    metric_name = models.CharField(max_length=255)
    metric_value = models.FloatField(default=0)
    dimension = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'analytics_snapshots'

    def __str__(self) -> str:
        return f'{self.metric_name}: {self.metric_value}'
