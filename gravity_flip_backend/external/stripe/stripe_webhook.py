import json

from external import ExternalServiceError
from .stripe_utils import verify_webhook_signature


def parse_webhook(payload, signature):
    if not verify_webhook_signature(payload, signature):
        raise ExternalServiceError('Invalid Stripe webhook signature.')
    try:
        return json.loads(payload.decode() if isinstance(payload, bytes) else payload)
    except json.JSONDecodeError as exc:
        raise ExternalServiceError('Stripe webhook payload is not valid JSON.') from exc