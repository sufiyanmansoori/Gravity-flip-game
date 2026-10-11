from external import ExternalServiceError


class DatadogClient:
    @staticmethod
    def metric(name, value, tags=None):
        try:
            from datadog import initialize, api
        except ImportError as exc:
            raise ExternalServiceError('Install datadog to use Datadog.') from exc
        initialize()
        return api.Metric.send(metric=name, points=value, tags=tags or [])