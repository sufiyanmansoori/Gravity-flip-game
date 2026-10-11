from rest_framework import serializers

from ..models import Achievement, AchievementReward, UserAchievement


class AchievementRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = AchievementReward
        fields = ['id', 'reward_type', 'amount', 'reference', 'payload']


class AchievementSerializer(serializers.ModelSerializer):
    rewards = AchievementRewardSerializer(many=True, read_only=True)
    unlocked = serializers.SerializerMethodField()

    class Meta:
        model = Achievement
        fields = ['id', 'code', 'name', 'description', 'icon', 'points', 'criteria', 'is_hidden', 'rewards', 'unlocked']
        read_only_fields = ['id', 'unlocked']

    def get_unlocked(self, obj):
        user = self.context['request'].user
        return user.is_authenticated and UserAchievement.objects.filter(user=user, achievement=obj).exists()