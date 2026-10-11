from django.apps import AppConfig


class AchievementConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.achievement'
    label = 'gravity_achievement'
    verbose_name = 'Gravity Flip achievements'