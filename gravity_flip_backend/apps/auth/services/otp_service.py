import hashlib
import secrets
from datetime import timedelta

from django.db import transaction
from django.utils import timezone

from ..models import OneTimePassword


class OTPService:
    @staticmethod
    @transaction.atomic
    def issue(user, purpose, lifetime=timedelta(minutes=10)):
        code = f'{secrets.randbelow(1_000_000):06d}'
        OneTimePassword.objects.filter(user=user, purpose=purpose, used_at__isnull=True).update(used_at=timezone.now())
        record = OneTimePassword.objects.create(user=user, purpose=purpose, code_hash=hashlib.sha256(code.encode()).hexdigest(), expires_at=timezone.now() + lifetime)
        return record, code

    @staticmethod
    @transaction.atomic
    def verify(user, purpose, code):
        record = OneTimePassword.objects.select_for_update().filter(user=user, purpose=purpose, used_at__isnull=True).order_by('-created_at').first()
        if not record or not record.is_valid:
            return False
        record.attempts += 1
        valid = secrets.compare_digest(record.code_hash, hashlib.sha256(code.encode()).hexdigest())
        if valid:
            record.used_at = timezone.now()
        record.save(update_fields=['attempts', 'used_at', 'updated_at'])
        return valid