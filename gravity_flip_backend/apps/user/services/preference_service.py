from django.db import transaction

from ..models import NotificationSettings, UserPreferences


class PreferenceService:
    @staticmethod
    @transaction.atomic
    def provision(user):
        preferences, _ = UserPreferences.objects.get_or_create(user=user)
        notifications, _ = NotificationSettings.objects.get_or_create(user=user)
        return preferences, notifications

    @staticmethod
    @transaction.atomic
    def update(user, *, preferences=None, notifications=None):
        current_preferences, current_notifications = PreferenceService.provision(user)
        if preferences:
            for key, value in preferences.items():
                setattr(current_preferences, key, value)
            current_preferences.save(update_fields=[*preferences.keys(), 'updated_at'])
        if notifications:
            for key, value in notifications.items():
                setattr(current_notifications, key, value)
            current_notifications.save(update_fields=[*notifications.keys(), 'updated_at'])
        return current_preferences, current_notifications