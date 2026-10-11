from __future__ import annotations

from rest_framework import serializers

from .models import User, UserProfile, UserSession


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id', 'username', 'email', 'first_name', 'last_name',
            'avatar_url', 'bio', 'country', 'is_verified', 'is_premium',
            'date_joined', 'last_login',
        ]
        read_only_fields = ['id', 'date_joined', 'last_login']


class UserProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = UserProfile
        fields = ['id', 'user', 'total_games_played', 'total_wins', 'best_score', 'favorite_level']


class UserSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSession
        fields = ['id', 'user', 'device_name', 'ip_address', 'user_agent', 'is_active', 'created_at']
        read_only_fields = ['id', 'created_at']
