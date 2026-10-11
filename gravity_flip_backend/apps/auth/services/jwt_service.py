import base64
import hashlib
import hmac
import json
import time
import uuid

from django.conf import settings


class InvalidToken(ValueError):
    pass


class JWTService:
    algorithm = 'HS256'

    @staticmethod
    def _encode(value):
        return base64.urlsafe_b64encode(value).rstrip(b'=').decode()

    @staticmethod
    def _decode(value):
        return base64.urlsafe_b64decode(value + '=' * (-len(value) % 4))

    @classmethod
    def issue(cls, user_id, token_type, lifetime):
        now = int(time.time())
        payload = {'sub': str(user_id), 'type': token_type, 'iat': now, 'exp': now + lifetime, 'jti': str(uuid.uuid4())}
        header = {'alg': cls.algorithm, 'typ': 'JWT'}
        encoded = f'{cls._encode(json.dumps(header, separators=(",", ":")).encode())}.{cls._encode(json.dumps(payload, separators=(",", ":")).encode())}'
        signature = hmac.new(cls._secret(), encoded.encode(), hashlib.sha256).digest()
        return f'{encoded}.{cls._encode(signature)}', payload

    @classmethod
    def decode(cls, token, expected_type=None):
        try:
            header, body, signature = token.split('.')
            signing_input = f'{header}.{body}'.encode()
            expected = hmac.new(cls._secret(), signing_input, hashlib.sha256).digest()
            if not hmac.compare_digest(cls._decode(signature), expected):
                raise InvalidToken('Invalid token signature')
            payload = json.loads(cls._decode(body))
            if payload.get('exp', 0) <= int(time.time()):
                raise InvalidToken('Token has expired')
            if expected_type and payload.get('type') != expected_type:
                raise InvalidToken('Invalid token type')
            return payload
        except (ValueError, TypeError, json.JSONDecodeError, UnicodeDecodeError) as exc:
            raise InvalidToken('Invalid token') from exc

    @staticmethod
    def _secret():
        return str(getattr(settings, 'JWT_SECRET', settings.SECRET_KEY)).encode()