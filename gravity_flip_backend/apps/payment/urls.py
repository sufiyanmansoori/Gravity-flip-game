from django.urls import include, path
from rest_framework.routers import DefaultRouter

from .views import PaymentViewSet
from .webhooks.razorpay_webhook import razorpay_webhook
from .webhooks.stripe_webhook import stripe_webhook

router = DefaultRouter()
router.register('', PaymentViewSet, basename='payment')
urlpatterns = router.urls + [
    path('webhooks/stripe/', stripe_webhook, name='stripe-webhook'),
    path('webhooks/razorpay/', razorpay_webhook, name='razorpay-webhook'),
]