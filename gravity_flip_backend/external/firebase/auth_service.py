from .firebase_admin import FirebaseAdmin
from external import ExternalServiceError


class FirebaseAuthService:
    @staticmethod
    def verify_id_token(token, check_revoked=False):
        FirebaseAdmin.app()
        try:
            from firebase_admin import auth
            return auth.verify_id_token(token, check_revoked=check_revoked)
        except ImportError as exc:
            raise ExternalServiceError('Install firebase-admin to use Firebase Auth.') from exc

    @staticmethod
    def create_custom_token(uid, claims=None):
        FirebaseAdmin.app()
        try:
            from firebase_admin import auth
            return auth.create_custom_token(uid, claims or {})
        except ImportError as exc:
            raise ExternalServiceError('Install firebase-admin to use Firebase Auth.') from exc