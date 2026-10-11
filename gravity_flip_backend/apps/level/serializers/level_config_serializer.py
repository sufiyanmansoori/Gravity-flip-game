from rest_framework import serializers

from ..models import LevelConfiguration


class LevelConfigSerializer(serializers.ModelSerializer):
    class Meta:
        model = LevelConfiguration
        exclude = ['id', 'level', 'created_at', 'updated_at']

    def validate_starting_gravity(self, value):
        if value not in (-1, 1):
            raise serializers.ValidationError('starting_gravity must be -1 or 1.')
        return value