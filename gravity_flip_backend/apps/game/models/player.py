from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Player(TimeStampedModel):
    game = models.ForeignKey('gravity_game.Game', on_delete=models.CASCADE, related_name='players')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='gravity_game_players')
    x = models.FloatField(default=100)
    y = models.FloatField(default=400)
    velocity_x = models.FloatField(default=0)
    velocity_y = models.FloatField(default=0)
    width = models.PositiveSmallIntegerField(default=32)
    height = models.PositiveSmallIntegerField(default=32)
    alive = models.BooleanField(default=True)

    class Meta:
        db_table = 'gravity_game_players'
        constraints = [models.UniqueConstraint(fields=['game', 'user'], name='unique_gravity_game_player')]