from rest_framework import serializers


class ScoreQuerySerializer(serializers.Serializer):
    level = serializers.UUIDField(required=False)
    limit = serializers.IntegerField(min_value=1, max_value=100, default=20)