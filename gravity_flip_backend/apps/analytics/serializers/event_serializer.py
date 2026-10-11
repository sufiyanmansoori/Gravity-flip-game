from rest_framework import serializers

from ..models import Event


class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = ['id', 'name', 'session_key', 'route', 'payload', 'client_timestamp', 'idempotency_key', 'created_at']
        read_only_fields = ['id', 'created_at']