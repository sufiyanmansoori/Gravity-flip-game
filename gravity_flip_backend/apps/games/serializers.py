from rest_framework import serializers

from .models import Achievement, GameLevel, GameSession, LeaderboardEntry, UserAchievement


class GameLevelSerializer(serializers.ModelSerializer):
    class Meta:
        model = GameLevel
        fields = [
            'id', 'name', 'slug', 'difficulty', 'gravity_direction',
            'target_score', 'is_active', 'metadata', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class GameSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = GameSession
        fields = [
            'id', 'user', 'level', 'score', 'status', 'duration_seconds',
            'attempts', 'best_score', 'final_state', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class LeaderboardEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = LeaderboardEntry
        fields = ['id', 'user', 'level', 'score', 'rank', 'created_at']
        read_only_fields = ['id', 'created_at']


class AchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Achievement
        fields = ['id', 'name', 'description', 'icon', 'points', 'created_at']
        read_only_fields = ['id', 'created_at']


class UserAchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAchievement
        fields = ['id', 'user', 'achievement', 'unlocked_at']
        read_only_fields = ['id', 'unlocked_at']
