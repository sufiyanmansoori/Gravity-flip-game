from django.conf import settings


DEFAULT_INDEX_SETTINGS = {
    'number_of_shards': 1,
    'number_of_replicas': 0,
    'analysis': {
        'analyzer': {
            'game_text': {'type': 'custom', 'tokenizer': 'standard', 'filter': ['lowercase', 'asciifolding']},
        },
    },
}


def elasticsearch_config():
    return {
        'hosts': getattr(settings, 'ELASTICSEARCH_HOSTS', ['http://localhost:9200']),
        'api_key': getattr(settings, 'ELASTICSEARCH_API_KEY', ''),
        'verify_certs': getattr(settings, 'ELASTICSEARCH_VERIFY_CERTS', True),
        'request_timeout': getattr(settings, 'ELASTICSEARCH_REQUEST_TIMEOUT', 5),
        'enabled': getattr(settings, 'ELASTICSEARCH_ENABLED', False),
    }