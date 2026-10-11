from ..cache_service import CacheService


class WriteBehind:
    def __init__(self, enqueue, cache=None):
        self.enqueue = enqueue
        self.cache = cache or CacheService()

    def write(self, key, value, timeout=300, **payload):
        self.cache.set(key, value, timeout)
        return self.enqueue(key=key, value=value, **payload)

    def delete(self, key, **payload):
        self.cache.delete(key)
        return self.enqueue(key=key, delete=True, **payload)