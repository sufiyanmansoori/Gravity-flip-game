from rest_framework import serializers

from ..models import NotificationSettings, UserPreferences, UserProfile


class UserPreferencesSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserPreferences
        exclude = ['id', 'user', 'created_at', 'updated_at']


class NotificationSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationSettings
        exclude = ['id', 'user', 'created_at', 'updated_at']


class UserProfileSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username', read_only=True)
    email = serializers.EmailField(source='user.email', read_only=True)
    preferences = serializers.SerializerMethodField()
    notifications = serializers.SerializerMethodField()

    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'email', 'display_name', 'avatar_url', 'bio', 'country', 'timezone', 'birth_year', 'preferences', 'notifications']
        read_only_fields = ['id', 'username', 'email', 'preferences', 'notifications']

    def get_preferences(self, obj):
        return UserPreferencesSerializer(obj.user.gravity_preferences).data

    def get_notifications(self, obj):
        return NotificationSettingsSerializer(obj.user.gravity_notification_settings).data