from ..models import AchievementReward


class AchievementRewardService:
    @staticmethod
    def for_achievement(achievement):
        return list(AchievementReward.objects.filter(achievement=achievement, is_active=True).order_by('created_at'))

    @staticmethod
    def as_payload(rewards):
        return [{'type': reward.reward_type, 'amount': reward.amount, 'reference': reward.reference, 'payload': reward.payload} for reward in rewards]