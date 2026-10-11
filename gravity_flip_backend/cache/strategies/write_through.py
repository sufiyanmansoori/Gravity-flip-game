from ..cache_service import CacheService


class WriteThrough:
    def __init__(self, cache=None):
        self.cache = cache or CacheService()

    def write(self, key, value, writer, timeout=300):
        result = writer(value)
        self.cache.set(key, value, timeout)
        return result

    def delete(self, key, deleter=None):
        result = deleter() if deleter else None
        self.cache.delete(key)
        return result