from rest_framework import serializers


class ContentManagementSerializer(serializers.Serializer):
    model = serializers.ChoiceField(choices=['level', 'achievement', 'notification_template'])
    object_id = serializers.CharField(max_length=100)
    is_active = serializers.BooleanField()
    reason = serializers.CharField(max_length=500, required=False, allow_blank=True, default='')