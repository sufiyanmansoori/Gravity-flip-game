from rest_framework import serializers

from ..models import NotificationSettings, UserPreferences, UserProfile
from .user_profile_serializer import NotificationSettingsSerializer, UserPreferencesSerializer


class UpdateProfileSerializer(serializers.ModelSerializer):
    preferences = UserPreferencesSerializer(required=False)
    notifications = NotificationSettingsSerializer(required=False)

    class Meta:
        model = UserProfile
        fields = ['display_name', 'avatar_url', 'bio', 'country', 'timezone', 'birth_year', 'preferences', 'notifications']

    def update(self, instance, validated_data):
        preferences = validated_data.pop('preferences', None)
        notifications = validated_data.pop('notifications', None)
        instance = super().update(instance, validated_data)
        if preferences is not None:
            UserPreferencesSerializer().update(instance.user.gravity_preferences, preferences)
        if notifications is not None:
            NotificationSettingsSerializer().update(instance.user.gravity_notification_settings, notifications)
        return instance