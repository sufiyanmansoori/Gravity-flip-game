from __future__ import annotations

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class GameLevel(TimeStampedModel):
    name = models.CharField(max_length=255)
    slug = models.SlugField(unique=True)
    difficulty = models.CharField(max_length=50, default='easy')
    gravity_direction = models.CharField(max_length=10, default='left')
    target_score = models.PositiveIntegerField(default=1000)
    is_active = models.BooleanField(default=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'game_levels'
        ordering = ['difficulty', 'target_score']

    def __str__(self) -> str:
        return self.name


class GameSession(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='game_sessions')
    level = models.ForeignKey(GameLevel, on_delete=models.SET_NULL, null=True, blank=True, related_name='sessions')
    score = models.PositiveBigIntegerField(default=0)
    status = models.CharField(max_length=30, default='in_progress')
    duration_seconds = models.PositiveIntegerField(default=0)
    attempts = models.PositiveIntegerField(default=1)
    best_score = models.PositiveBigIntegerField(default=0)
    final_state = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'game_sessions'
        ordering = ['-created_at']

    def __str__(self) -> str:
        return f'{self.user.username} - {self.level.name if self.level else "custom"} - {self.score}'


class LeaderboardEntry(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='leaderboard_entries')
    level = models.ForeignKey(GameLevel, on_delete=models.CASCADE, related_name='leaderboard_entries')
    score = models.PositiveBigIntegerField(default=0)
    rank = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = 'leaderboard_entries'
        ordering = ['-score', 'created_at']

    def __str__(self) -> str:
        return f'{self.user.username} - {self.score}'


class Achievement(TimeStampedModel):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, default='')
    icon = models.CharField(max_length=255, blank=True, default='')
    points = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = 'achievements'

    def __str__(self) -> str:
        return self.name


class UserAchievement(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='achievements')
    achievement = models.ForeignKey(Achievement, on_delete=models.CASCADE, related_name='awardees')
    unlocked_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_achievements'
        unique_together = ('user', 'achievement')

    def __str__(self) -> str:
        return f'{self.user.username} unlocked {self.achievement.name}'
