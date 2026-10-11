from __future__ import annotations

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class PaymentGateway(models.Model):
    name = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    public_key = models.CharField(max_length=255, blank=True, default='')
    secret_key = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'payment_gateways'

    def __str__(self) -> str:
        return self.name


class PaymentTransaction(TimeStampedModel):
    STATUS_PENDING = 'pending'
    STATUS_PAID = 'paid'
    STATUS_FAILED = 'failed'
    STATUS_REFUNDED = 'refunded'
    STATUS_CHOICES = [
        (STATUS_PENDING, 'Pending'),
        (STATUS_PAID, 'Paid'),
        (STATUS_FAILED, 'Failed'),
        (STATUS_REFUNDED, 'Refunded'),
    ]

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='payments')
    gateway = models.ForeignKey(PaymentGateway, on_delete=models.SET_NULL, null=True, blank=True)
    amount = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    currency = models.CharField(max_length=10, default='USD')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_PENDING)
    external_reference = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'payment_transactions'
        ordering = ['-created_at']

    def __str__(self) -> str:
        return f'{self.user.username} - {self.amount} {self.currency}'


class SubscriptionPlan(TimeStampedModel):
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=10, default='USD')
    description = models.TextField(blank=True, default='')
    stripe_product_id = models.CharField(max_length=255, blank=True, default='')
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'subscription_plans'

    def __str__(self) -> str:
        return self.name


class UserSubscription(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='subscriptions')
    plan = models.ForeignKey(SubscriptionPlan, on_delete=models.CASCADE, related_name='subscribers')
    status = models.CharField(max_length=20, default='active')
    starts_at = models.DateTimeField(auto_now_add=True)
    ends_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'user_subscriptions'

    def __str__(self) -> str:
        return f'{self.user.username} - {self.plan.name}'
