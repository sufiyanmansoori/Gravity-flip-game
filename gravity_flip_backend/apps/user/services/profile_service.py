from django.db import transaction

from ..models import UserProfile
from .preference_service import PreferenceService


class ProfileService:
    @staticmethod
    @transaction.atomic
    def provision(user):
        profile, _ = UserProfile.objects.get_or_create(user=user)
        PreferenceService.provision(user)
        return profile

    @staticmethod
    @transaction.atomic
    def update(user, data):
        profile = ProfileService.provision(user)
        preferences = data.pop('preferences', None)
        notifications = data.pop('notifications', None)
        for key, value in data.items():
            setattr(profile, key, value)
        if data:
            profile.save(update_fields=[*data.keys(), 'updated_at'])
        PreferenceService.update(user, preferences=preferences, notifications=notifications)
        return profile