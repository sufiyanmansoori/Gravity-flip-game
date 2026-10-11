from django.middleware.csrf import REASON_BAD_ORIGIN, _does_token_match


def csrf_header_valid(request):
    token = request.META.get('HTTP_X_CSRFTOKEN') or request.META.get('HTTP_X_CSRF_TOKEN')
    cookie = request.COOKIES.get('csrftoken')
    return bool(token and cookie and _does_token_match(token, cookie))


def csrf_failure_reason():
    return REASON_BAD_ORIGIN
