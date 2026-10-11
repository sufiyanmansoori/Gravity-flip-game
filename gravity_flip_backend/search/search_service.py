from external import ExternalServiceError

from .search_config import elasticsearch_config


class SearchService:
    def __init__(self, client=None):
        self._client = client

    @property
    def client(self):
        if self._client is None:
            config = elasticsearch_config()
            if not config['enabled']:
                raise ExternalServiceError('Elasticsearch is disabled.')
            try:
                from elasticsearch import Elasticsearch
            except ImportError as exc:
                raise ExternalServiceError('Install elasticsearch to use search.') from exc
            options = {'hosts': config['hosts'], 'verify_certs': config['verify_certs'], 'request_timeout': config['request_timeout']}
            if config['api_key']:
                options['api_key'] = config['api_key']
            self._client = Elasticsearch(**options)
        return self._client

    def search(self, index, query, *, limit=20, offset=0, sort=None):
        if not 1 <= limit <= 100:
            raise ValueError('limit must be between 1 and 100.')
        body = dict(query)
        body['size'] = limit
        body['from'] = offset
        if sort:
            body['sort'] = sort
        response = self.client.search(index=index, body=body)
        return {'total': self._total(response), 'items': [hit.get('_source', {}) | {'id': hit.get('_id')} for hit in response.get('hits', {}).get('hits', [])]}

    def index_document(self, index, document_id, document):
        return self.client.index(index=index, id=str(document_id), document=document, refresh='wait_for')

    def delete_document(self, index, document_id):
        return self.client.delete(index=index, id=str(document_id), refresh='wait_for', ignore=[404])

    def ensure_index(self, index_definition):
        indices = self.client.indices
        if not indices.exists(index=index_definition.name):
            return indices.create(index=index_definition.name, settings=index_definition.settings if hasattr(index_definition, 'settings') else {}, mappings=index_definition.mapping)
        return {'acknowledged': True, 'created': False}

    @staticmethod
    def _total(response):
        total = response.get('hits', {}).get('total', 0)
        return total.get('value', 0) if isinstance(total, dict) else total