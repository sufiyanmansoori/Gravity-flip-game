from rest_framework import serializers

from ..models import Achievement


class UnlockAchievementSerializer(serializers.Serializer):
    achievement = serializers.PrimaryKeyRelatedField(queryset=Achievement.objects.filter(is_active=True))