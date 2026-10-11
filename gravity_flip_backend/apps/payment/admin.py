from django.contrib import admin

from .models import Invoice, Payment, PaymentEvent, PaymentTransaction, Subscription, SubscriptionPlan


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'amount', 'currency', 'provider', 'status', 'created_at')
    list_filter = ('provider', 'status', 'currency')
    search_fields = ('user__username', 'user__email', 'provider_payment_id', 'idempotency_key')
    readonly_fields = ('id', 'created_at', 'updated_at')


admin.site.register((SubscriptionPlan, Subscription, Invoice, PaymentTransaction, PaymentEvent))