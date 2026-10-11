from __future__ import annotations

from django.contrib.auth.models import AbstractUser
from django.db import models

from apps.core.models import TimeStampedModel


class User(AbstractUser, TimeStampedModel):
    avatar_url = models.URLField(max_length=500, blank=True, null=True)
    bio = models.TextField(blank=True, default='')
    country = models.CharField(max_length=100, blank=True, default='')
    is_verified = models.BooleanField(default=False)
    last_login_ip = models.GenericIPAddressField(blank=True, null=True)
    is_premium = models.BooleanField(default=False)

    class Meta:
        db_table = 'users'
        ordering = ['-date_joined']

    def __str__(self) -> str:
        return self.username or self.email or self.get_full_name() or f'User {self.pk}'


class UserSession(TimeStampedModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sessions')
    device_name = models.CharField(max_length=255, blank=True, default='')
    ip_address = models.GenericIPAddressField(blank=True, null=True)
    user_agent = models.TextField(blank=True, default='')
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'user_sessions'

    def __str__(self) -> str:
        return f'{self.user.username} - {self.device_name or "Unknown device"}'


class UserProfile(TimeStampedModel):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    total_games_played = models.PositiveIntegerField(default=0)
    total_wins = models.PositiveIntegerField(default=0)
    best_score = models.PositiveIntegerField(default=0)
    favorite_level = models.CharField(max_length=255, blank=True, default='')

    class Meta:
        db_table = 'user_profiles'

    def __str__(self) -> str:
        return f'{self.user.username} profile'
