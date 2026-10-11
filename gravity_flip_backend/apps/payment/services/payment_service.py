from django.db import IntegrityError, transaction
from django.utils import timezone

from ..models import Payment, PaymentEvent, PaymentTransaction
from .razorpay_service import RazorpayService
from .stripe_service import StripeService


class PaymentService:
    providers = {'stripe': StripeService, 'razorpay': RazorpayService}

    @classmethod
    @transaction.atomic
    def create(cls, *, user, amount, currency, provider, idempotency_key, description='', metadata=None, plan=None):
        if provider not in cls.providers:
            raise ValueError('Unsupported payment provider.')
        try:
            payment, created = Payment.objects.get_or_create(
                user=user, idempotency_key=idempotency_key,
                defaults={'amount': amount, 'currency': currency, 'provider': provider, 'description': description, 'metadata': metadata or {}},
            )
        except IntegrityError:
            payment = Payment.objects.get(user=user, idempotency_key=idempotency_key)
            created = False
        if not created:
            if payment.amount != amount or payment.provider != provider:
                raise ValueError('Idempotency key was already used for a different payment.')
            return payment, False, payment.metadata.get('checkout', {})
        checkout = cls.providers[provider].create_checkout(payment) if provider == 'stripe' else cls.providers[provider].create_order(payment)
        payment.status = Payment.Status.PENDING
        payment.provider_payment_id = checkout.get('id', '') if isinstance(checkout, dict) else ''
        payment.metadata = {**payment.metadata, 'checkout': checkout}
        payment.save(update_fields=['status', 'provider_payment_id', 'metadata', 'updated_at'])
        PaymentTransaction.objects.create(payment=payment, amount=amount, currency=currency, status=payment.status, provider_reference=payment.provider_payment_id)
        return payment, True, checkout

    @staticmethod
    @transaction.atomic
    def apply_provider_status(*, provider, provider_payment_id, status, event_id, payload=None, payment_id=None):
        event, created = PaymentEvent.objects.get_or_create(provider=provider, event_id=event_id, defaults={'event_type': status, 'payload': payload or {}})
        if not created and event.processed_at:
            return None, False
        payment = Payment.objects.select_for_update().filter(pk=payment_id).first() if payment_id else None
        payment = payment or Payment.objects.select_for_update().filter(provider=provider, provider_payment_id=provider_payment_id).first()
        if payment is None:
            return None, False
        if status == Payment.Status.SUCCEEDED and payment.status in {Payment.Status.CREATED, Payment.Status.PENDING}:
            payment.status = Payment.Status.SUCCEEDED
        elif status in {Payment.Status.FAILED, Payment.Status.CANCELLED} and payment.status not in {Payment.Status.SUCCEEDED, Payment.Status.REFUNDED}:
            payment.status = status
        payment.provider_payment_id = provider_payment_id
        payment.save(update_fields=['status', 'provider_payment_id', 'updated_at'])
        PaymentTransaction.objects.create(payment=payment, amount=payment.amount, currency=payment.currency, status=payment.status, provider_reference=provider_payment_id, kind='status_update')
        event.processed_at = timezone.now()
        event.save(update_fields=['processed_at', 'updated_at'])
        return payment, True