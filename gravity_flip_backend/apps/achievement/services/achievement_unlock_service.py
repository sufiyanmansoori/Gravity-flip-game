from django.db import IntegrityError, transaction

from ..models import UserAchievement
from .achievement_service import AchievementService
from .achievement_reward_service import AchievementRewardService


class AchievementUnlockService:
    @staticmethod
    def meets_criteria(achievement, context):
        return all(context.get(key, 0) >= value for key, value in achievement.criteria.items())

    @staticmethod
    @transaction.atomic
    def unlock(*, user, achievement):
        context = AchievementService.progress_context(user)
        if not AchievementUnlockService.meets_criteria(achievement, context):
            raise ValueError('Achievement criteria have not been met.')
        try:
            unlock, created = UserAchievement.objects.get_or_create(user=user, achievement=achievement, defaults={'context': context})
        except IntegrityError:
            unlock = UserAchievement.objects.get(user=user, achievement=achievement)
            created = False
        return unlock, created, AchievementRewardService.for_achievement(achievement)

    @classmethod
    def unlock_eligible(cls, user):
        unlocked = []
        for achievement in AchievementService.all_active_queryset():
            try:
                result, created, rewards = cls.unlock(user=user, achievement=achievement)
            except ValueError:
                continue
            if created:
                unlocked.append((result, rewards))
        return unlocked