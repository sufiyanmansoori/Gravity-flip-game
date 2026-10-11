from django.apps import AppConfig


class PaymentConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.payment'
    label = 'gravity_payment'
    verbose_name = 'Gravity Flip payments'