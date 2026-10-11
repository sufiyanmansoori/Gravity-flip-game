from __future__ import annotations

from rest_framework import serializers

from .models import ChallengeAttempt, DailyChallenge


class DailyChallengeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailyChallenge
        fields = ['id', 'title', 'description', 'target_score', 'expires_at', 'is_active', 'created_at']
        read_only_fields = ['id', 'created_at']


class ChallengeAttemptSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChallengeAttempt
        fields = ['id', 'user', 'challenge', 'score', 'completed', 'created_at']
        read_only_fields = ['id', 'created_at']
