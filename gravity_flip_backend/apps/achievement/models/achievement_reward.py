import uuid

from django.db import models

from apps.core.models import TimeStampedModel


class AchievementReward(TimeStampedModel):
    class RewardType(models.TextChoices):
        POINTS = 'points', 'Points'
        XP = 'xp', 'Experience'
        COSMETIC = 'cosmetic', 'Cosmetic'
        BADGE = 'badge', 'Badge'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    achievement = models.ForeignKey('gravity_achievement.Achievement', on_delete=models.CASCADE, related_name='rewards')
    reward_type = models.CharField(max_length=20, choices=RewardType.choices)
    amount = models.PositiveIntegerField(default=0)
    reference = models.CharField(max_length=120, blank=True, default='')
    payload = models.JSONField(default=dict, blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'gravity_achievement_rewards'
        indexes = [models.Index(fields=['achievement', 'is_active'])]