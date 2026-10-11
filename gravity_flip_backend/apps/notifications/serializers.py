from __future__ import annotations

from rest_framework import serializers

from .models import Notification, NotificationType


class NotificationTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationType
        fields = ['id', 'name', 'description']
        read_only_fields = ['id']


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ['id', 'user', 'notification_type', 'title', 'message', 'level', 'is_read', 'metadata', 'created_at']
        read_only_fields = ['id', 'created_at']
