from django.apps import AppConfig


class UserConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.user'
    label = 'gravity_user'
    verbose_name = 'Gravity Flip user profiles'