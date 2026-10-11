from rest_framework.authentication import BaseAuthentication, get_authorization_header
from rest_framework.exceptions import AuthenticationFailed

from apps.users.models import User

from .services.jwt_service import InvalidToken, JWTService


class JWTAuthentication(BaseAuthentication):
    keyword = b'bearer'

    def authenticate(self, request):
        parts = get_authorization_header(request).split()
        if not parts:
            return None
        if len(parts) != 2 or parts[0].lower() != self.keyword:
            raise AuthenticationFailed('Authorization header must use Bearer token format')
        try:
            payload = JWTService.decode(parts[1].decode(), expected_type='access')
            user = User.objects.get(pk=payload['sub'], is_active=True)
        except (InvalidToken, User.DoesNotExist, ValueError):
            raise AuthenticationFailed('Invalid or expired access token')
        return user, payload