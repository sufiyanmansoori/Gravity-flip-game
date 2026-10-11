from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from ..serializers import UpdateProfileSerializer, UserProfileSerializer, UserStatsSerializer
from ..services.user_service import UserService


class UserViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]

    def _profile(self, user):
        return UserService.provision(user)

    @action(detail=False, methods=['get', 'patch'], url_path='me')
    def me(self, request):
        profile = self._profile(request.user)
        if request.method == 'PATCH':
            serializer = UpdateProfileSerializer(profile, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            profile = serializer.save()
        return Response(UserProfileSerializer(profile, context={'request': request}).data)

    @action(detail=False, methods=['get'])
    def stats(self, request):
        return Response(UserStatsSerializer(UserService.stats(request.user)).data)