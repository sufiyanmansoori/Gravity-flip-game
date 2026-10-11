import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class AuthSession(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='auth_sessions')
    session_key = models.UUIDField(default=uuid.uuid4, unique=True, editable=False)
    device_name = models.CharField(max_length=255, blank=True, default='')
    ip_address = models.GenericIPAddressField(null=True, blank=True)
    user_agent = models.TextField(blank=True, default='')
    last_seen_at = models.DateTimeField(auto_now=True)
    revoked_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'auth_sessions'
        indexes = [models.Index(fields=['user', 'revoked_at'])]