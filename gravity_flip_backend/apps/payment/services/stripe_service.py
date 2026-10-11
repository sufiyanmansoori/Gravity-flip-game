import hashlib
import hmac
import json

from django.conf import settings


class StripeService:
    provider = 'stripe'

    @staticmethod
    def verify_signature(payload, signature, tolerance=300):
        timestamp = None
        signatures = []
        for item in signature.split(','):
            key, _, value = item.partition('=')
            if key == 't':
                timestamp = int(value)
            elif key == 'v1':
                signatures.append(value)
        if not timestamp or abs(__import__('time').time() - timestamp) > tolerance:
            return False
        signed = f'{timestamp}.{payload.decode() if isinstance(payload, bytes) else payload}'
        expected = hmac.new(str(getattr(settings, 'STRIPE_WEBHOOK_SECRET', '')).encode(), signed.encode(), hashlib.sha256).hexdigest()
        return any(hmac.compare_digest(expected, candidate) for candidate in signatures)

    @staticmethod
    def parse_event(payload):
        return json.loads(payload.decode() if isinstance(payload, bytes) else payload)

    @staticmethod
    def create_checkout(payment):
        if not getattr(settings, 'STRIPE_SECRET_KEY', ''):
            raise RuntimeError('Stripe is not configured.')
        try:
            import stripe
            stripe.api_key = settings.STRIPE_SECRET_KEY
            return stripe.checkout.Session.create(amount=int(payment.amount * 100), currency=payment.currency.lower(), metadata={'payment_id': str(payment.id)})
        except ImportError as exc:
            raise RuntimeError('Install the stripe package to use Stripe payments.') from exc