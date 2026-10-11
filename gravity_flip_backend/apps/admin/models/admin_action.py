import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class AdminAction(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    actor = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name='admin_actions')
    action = models.CharField(max_length=100)
    target_type = models.CharField(max_length=100, blank=True, default='')
    target_id = models.CharField(max_length=100, blank=True, default='')
    reason = models.TextField(blank=True, default='')
    before = models.JSONField(default=dict, blank=True)
    after = models.JSONField(default=dict, blank=True)
    ip_address = models.GenericIPAddressField(null=True, blank=True)
    request_id = models.CharField(max_length=100, blank=True, default='')

    class Meta:
        db_table = 'gravity_admin_actions'
        ordering = ['-created_at']
        indexes = [models.Index(fields=['actor', '-created_at']), models.Index(fields=['target_type', 'target_id'])]