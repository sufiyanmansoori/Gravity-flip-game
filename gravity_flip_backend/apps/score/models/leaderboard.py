from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class LeaderboardEntry(TimeStampedModel):
    level = models.ForeignKey('gravity_level.Level', on_delete=models.CASCADE, related_name='leaderboard_entries')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_leaderboard_entries')
    best_score = models.PositiveBigIntegerField(default=0)
    stars = models.PositiveSmallIntegerField(default=0)
    rank = models.PositiveIntegerField(default=0)
    score_id = models.UUIDField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_leaderboard_entries'
        ordering = ['rank', '-best_score', 'created_at']
        constraints = [models.UniqueConstraint(fields=['level', 'user'], name='unique_level_leaderboard_user')]
        indexes = [models.Index(fields=['level', 'rank']), models.Index(fields=['level', '-best_score'])]