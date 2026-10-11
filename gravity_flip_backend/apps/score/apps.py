from django.apps import AppConfig


class ScoreConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.score'
    label = 'gravity_score'
    verbose_name = 'Gravity Flip scores'