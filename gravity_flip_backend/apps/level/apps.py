from django.apps import AppConfig


class LevelConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.level'
    label = 'gravity_level'
    verbose_name = 'Gravity Flip levels'