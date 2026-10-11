import threading

from django.conf import settings

from external import ExternalServiceError


class FirebaseAdmin:
    _lock = threading.Lock()
    _app = None

    @classmethod
    def app(cls):
        if cls._app is not None:
            return cls._app
        with cls._lock:
            if cls._app is not None:
                return cls._app
            try:
                import firebase_admin
                from firebase_admin import credentials
            except ImportError as exc:
                raise ExternalServiceError('Install firebase-admin to use Firebase.') from exc
            credential_path = getattr(settings, 'FIREBASE_CREDENTIALS_PATH', '')
            if not credential_path:
                raise ExternalServiceError('FIREBASE_CREDENTIALS_PATH is not configured.')
            try:
                cls._app = firebase_admin.initialize_app(credentials.Certificate(credential_path))
            except ValueError:
                cls._app = firebase_admin.get_app()
            return cls._app