from .cache_service import CacheService


class CacheInvalidation:
    def __init__(self, service=None):
        self.cache = service or CacheService()

    def invalidate(self, *keys):
        return all(self.cache.delete(key) for key in keys)

    def invalidate_user(self, user_id):
        from .keys.cache_keys import CacheKeys
        return self.invalidate(CacheKeys.user(user_id))

    def invalidate_level(self, level_id, leaderboard_limits=(10, 20, 50, 100)):
        from .keys.cache_keys import CacheKeys
        keys = [CacheKeys.level(level_id), *(CacheKeys.leaderboard(level_id, limit) for limit in leaderboard_limits)]
        return self.invalidate(*keys)