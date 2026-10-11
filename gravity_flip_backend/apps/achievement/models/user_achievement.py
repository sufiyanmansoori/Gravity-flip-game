from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class UserAchievement(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_achievements')
    achievement = models.ForeignKey('gravity_achievement.Achievement', on_delete=models.CASCADE, related_name='user_unlocks')
    unlocked_at = models.DateTimeField(auto_now_add=True)
    context = models.JSONField(default=dict, blank=True)
    notified_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_user_achievements'
        ordering = ['-unlocked_at']
        constraints = [models.UniqueConstraint(fields=['user', 'achievement'], name='unique_user_achievement_unlock')]
        indexes = [models.Index(fields=['user', '-unlocked_at'])]