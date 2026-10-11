from .firebase_admin import FirebaseAdmin
from external import ExternalServiceError


class FirebaseMessagingService:
    @staticmethod
    def send(token, title, body, data=None):
        FirebaseAdmin.app()
        try:
            from firebase_admin import messaging
            message = messaging.Message(notification=messaging.Notification(title=title, body=body), data={str(k): str(v) for k, v in (data or {}).items()}, token=token)
            return messaging.send(message)
        except ImportError as exc:
            raise ExternalServiceError('Install firebase-admin to use Firebase Messaging.') from exc