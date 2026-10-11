import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Payment(TimeStampedModel):
    class Status(models.TextChoices):
        CREATED = 'created', 'Created'
        PENDING = 'pending', 'Pending'
        SUCCEEDED = 'succeeded', 'Succeeded'
        FAILED = 'failed', 'Failed'
        REFUNDED = 'refunded', 'Refunded'
        CANCELLED = 'cancelled', 'Cancelled'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name='gravity_payments')
    provider = models.CharField(max_length=20)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    status = models.CharField(max_length=16, choices=Status.choices, default=Status.CREATED)
    provider_payment_id = models.CharField(max_length=255, blank=True, default='')
    idempotency_key = models.CharField(max_length=100)
    description = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_payments'
        constraints = [models.UniqueConstraint(fields=['user', 'idempotency_key'], name='unique_payment_idempotency')]
        indexes = [models.Index(fields=['provider', 'provider_payment_id']), models.Index(fields=['user', '-created_at'])]