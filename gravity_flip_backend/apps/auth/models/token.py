import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class RefreshToken(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='auth_refresh_tokens')
    jti = models.UUIDField(default=uuid.uuid4, unique=True, editable=False)
    token_hash = models.CharField(max_length=128, unique=True)
    expires_at = models.DateTimeField()
    revoked_at = models.DateTimeField(null=True, blank=True)
    replaced_by = models.UUIDField(null=True, blank=True)

    class Meta:
        db_table = 'auth_refresh_tokens'
        indexes = [models.Index(fields=['user', 'revoked_at']), models.Index(fields=['expires_at'])]

    @property
    def is_active(self):
        from django.utils import timezone
        return self.revoked_at is None and self.expires_at > timezone.now()