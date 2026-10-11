import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Score(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_scores')
    level = models.ForeignKey('gravity_level.Level', on_delete=models.PROTECT, related_name='scores')
    game = models.ForeignKey('gravity_game.Game', null=True, blank=True, on_delete=models.SET_NULL, related_name='scores')
    value = models.PositiveBigIntegerField()
    duration_seconds = models.PositiveIntegerField(default=0)
    stars = models.PositiveSmallIntegerField(default=0)
    metadata = models.JSONField(default=dict, blank=True)
    idempotency_key = models.CharField(max_length=100)

    class Meta:
        db_table = 'gravity_scores'
        ordering = ['-value', 'created_at']
        constraints = [models.UniqueConstraint(fields=['user', 'idempotency_key'], name='unique_score_submission')]
        indexes = [models.Index(fields=['level', '-value']), models.Index(fields=['user', '-value'])]