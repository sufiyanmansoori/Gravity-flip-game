import uuid

from django.db import models

from apps.core.models import TimeStampedModel


class Achievement(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    code = models.SlugField(max_length=80, unique=True)
    name = models.CharField(max_length=120)
    description = models.TextField(blank=True, default='')
    icon = models.CharField(max_length=255, blank=True, default='')
    points = models.PositiveIntegerField(default=0)
    criteria = models.JSONField(default=dict, blank=True)
    is_active = models.BooleanField(default=True)
    is_hidden = models.BooleanField(default=False)

    class Meta:
        db_table = 'gravity_achievements'
        ordering = ['points', 'name']
        indexes = [models.Index(fields=['is_active', 'is_hidden'])]

    def __str__(self):
        return self.name