import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Game(TimeStampedModel):
    class Status(models.TextChoices):
        CREATED = 'created', 'Created'
        RUNNING = 'running', 'Running'
        PAUSED = 'paused', 'Paused'
        COMPLETED = 'completed', 'Completed'
        ABANDONED = 'abandoned', 'Abandoned'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_games')
    level_id = models.CharField(max_length=100)
    status = models.CharField(max_length=16, choices=Status.choices, default=Status.CREATED)
    score = models.PositiveBigIntegerField(default=0)
    tick = models.PositiveBigIntegerField(default=0)
    seed = models.PositiveBigIntegerField()
    finished_at = models.DateTimeField(null=True, blank=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_games'
        indexes = [models.Index(fields=['owner', 'status']), models.Index(fields=['created_at'])]