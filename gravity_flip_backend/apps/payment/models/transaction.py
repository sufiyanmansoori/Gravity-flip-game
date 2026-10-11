import uuid

from django.db import models

from apps.core.models import TimeStampedModel


class PaymentTransaction(TimeStampedModel):
    payment = models.ForeignKey('gravity_payment.Payment', on_delete=models.PROTECT, related_name='transactions')
    kind = models.CharField(max_length=20, default='payment')
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    status = models.CharField(max_length=20)
    provider_reference = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_payment_transactions'
        ordering = ['-created_at']


class PaymentEvent(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    provider = models.CharField(max_length=20)
    event_id = models.CharField(max_length=255)
    event_type = models.CharField(max_length=100)
    payload = models.JSONField(default=dict)
    processed_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_payment_events'
        constraints = [models.UniqueConstraint(fields=['provider', 'event_id'], name='unique_payment_provider_event')]