from __future__ import annotations

from rest_framework import serializers

from .models import AnalyticsSnapshot, EventLog


class EventLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventLog
        fields = ['id', 'user', 'event_type', 'route', 'payload', 'ip_address', 'created_at']
        read_only_fields = ['id', 'created_at']


class AnalyticsSnapshotSerializer(serializers.ModelSerializer):
    class Meta:
        model = AnalyticsSnapshot
        fields = ['id', 'metric_name', 'metric_value', 'dimension', 'metadata', 'created_at']
        read_only_fields = ['id', 'created_at']
