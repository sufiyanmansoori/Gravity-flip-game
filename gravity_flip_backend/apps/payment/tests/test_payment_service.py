from decimal import Decimal
from unittest.mock import patch

from django.test import TestCase
from rest_framework.test import APIClient

from apps.payment.models import Payment, PaymentTransaction
from apps.payment.services.payment_service import PaymentService
from apps.payment.services.refund_service import RefundService
from apps.users.models import User


class PaymentServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')

    @patch('apps.payment.services.payment_service.StripeService.create_checkout', return_value={'id': 'checkout_123'})
    def test_payment_creation_is_idempotent(self, create_checkout):
        first, created, checkout = PaymentService.create(user=self.user, amount=Decimal('9.99'), currency='USD', provider='stripe', idempotency_key='order-1')
        duplicate, duplicate_created, _ = PaymentService.create(user=self.user, amount=Decimal('9.99'), currency='USD', provider='stripe', idempotency_key='order-1')
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(first.pk, duplicate.pk)
        self.assertEqual(checkout['id'], 'checkout_123')
        self.assertEqual(PaymentTransaction.objects.count(), 1)
        create_checkout.assert_called_once()

    def test_only_succeeded_payments_can_be_refunded(self):
        payment = Payment.objects.create(user=self.user, amount=Decimal('5.00'), currency='USD', provider='stripe', idempotency_key='refund-1', status=Payment.Status.PENDING)
        with self.assertRaises(ValueError):
            RefundService.refund(payment)


class PaymentIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    @patch('apps.payment.services.payment_service.RazorpayService.create_order', return_value={'id': 'order_123'})
    def test_create_payment_endpoint(self, create_order):
        response = self.client.post('/api/v1/payment/', {'amount': '10.00', 'currency': 'INR', 'provider': 'razorpay', 'idempotency_key': 'api-1'}, format='json')
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['payment']['status'], 'pending')
        create_order.assert_called_once()