from rest_framework import serializers


class PaymentCallbackSerializer(serializers.Serializer):
    provider_payment_id = serializers.CharField(max_length=255)
    status = serializers.ChoiceField(choices=['succeeded', 'failed', 'cancelled'])
    event_id = serializers.CharField(max_length=255)
    signature = serializers.CharField(max_length=512, required=False, allow_blank=True)
    payload = serializers.JSONField(required=False, default=dict)