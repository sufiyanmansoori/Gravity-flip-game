from django.apps import AppConfig


class GameConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.game'
    label = 'gravity_game'
    verbose_name = 'Gravity Flip game'