from time import monotonic

from ..cache_service import CacheService


class RefreshAhead:
    def __init__(self, cache=None):
        self.cache = cache or CacheService()

    def get(self, key, loader, timeout=300, refresh_window=60, refresher=None):
        envelope = self.cache.get(key)
        if not envelope:
            value = loader()
            self.cache.set(key, {'value': value, 'refresh_at': monotonic() + max(0, timeout - refresh_window)}, timeout)
            return value
        if refresher and monotonic() >= envelope.get('refresh_at', 0):
            value = refresher(loader)
            self.cache.set(key, {'value': value, 'refresh_at': monotonic() + max(0, timeout - refresh_window)}, timeout)
            return value
        return envelope['value']