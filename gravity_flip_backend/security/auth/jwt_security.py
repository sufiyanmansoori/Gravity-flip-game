from dataclasses import dataclass

from apps.auth.services.jwt_service import InvalidToken, JWTService


@dataclass(frozen=True)
class JWTClaims:
    subject: str
    token_type: str
    issued_at: int
    expires_at: int
    token_id: str


class JWTValidator:
    @staticmethod
    def decode(token, expected_type='access'):
        payload = JWTService.decode(token, expected_type=expected_type)
        required = ('sub', 'type', 'iat', 'exp', 'jti')
        if any(payload.get(field) in (None, '') for field in required):
            raise InvalidToken('JWT is missing required claims')
        return JWTClaims(str(payload['sub']), payload['type'], int(payload['iat']), int(payload['exp']), str(payload['jti']))
