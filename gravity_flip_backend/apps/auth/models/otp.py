from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class OneTimePassword(TimeStampedModel):
    class Purpose(models.TextChoices):
        VERIFY_EMAIL = 'verify_email', 'Verify email'
        RESET_PASSWORD = 'reset_password', 'Reset password'
        TWO_FACTOR = 'two_factor', 'Two-factor authentication'

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='one_time_passwords')
    purpose = models.CharField(max_length=32, choices=Purpose.choices)
    code_hash = models.CharField(max_length=128)
    expires_at = models.DateTimeField()
    used_at = models.DateTimeField(null=True, blank=True)
    attempts = models.PositiveSmallIntegerField(default=0)

    class Meta:
        db_table = 'auth_one_time_passwords'
        indexes = [models.Index(fields=['user', 'purpose', 'created_at'])]

    @property
    def is_valid(self):
        from django.utils import timezone
        return self.used_at is None and self.expires_at > timezone.now() and self.attempts < 5