from __future__ import annotations

from django.urls import path

from .views import (
    PaymentTransactionListView,
    SubscriptionPlanListView,
    UserSubscriptionListView,
    create_checkout_session,
)

urlpatterns = [
    path('transactions/', PaymentTransactionListView.as_view(), name='payment-transactions'),
    path('plans/', SubscriptionPlanListView.as_view(), name='subscription-plans'),
    path('subscriptions/', UserSubscriptionListView.as_view(), name='user-subscriptions'),
    path('checkout/', create_checkout_session, name='checkout-session'),
]
