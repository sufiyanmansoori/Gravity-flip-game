import hashlib
import hmac
import time

from django.conf import settings


def verify_webhook_signature(payload, signature, tolerance=300):
    timestamp = None
    signatures = []
    for part in (signature or '').split(','):
        key, _, value = part.partition('=')
        if key == 't':
            try:
                timestamp = int(value)
            except ValueError:
                return False
        elif key == 'v1':
            signatures.append(value)
    if not timestamp or abs(time.time() - timestamp) > tolerance:
        return False
    raw = payload.decode() if isinstance(payload, bytes) else payload
    expected = hmac.new(str(getattr(settings, 'STRIPE_WEBHOOK_SECRET', '')).encode(), f'{timestamp}.{raw}'.encode(), hashlib.sha256).hexdigest()
    return any(hmac.compare_digest(expected, candidate) for candidate in signatures)