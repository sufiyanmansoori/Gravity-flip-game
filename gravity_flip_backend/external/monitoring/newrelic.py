from django.conf import settings


class NewRelicClient:
    @staticmethod
    def initialize():
        if not getattr(settings, 'NEW_RELIC_LICENSE_KEY', ''):
            return False
        try:
            import newrelic.agent
            newrelic.agent.initialize()
            return True
        except ImportError:
            return False

    @staticmethod
    def notice_error(error):
        try:
            import newrelic.agent
            newrelic.agent.notice_error(error=error)
        except ImportError:
            return None