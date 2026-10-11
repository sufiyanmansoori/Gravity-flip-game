from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from ..authentication import JWTAuthentication
from ..serializers import LoginSerializer, RefreshTokenSerializer, RegisterSerializer
from ..services.auth_service import AuthService
from ..services.jwt_service import InvalidToken


class AuthViewSet(viewsets.GenericViewSet):
    authentication_classes = [JWTAuthentication]
    permission_classes = [AllowAny]

    @action(detail=False, methods=['post'])
    def register(self, request):
        serializer = RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            result = AuthService.register(request=request, **serializer.validated_data)
        except ValueError as exc:
            return Response({'detail': str(exc)}, status=status.HTTP_409_CONFLICT)
        return self._response(result, status.HTTP_201_CREATED)

    @action(detail=False, methods=['post'])
    def login(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            result = AuthService.login(request=request, **serializer.validated_data)
        except ValueError:
            return Response({'detail': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        return self._response(result)

    @action(detail=False, methods=['post'])
    def refresh(self, request):
        serializer = RefreshTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            result = AuthService.refresh(serializer.validated_data['refresh'], request=request)
        except InvalidToken:
            return Response({'detail': 'Invalid or expired refresh token'}, status=status.HTTP_401_UNAUTHORIZED)
        return self._response(result)

    @action(detail=False, methods=['get'], permission_classes=[IsAuthenticated])
    def me(self, request):
        user = request.user
        return Response({'id': user.pk, 'username': user.username, 'email': user.email, 'is_verified': user.is_verified})

    @staticmethod
    def _response(result, response_status=status.HTTP_200_OK):
        user = result.pop('user')
        result['user'] = {'id': user.pk, 'username': user.username, 'email': user.email}
        return Response(result, status=response_status)