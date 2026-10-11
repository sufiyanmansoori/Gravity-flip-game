from .cache_key_builder import CacheKeyBuilder


class CacheKeys:
    builder = CacheKeyBuilder()

    @classmethod
    def user(cls, user_id):
        return cls.builder.build('user', user_id)

    @classmethod
    def level(cls, level_id):
        return cls.builder.build('level', level_id)

    @classmethod
    def leaderboard(cls, level_id, limit=20):
        return cls.builder.build('leaderboard', level_id, limit)

    @classmethod
    def product(cls, product_id):
        return cls.builder.build('product', product_id)

    @classmethod
    def query(cls, namespace, params):
        return cls.builder.from_params(namespace, params)