import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Event(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='analytics_events')
    name = models.CharField(max_length=80)
    session_key = models.CharField(max_length=100, blank=True, default='')
    route = models.CharField(max_length=255, blank=True, default='')
    payload = models.JSONField(default=dict, blank=True)
    client_timestamp = models.DateTimeField(null=True, blank=True)
    idempotency_key = models.CharField(max_length=120)
    ip_address = models.GenericIPAddressField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_analytics_events'
        ordering = ['-created_at']
        constraints = [models.UniqueConstraint(fields=['user', 'idempotency_key'], name='unique_analytics_event')]
        indexes = [models.Index(fields=['name', '-created_at']), models.Index(fields=['user', '-created_at'])]


class EventLog(TimeStampedModel):
    EVENT_TYPE_CHOICES = [('page_view', 'Page View'), ('game_start', 'Game Start'), ('game_end', 'Game End'), ('purchase', 'Purchase'), ('login', 'Login'), ('logout', 'Logout')]
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True, related_name='event_logs')
    event_type = models.CharField(max_length=50, choices=EVENT_TYPE_CHOICES)
    route = models.CharField(max_length=255, blank=True, default='')
    payload = models.JSONField(default=dict, blank=True)
    ip_address = models.GenericIPAddressField(blank=True, null=True)

    class Meta:
        db_table = 'event_logs'