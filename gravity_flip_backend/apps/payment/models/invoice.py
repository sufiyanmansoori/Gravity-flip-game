import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Invoice(TimeStampedModel):
    class Status(models.TextChoices):
        DRAFT = 'draft', 'Draft'
        OPEN = 'open', 'Open'
        PAID = 'paid', 'Paid'
        VOID = 'void', 'Void'
        UNCOLLECTIBLE = 'uncollectible', 'Uncollectible'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name='gravity_invoices')
    subscription = models.ForeignKey('gravity_payment.Subscription', null=True, blank=True, on_delete=models.SET_NULL, related_name='invoices')
    payment = models.ForeignKey('gravity_payment.Payment', null=True, blank=True, on_delete=models.SET_NULL, related_name='invoices')
    provider_invoice_id = models.CharField(max_length=255, blank=True, default='')
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.DRAFT)
    due_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_invoices'
        constraints = [models.UniqueConstraint(fields=['provider_invoice_id'], name='unique_provider_invoice')]