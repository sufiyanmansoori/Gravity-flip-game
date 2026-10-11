from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import hashlib
import hmac

from ..services.payment_service import PaymentService


@csrf_exempt
def razorpay_webhook(request):
    expected = hmac.new(str(getattr(settings, 'RAZORPAY_WEBHOOK_SECRET', '')).encode(), request.body, hashlib.sha256).hexdigest()
    signature = request.headers.get('X-Razorpay-Signature', '')
    if request.method != 'POST' or not signature or not hmac.compare_digest(expected, signature):
        return JsonResponse({'detail': 'Invalid webhook'}, status=400)
    import json
    event = json.loads(request.body)
    entity = event.get('payload', {}).get('payment', {}).get('entity', {})
    payment, processed = PaymentService.apply_provider_status(provider='razorpay', provider_payment_id=entity.get('id', ''), status='succeeded' if event.get('event') == 'payment.captured' else 'failed', event_id=event.get('id', event.get('event', '')), payload=event)
    return JsonResponse({'received': True, 'processed': processed})