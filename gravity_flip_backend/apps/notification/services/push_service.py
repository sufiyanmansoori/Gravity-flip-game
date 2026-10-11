from django.conf import settings


class PushService:
    @staticmethod
    def send(*, user, subject, body, metadata=None):
        token = getattr(user, 'push_token', '')
        if not token:
            raise ValueError('User does not have a push token.')
        if not getattr(settings, 'PUSH_PROVIDER_URL', ''):
            raise RuntimeError('Push provider is not configured.')
        return {'recipient': token, 'accepted': True, 'metadata': metadata or {}}