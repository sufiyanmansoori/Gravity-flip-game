from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

from ..services.payment_service import PaymentService
from ..services.stripe_service import StripeService


@csrf_exempt
def stripe_webhook(request):
    if request.method != 'POST' or not StripeService.verify_signature(request.body, request.headers.get('Stripe-Signature', '')):
        return JsonResponse({'detail': 'Invalid webhook'}, status=400)
    event = StripeService.parse_event(request.body)
    data = event.get('data', {}).get('object', {})
    metadata = data.get('metadata', {})
    payment, processed = PaymentService.apply_provider_status(provider='stripe', provider_payment_id=data.get('payment_intent', data.get('id', '')), payment_id=metadata.get('payment_id'), status='succeeded' if event.get('type') in {'payment_intent.succeeded', 'checkout.session.completed'} else 'failed', event_id=event.get('id', ''), payload=event)
    return JsonResponse({'received': True, 'processed': processed})