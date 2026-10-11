from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class UserScoreStats(TimeStampedModel):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_score_stats')
    total_submissions = models.PositiveIntegerField(default=0)
    completed_levels = models.PositiveIntegerField(default=0)
    total_score = models.PositiveBigIntegerField(default=0)
    best_score = models.PositiveBigIntegerField(default=0)
    total_stars = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = 'gravity_user_score_stats'