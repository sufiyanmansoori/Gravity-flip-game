import hashlib
from datetime import timedelta

from django.conf import settings
from django.db import transaction
from django.utils import timezone

from apps.users.models import User

from ..models import AuthSession, RefreshToken
from .jwt_service import JWTService, InvalidToken
from .password_service import PasswordService


class AuthService:
    access_lifetime = 900
    refresh_lifetime = 2_592_000

    @classmethod
    @transaction.atomic
    def register(cls, *, username, email, password, request=None):
        if User.objects.filter(email__iexact=email).exists() or User.objects.filter(username__iexact=username).exists():
            raise ValueError('A user with these credentials already exists')
        user = User.objects.create_user(username=username, email=email.lower(), password=password)
        return cls._issue_pair(user, request=request)

    @classmethod
    def login(cls, identifier, password, request=None):
        user = PasswordService.authenticate(identifier, password)
        if not user:
            raise ValueError('Invalid credentials')
        return cls._issue_pair(user, request=request)

    @classmethod
    @transaction.atomic
    def refresh(cls, raw_token, request=None):
        payload = JWTService.decode(raw_token, expected_type='refresh')
        token = RefreshToken.objects.select_for_update().filter(jti=payload['jti']).first()
        if not token or not token.is_active:
            raise InvalidToken('Refresh token has been revoked or expired')
        token.revoked_at = timezone.now()
        token.save(update_fields=['revoked_at', 'updated_at'])
        return cls._issue_pair(token.user, request=request)

    @classmethod
    def _issue_pair(cls, user, request=None):
        access, access_payload = JWTService.issue(user.pk, 'access', cls.access_lifetime)
        refresh, refresh_payload = JWTService.issue(user.pk, 'refresh', cls.refresh_lifetime)
        RefreshToken.objects.create(user=user, jti=refresh_payload['jti'], token_hash=hashlib.sha256(refresh.encode()).hexdigest(), expires_at=timezone.now() + timedelta(seconds=cls.refresh_lifetime))
        AuthSession.objects.create(user=user, ip_address=cls._ip(request), user_agent=(request.META.get('HTTP_USER_AGENT', '') if request else ''))
        return {'access': access, 'refresh': refresh, 'expires_in': cls.access_lifetime, 'user': user}

    @staticmethod
    def _ip(request):
        if not request:
            return None
        return request.META.get('REMOTE_ADDR')