from ..cache_service import CacheService


class CacheAside:
    def __init__(self, cache=None):
        self.cache = cache or CacheService()

    def get(self, key, loader, timeout=300):
        return self.cache.remember(key, loader, timeout)

    def invalidate(self, key):
        return self.cache.delete(key)