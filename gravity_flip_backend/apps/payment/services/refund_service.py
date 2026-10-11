from decimal import Decimal

from django.db import transaction

from ..models import Payment, PaymentTransaction


class RefundService:
    @staticmethod
    @transaction.atomic
    def refund(payment, amount=None):
        if payment.status != Payment.Status.SUCCEEDED:
            raise ValueError('Only succeeded payments can be refunded.')
        amount = Decimal(amount or payment.amount)
        if amount <= 0 or amount > payment.amount:
            raise ValueError('Refund amount must be positive and no greater than the payment.')
        payment.status = Payment.Status.REFUNDED
        payment.save(update_fields=['status', 'updated_at'])
        PaymentTransaction.objects.create(payment=payment, amount=amount, currency=payment.currency, status=payment.status, kind='refund')
        return payment