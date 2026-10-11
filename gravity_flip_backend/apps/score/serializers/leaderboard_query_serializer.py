from rest_framework import serializers


class LeaderboardQuerySerializer(serializers.Serializer):
    level = serializers.UUIDField()
    limit = serializers.IntegerField(min_value=1, max_value=100, default=20)