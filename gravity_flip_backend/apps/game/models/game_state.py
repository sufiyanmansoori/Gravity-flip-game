from django.db import models

from apps.core.models import TimeStampedModel


class GameState(TimeStampedModel):
    game = models.OneToOneField('gravity_game.Game', on_delete=models.CASCADE, related_name='state')
    gravity = models.SmallIntegerField(default=1)
    world_width = models.PositiveIntegerField(default=1200)
    world_height = models.PositiveIntegerField(default=800)
    snapshot = models.JSONField(default=dict)
    checksum = models.CharField(max_length=64, blank=True, default='')

    class Meta:
        db_table = 'gravity_game_states'