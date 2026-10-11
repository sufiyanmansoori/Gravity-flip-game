from __future__ import annotations

from django.db.models import Max, Q
from rest_framework import generics, permissions, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from .models import Achievement, GameLevel, GameSession, LeaderboardEntry, UserAchievement
from .serializers import AchievementSerializer, GameLevelSerializer, GameSessionSerializer, LeaderboardEntrySerializer, UserAchievementSerializer


class GameLevelListView(generics.ListCreateAPIView):
    queryset = GameLevel.objects.all()
    serializer_class = GameLevelSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]


class GameLevelDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = GameLevel.objects.all()
    serializer_class = GameLevelSerializer
    permission_classes = [permissions.IsAdminUser]


class GameSessionListView(generics.ListCreateAPIView):
    queryset = GameSession.objects.select_related('user', 'level')
    serializer_class = GameSessionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if not self.request.user.is_staff:
            qs = qs.filter(user=self.request.user)
        return qs


class GameSessionDetailView(generics.RetrieveUpdateAPIView):
    queryset = GameSession.objects.select_related('user', 'level')
    serializer_class = GameSessionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if not self.request.user.is_staff:
            qs = qs.filter(user=self.request.user)
        return qs


class LeaderboardView(generics.ListAPIView):
    queryset = LeaderboardEntry.objects.select_related('user', 'level')
    serializer_class = LeaderboardEntrySerializer
    permission_classes = [permissions.AllowAny]


class AchievementListView(generics.ListAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer
    permission_classes = [permissions.AllowAny]


class UserAchievementListView(generics.ListAPIView):
    queryset = UserAchievement.objects.select_related('user', 'achievement')
    serializer_class = UserAchievementSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return self.queryset.filter(user=self.request.user)


@api_view(['GET'])
@permission_classes([permissions.AllowAny])
def game_stats(request):
    total_sessions = GameSession.objects.count()
    total_players = GameSession.objects.values('user').distinct().count()
    best_score = GameSession.objects.aggregate(best=Max('score'))['best'] or 0
    return Response(
        {
            'total_sessions': total_sessions,
            'total_players': total_players,
            'best_score': best_score,
        },
        status=status.HTTP_200_OK,
    )


@api_view(['POST'])
@permission_classes([permissions.IsAuthenticated])
def submit_score(request):
    serializer = GameSessionSerializer(data=request.data)
    if serializer.is_valid():
        session = serializer.save(user=request.user)
        return Response(GameSessionSerializer(session).data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
