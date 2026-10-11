from rest_framework import serializers


class CreateGameSerializer(serializers.Serializer):
    level_id = serializers.CharField(max_length=100)
    seed = serializers.IntegerField(min_value=0, required=False)
    metadata = serializers.JSONField(required=False, default=dict)