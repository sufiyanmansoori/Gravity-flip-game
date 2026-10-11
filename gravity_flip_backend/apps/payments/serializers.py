from __future__ import annotations

from rest_framework import serializers

from .models import PaymentTransaction, SubscriptionPlan, UserSubscription


class PaymentTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentTransaction
        fields = [
            'id', 'user', 'gateway', 'amount', 'currency', 'status',
            'external_reference', 'metadata', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class SubscriptionPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPlan
        fields = ['id', 'name', 'price', 'currency', 'description', 'stripe_product_id', 'is_active']
        read_only_fields = ['id']


class UserSubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSubscription
        fields = ['id', 'user', 'plan', 'status', 'starts_at', 'ends_at', 'created_at']
        read_only_fields = ['id', 'created_at', 'starts_at']
