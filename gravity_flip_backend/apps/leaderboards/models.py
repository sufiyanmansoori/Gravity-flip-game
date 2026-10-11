from __future__ import annotations

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class DailyChallenge(TimeStampedModel):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, default='')
    target_score = models.PositiveIntegerField(default=0)
    expires_at = models.DateTimeField()
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'daily_challenges'

    def __str__(self) -> str:
        return self.title


class ChallengeAttempt(TimeStampedModel):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='challenge_attempts')
    challenge = models.ForeignKey(DailyChallenge, on_delete=models.CASCADE, related_name='attempts')
    score = models.PositiveBigIntegerField(default=0)
    completed = models.BooleanField(default=False)

    class Meta:
        db_table = 'challenge_attempts'
        unique_together = ('user', 'challenge')

    def __str__(self) -> str:
        return f'{self.user.username} - {self.challenge.title}'
