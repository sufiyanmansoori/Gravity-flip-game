from contextlib import contextmanager
from unittest.mock import patch


class MockProvider:
    def __init__(self, **response):
        self.response = response or {'id': 'mock-provider-id', 'status': 'accepted'}
        self.calls = []

    def __call__(self, *args, **payload):
        self.calls.append({'args': args, **payload})
        return self.response


@contextmanager
def mock_stripe_checkout(response=None):
    provider = MockProvider(**(response or {'id': 'checkout_test', 'status': 'created'}))
    with patch('apps.payment.services.payment_service.StripeService.create_checkout', side_effect=provider):
        yield provider