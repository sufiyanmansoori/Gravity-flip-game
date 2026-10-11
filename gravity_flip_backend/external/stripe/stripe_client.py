from django.conf import settings

from external import ExternalServiceError


class StripeClient:
    @staticmethod
    def module():
        try:
            import stripe
            stripe.api_key = getattr(settings, 'STRIPE_SECRET_KEY', '')
            if not stripe.api_key:
                raise ExternalServiceError('STRIPE_SECRET_KEY is not configured.')
            return stripe
        except ImportError as exc:
            raise ExternalServiceError('Install stripe to use Stripe.') from exc

    @classmethod
    def create_checkout_session(cls, *, amount, currency, metadata=None, success_url=None, cancel_url=None):
        stripe = cls.module()
        return stripe.checkout.Session.create(mode='payment', line_items=[{'price_data': {'currency': currency.lower(), 'unit_amount': int(amount * 100), 'product_data': {'name': (metadata or {}).get('name', 'Gravity Flip purchase')}}, 'quantity': 1}], metadata=metadata or {}, success_url=success_url, cancel_url=cancel_url)

    @classmethod
    def refund(cls, payment_intent, amount=None):
        data = {'payment_intent': payment_intent}
        if amount is not None:
            data['amount'] = int(amount * 100)
        return cls.module().Refund.create(**data)