from decimal import Decimal

from rest_framework import serializers

from ..models import SubscriptionPlan


class CreatePaymentSerializer(serializers.Serializer):
    amount = serializers.DecimalField(max_digits=12, decimal_places=2, min_value=Decimal('0.01'))
    currency = serializers.RegexField(r'^[A-Za-z]{3}$', default='USD')
    provider = serializers.ChoiceField(choices=['stripe', 'razorpay'])
    idempotency_key = serializers.CharField(max_length=100)
    description = serializers.CharField(max_length=255, required=False, allow_blank=True, default='')
    plan = serializers.PrimaryKeyRelatedField(queryset=SubscriptionPlan.objects.filter(is_active=True), required=False, allow_null=True)
    metadata = serializers.JSONField(required=False, default=dict)

    def validate_currency(self, value):
        return value.upper()