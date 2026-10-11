from django.db import models

from apps.core.models import TimeStampedModel


class Obstacle(TimeStampedModel):
    game = models.ForeignKey('gravity_game.Game', on_delete=models.CASCADE, related_name='obstacles')
    obstacle_type = models.CharField(max_length=32)
    x = models.FloatField()
    y = models.FloatField()
    width = models.FloatField()
    height = models.FloatField()
    velocity_x = models.FloatField(default=0)
    velocity_y = models.FloatField(default=0)
    active = models.BooleanField(default=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_game_obstacles'
        indexes = [models.Index(fields=['game', 'active'])]