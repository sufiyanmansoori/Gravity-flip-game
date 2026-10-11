from rest_framework import serializers


class UserStatsSerializer(serializers.Serializer):
    total_games_played = serializers.IntegerField()
    total_wins = serializers.IntegerField()
    best_score = serializers.IntegerField()
    total_score = serializers.IntegerField()
    total_stars = serializers.IntegerField()
    completed_levels = serializers.IntegerField()
    achievements_unlocked = serializers.IntegerField()