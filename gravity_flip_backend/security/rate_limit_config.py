from django.conf import settings


DEFAULT_RATES = {
    'anon': '30/minute',
    'user': '120/minute',
    'auth': '10/minute',
    'payment': '20/minute',
}


def rate_limit_settings():
    return {
        'DEFAULT_THROTTLE_CLASSES': ['rest_framework.throttling.AnonRateThrottle', 'rest_framework.throttling.UserRateThrottle'],
        'DEFAULT_THROTTLE_RATES': getattr(settings, 'REST_FRAMEWORK', {}).get('DEFAULT_THROTTLE_RATES', DEFAULT_RATES),
    }


def parse_rate(rate):
    try:
        count, period = rate.split('/', 1)
        count = int(count)
        if count <= 0 or period not in {'second', 'minute', 'hour', 'day'}:
            raise ValueError
        return count, period
    except (ValueError, AttributeError):
        raise ValueError('Rate must be formatted as a positive count and second, minute, hour, or day.')
