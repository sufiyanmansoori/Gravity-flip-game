from django.conf import settings


class SentryClient:
    @staticmethod
    def initialize():
        dsn = getattr(settings, 'SENTRY_DSN', '')
        if not dsn:
            return False
        try:
            import sentry_sdk
            sentry_sdk.init(dsn=dsn, environment=getattr(settings, 'SENTRY_ENVIRONMENT', 'development'), traces_sample_rate=float(getattr(settings, 'SENTRY_TRACES_SAMPLE_RATE', 0.0)))
            return True
        except ImportError:
            return False

    @staticmethod
    def capture_exception(error):
        try:
            import sentry_sdk
            sentry_sdk.capture_exception(error)
        except ImportError:
            return None