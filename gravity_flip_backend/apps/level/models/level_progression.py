from django.db import models

from apps.core.models import TimeStampedModel


class LevelProgression(TimeStampedModel):
    level = models.OneToOneField('gravity_level.Level', on_delete=models.CASCADE, related_name='progression')
    prerequisite = models.ForeignKey('gravity_level.Level', null=True, blank=True, on_delete=models.PROTECT, related_name='unlocks')
    order = models.PositiveIntegerField(default=0)
    required_score = models.PositiveBigIntegerField(default=0)
    required_stars = models.PositiveSmallIntegerField(default=0)

    class Meta:
        db_table = 'gravity_level_progressions'
        ordering = ['order']