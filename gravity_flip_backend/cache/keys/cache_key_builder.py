import hashlib
import json
import re


class CacheKeyBuilder:
    """Build bounded, namespaced keys that are safe for Redis and memcached."""

    _unsafe = re.compile(r'[^a-zA-Z0-9:._-]+')

    def __init__(self, prefix='gravity', version='v1'):
        self.prefix = prefix
        self.version = version

    def build(self, namespace, *parts):
        values = [self._clean(namespace), *(self._clean(part) for part in parts)]
        key = ':'.join([self.prefix, self.version, *values])
        return key if len(key) <= 240 else f'{key[:180]}:{self._digest(values)}'

    def from_params(self, namespace, params):
        encoded = json.dumps(params, sort_keys=True, separators=(',', ':'), default=str)
        return self.build(namespace, self._digest([encoded]))

    @classmethod
    def _clean(cls, value):
        return cls._unsafe.sub('_', str(value)).strip('_') or 'empty'

    @staticmethod
    def _digest(values):
        return hashlib.sha256('|'.join(map(str, values)).encode()).hexdigest()[:32]