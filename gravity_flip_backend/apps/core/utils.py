from __future__ import annotations

import hashlib
import secrets
import uuid
from datetime import datetime, timezone
from typing import Any


def generate_unique_token(prefix: str = 'token') -> str:
    return f'{prefix}_{uuid.uuid4().hex}'


def generate_signature(payload: str, secret: str) -> str:
    return hashlib.sha256(f'{payload}:{secret}'.encode('utf-8')).hexdigest()


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


def random_secret(length: int = 32) -> str:
    return secrets.token_urlsafe(length)


def as_dict(obj: Any) -> dict[str, Any]:
    return getattr(obj, '__dict__', {})
