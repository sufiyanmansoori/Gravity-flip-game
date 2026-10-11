from functools import wraps

from django.core.cache import caches
from django.core.cache.backends.base import DEFAULT_TIMEOUT


class CacheService:
    """Small cache facade with explicit aliases and failure-tolerant reads."""

    def __init__(self, alias='default'):
        self.alias = alias

    @property
    def backend(self):
        return caches[self.alias]

    def get(self, key, default=None):
        try:
            return self.backend.get(key, default)
        except Exception:
            return default

    def set(self, key, value, timeout=DEFAULT_TIMEOUT):
        try:
            return self.backend.set(key, value, timeout)
        except Exception:
            return False

    def add(self, key, value, timeout=DEFAULT_TIMEOUT):
        try:
            return self.backend.add(key, value, timeout)
        except Exception:
            return False

    def delete(self, key):
        try:
            return self.backend.delete(key)
        except Exception:
            return False

    def get_or_set(self, key, default, timeout=DEFAULT_TIMEOUT):
        value = self.get(key, None)
        if value is not None:
            return value
        value = default() if callable(default) else default
        self.set(key, value, timeout)
        return value

    def remember(self, key, loader, timeout=300):
        return self.get_or_set(key, loader, timeout)

    @classmethod
    def cached(cls, key_builder, timeout=300, alias='default'):
        def decorator(function):
            @wraps(function)
            def wrapped(*args, **kwargs):
                key = key_builder(*args, **kwargs) if callable(key_builder) else key_builder
                service = cls(alias)
                return service.remember(key, lambda: function(*args, **kwargs), timeout)
            return wrapped
        return decorator