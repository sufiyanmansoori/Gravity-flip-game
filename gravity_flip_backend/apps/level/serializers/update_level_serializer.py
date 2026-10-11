from rest_framework import serializers

from ..models import Level
from .level_config_serializer import LevelConfigSerializer


class UpdateLevelSerializer(serializers.ModelSerializer):
    configuration = LevelConfigSerializer(required=False)

    class Meta:
        model = Level
        fields = ['title', 'description', 'difficulty', 'seed', 'definition', 'configuration']

    def update(self, instance, validated_data):
        config_data = validated_data.pop('configuration', None)
        instance = super().update(instance, validated_data)
        if config_data is not None:
            LevelConfigSerializer().update(instance.configuration, config_data)
        return instance