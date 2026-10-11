from rest_framework import serializers

from apps.game.models import Game
from apps.level.models import Level


class SaveScoreSerializer(serializers.Serializer):
    level = serializers.PrimaryKeyRelatedField(queryset=Level.objects.filter(status=Level.Status.PUBLISHED))
    game = serializers.PrimaryKeyRelatedField(queryset=Game.objects.all(), required=False, allow_null=True)
    value = serializers.IntegerField(min_value=0)
    duration_seconds = serializers.IntegerField(min_value=0, max_value=86_400, default=0)
    stars = serializers.IntegerField(min_value=0, max_value=5, default=0)
    idempotency_key = serializers.CharField(max_length=100)
    metadata = serializers.JSONField(required=False, default=dict)