from rest_framework import serializers, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from ..models import Score
from ..serializers import LeaderboardQuerySerializer, SaveScoreSerializer, ScoreQuerySerializer
from ..services.leaderboard_service import LeaderboardService
from ..services.score_service import ScoreService
from ..services.stats_service import StatsService


class ScoreViewSet(viewsets.GenericViewSet):
    queryset = Score.objects.select_related('user', 'level')

    def get_permissions(self):
        return [AllowAny()] if self.action == 'leaderboard' else [IsAuthenticated()]

    def list(self, request):
        query = ScoreQuerySerializer(data=request.query_params)
        query.is_valid(raise_exception=True)
        scores = self.queryset.filter(user=request.user)
        if query.validated_data.get('level'):
            scores = scores.filter(level_id=query.validated_data['level'])
        return Response([self._score_data(score) for score in scores[:query.validated_data['limit']]])

    def create(self, request):
        serializer = SaveScoreSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            score, created = ScoreService.save(user=request.user, **serializer.validated_data)
        except (PermissionError, ValueError) as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response(self._score_data(score) | {'created': created}, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=False, methods=['get'])
    def leaderboard(self, request):
        query = LeaderboardQuerySerializer(data=request.query_params)
        query.is_valid(raise_exception=True)
        from apps.level.models import Level
        level = Level.objects.get(pk=query.validated_data['level'], status=Level.Status.PUBLISHED)
        entries = LeaderboardService.top(level, query.validated_data['limit'])
        return Response([{'rank': entry.rank, 'username': entry.user.username, 'score': entry.best_score, 'stars': entry.stars} for entry in entries])

    @action(detail=False, methods=['get'])
    def stats(self, request):
        stats = StatsService.for_user(request.user)
        return Response({'total_submissions': stats.total_submissions, 'completed_levels': stats.completed_levels, 'total_score': stats.total_score, 'best_score': stats.best_score, 'total_stars': stats.total_stars})

    @staticmethod
    def _score_data(score):
        return {'id': str(score.id), 'level': str(score.level_id), 'value': score.value, 'duration_seconds': score.duration_seconds, 'stars': score.stars, 'created_at': score.created_at}