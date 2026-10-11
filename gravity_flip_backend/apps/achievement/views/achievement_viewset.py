from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.response import Response

from ..models import Achievement
from ..serializers import AchievementSerializer, UnlockAchievementSerializer
from ..services.achievement_reward_service import AchievementRewardService
from ..services.achievement_service import AchievementService
from ..services.achievement_unlock_service import AchievementUnlockService


class AchievementViewSet(viewsets.ModelViewSet):
    serializer_class = AchievementSerializer

    def get_queryset(self):
        if self.request.user.is_staff:
            return AchievementService.all_active_queryset()
        return AchievementService.public_queryset()

    def get_permissions(self):
        if self.action in {'create', 'update', 'partial_update', 'destroy'}:
            return [IsAdminUser()]
        if self.action in {'unlock', 'sync', 'mine'}:
            return [IsAuthenticated()]
        return [AllowAny()]

    @action(detail=False, methods=['get'])
    def mine(self, request):
        unlocks = request.user.gravity_achievements.select_related('achievement').prefetch_related('achievement__rewards')
        return Response([{'achievement': item.achievement.code, 'name': item.achievement.name, 'points': item.achievement.points, 'unlocked_at': item.unlocked_at, 'rewards': AchievementRewardService.as_payload(AchievementRewardService.for_achievement(item.achievement))} for item in unlocks])

    @action(detail=False, methods=['post'])
    def unlock(self, request):
        serializer = UnlockAchievementSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            unlock, created, rewards = AchievementUnlockService.unlock(user=request.user, achievement=serializer.validated_data['achievement'])
        except ValueError as exc:
            return Response({'detail': str(exc)}, status=status.HTTP_409_CONFLICT)
        return Response({'achievement': unlock.achievement.code, 'created': created, 'rewards': AchievementRewardService.as_payload(rewards)}, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=False, methods=['post'])
    def sync(self, request):
        unlocked = AchievementUnlockService.unlock_eligible(request.user)
        return Response({'unlocked': [{'achievement': item.achievement.code, 'rewards': AchievementRewardService.as_payload(rewards)} for item, rewards in unlocked]})