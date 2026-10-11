from django.db import models

from apps.core.models import TimeStampedModel


class LevelConfiguration(TimeStampedModel):
    level = models.OneToOneField('gravity_level.Level', on_delete=models.CASCADE, related_name='configuration')
    world_width = models.PositiveIntegerField(default=1200)
    world_height = models.PositiveIntegerField(default=800)
    starting_gravity = models.SmallIntegerField(default=1)
    target_score = models.PositiveBigIntegerField(default=1000)
    max_lives = models.PositiveSmallIntegerField(default=3)
    physics = models.JSONField(default=dict, blank=True)
    rules = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_level_configurations'