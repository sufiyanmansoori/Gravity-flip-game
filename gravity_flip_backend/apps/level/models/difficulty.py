from decimal import Decimal

from django.db import models

from apps.core.models import TimeStampedModel


class Difficulty(TimeStampedModel):
    code = models.SlugField(max_length=32, unique=True)
    name = models.CharField(max_length=64)
    rank = models.PositiveSmallIntegerField(unique=True)
    speed_multiplier = models.DecimalField(max_digits=5, decimal_places=2, default=Decimal('1.00'))
    obstacle_density = models.DecimalField(max_digits=5, decimal_places=2, default=Decimal('1.00'))
    time_limit_seconds = models.PositiveIntegerField(default=0, help_text='Zero means unlimited.')
    minimum_score = models.PositiveBigIntegerField(default=0)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'gravity_level_difficulties'
        ordering = ['rank']

    def __str__(self):
        return self.name