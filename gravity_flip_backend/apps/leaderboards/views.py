from __future__ import annotations

from django.utils import timezone
from rest_framework import generics, permissions, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from .models import ChallengeAttempt, DailyChallenge
from .serializers import ChallengeAttemptSerializer, DailyChallengeSerializer


class DailyChallengeListView(generics.ListAPIView):
    queryset = DailyChallenge.objects.filter(is_active=True, expires_at__gt=timezone.now())
    serializer_class = DailyChallengeSerializer
    permission_classes = [permissions.AllowAny]


class ChallengeAttemptListView(generics.ListCreateAPIView):
    queryset = ChallengeAttempt.objects.select_related('user', 'challenge')
    serializer_class = ChallengeAttemptSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return self.queryset.filter(user=self.request.user)


@api_view(['POST'])
@permission_classes([permissions.IsAuthenticated])
def submit_challenge_attempt(request):
    serializer = ChallengeAttemptSerializer(data=request.data)
    if serializer.is_valid():
        attempt = serializer.save(user=request.user)
        return Response(ChallengeAttemptSerializer(attempt).data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
