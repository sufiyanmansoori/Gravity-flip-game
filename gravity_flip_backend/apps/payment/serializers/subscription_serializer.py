from rest_framework import serializers

from ..models import Subscription, SubscriptionPlan


class SubscriptionPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPlan
        fields = ['id', 'code', 'name', 'amount', 'currency', 'interval', 'metadata']


class SubscriptionSerializer(serializers.ModelSerializer):
    plan = SubscriptionPlanSerializer(read_only=True)

    class Meta:
        model = Subscription
        fields = ['id', 'plan', 'provider', 'status', 'current_period_end', 'cancel_at_period_end', 'cancelled_at']