from django.apps import AppConfig


class NotificationConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.notification'
    label = 'gravity_notification'
    verbose_name = 'Gravity Flip notifications'