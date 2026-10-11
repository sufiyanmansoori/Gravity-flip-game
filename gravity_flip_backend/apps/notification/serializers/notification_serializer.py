from rest_framework import serializers

from ..models import Notification, NotificationTemplate


class NotificationTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationTemplate
        fields = ['id', 'code', 'channel', 'subject', 'body', 'is_active', 'metadata']
        read_only_fields = ['id']


class NotificationSerializer(serializers.ModelSerializer):
    template = NotificationTemplateSerializer(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'template', 'channel', 'category', 'subject', 'body', 'status', 'is_read', 'metadata', 'sent_at', 'created_at']
        read_only_fields = ['id', 'template', 'status', 'sent_at', 'created_at']