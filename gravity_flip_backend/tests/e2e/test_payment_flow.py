from decimal import Decimal

from apps.payment.models import Payment
from apps.payment.services.payment_service import PaymentService
from tests.fixtures.payment_fixtures import payment_user
from tests.helpers.mock_services import mock_stripe_checkout
from tests.helpers.test_setup import ServiceTestCase


class PaymentFlowTests(ServiceTestCase):
    def test_payment_is_created_once_and_provider_is_called_once(self):
        account = payment_user()
        with mock_stripe_checkout() as provider:
            payment, created, checkout = PaymentService.create(user=account, amount=Decimal('4.99'), currency='USD', provider='stripe', idempotency_key='e2e-payment')
            duplicate, duplicate_created, _ = PaymentService.create(user=account, amount=Decimal('4.99'), currency='USD', provider='stripe', idempotency_key='e2e-payment')
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(payment.pk, duplicate.pk)
        self.assertEqual(provider.calls.__len__(), 1)
        self.assertEqual(Payment.objects.count(), 1)