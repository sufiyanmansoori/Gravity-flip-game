from django.conf import settings


def security_headers():
    """Return headers suitable for a response security middleware."""
    return {
        'X-Content-Type-Options': 'nosniff',
        'X-Frame-Options': getattr(settings, 'X_FRAME_OPTIONS', 'DENY'),
        'Referrer-Policy': 'strict-origin-when-cross-origin',
        'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
        'Content-Security-Policy': getattr(settings, 'CONTENT_SECURITY_POLICY', "default-src 'self'; frame-ancestors 'none'; object-src 'none'; base-uri 'self'"),
    }


class HelmetMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        for name, value in security_headers().items():
            response.setdefault(name, value)
        return response
