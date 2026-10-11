from django.db import models

from apps.core.models import TimeStampedModel


class PhysicsData(TimeStampedModel):
    game = models.OneToOneField('gravity_game.Game', on_delete=models.CASCADE, related_name='physics')
    gravity_strength = models.FloatField(default=980.0)
    jump_impulse = models.FloatField(default=420.0)
    horizontal_speed = models.FloatField(default=240.0)
    friction = models.FloatField(default=0.0)
    fixed_timestep = models.FloatField(default=1 / 60)

    class Meta:
        db_table = 'gravity_game_physics'