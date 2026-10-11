from celery import shared_task


@shared_task(bind=True, autoretry_for=(ConnectionError, TimeoutError), retry_backoff=True, retry_jitter=True, max_retries=5, queue='payments')
def process_payment_status_task(self, provider, provider_payment_id, status, event_id, payment_id=None, payload=None):
    from apps.payment.services.payment_service import PaymentService
    payment, processed = PaymentService.apply_provider_status(provider=provider, provider_payment_id=provider_payment_id, status=status, event_id=event_id, payment_id=payment_id, payload=payload)
    return {'payment_id': str(payment.pk) if payment else None, 'processed': processed}