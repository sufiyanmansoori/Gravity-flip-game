from django.conf import settings


def cors_settings():
    return {
        'CORS_ALLOWED_ORIGINS': list(getattr(settings, 'CORS_ALLOWED_ORIGINS', [])),
        'CORS_ALLOW_CREDENTIALS': bool(getattr(settings, 'CORS_ALLOW_CREDENTIALS', False)),
        'CORS_ALLOW_METHODS': ('DELETE', 'GET', 'OPTIONS', 'PATCH', 'POST', 'PUT'),
        'CORS_ALLOW_HEADERS': ('accept', 'authorization', 'content-type', 'origin', 'user-agent', 'x-csrftoken', 'x-request-id'),
    }


def origin_allowed(origin):
    return origin in cors_settings()['CORS_ALLOWED_ORIGINS']
