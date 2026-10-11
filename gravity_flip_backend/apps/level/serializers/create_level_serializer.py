from rest_framework import serializers

from ..models import Difficulty
from .level_config_serializer import LevelConfigSerializer


class CreateLevelSerializer(serializers.Serializer):
    slug = serializers.SlugField(max_length=100)
    title = serializers.CharField(max_length=150)
    description = serializers.CharField(required=False, allow_blank=True, default='')
    difficulty = serializers.PrimaryKeyRelatedField(queryset=Difficulty.objects.filter(is_active=True))
    seed = serializers.IntegerField(min_value=0, required=False, default=0)
    definition = serializers.JSONField(required=False, default=dict)
    configuration = LevelConfigSerializer(required=False)