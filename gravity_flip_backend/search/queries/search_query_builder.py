class SearchQueryBuilder:
    """Build a restricted, composable Elasticsearch bool query."""

    def __init__(self):
        self.must = []
        self.filters = []
        self.should = []
        self.minimum_should_match = None

    def multi_match(self, text, fields, fuzziness='AUTO'):
        if text and fields:
            self.must.append({'multi_match': {'query': text, 'fields': list(fields), 'fuzziness': fuzziness}})
        return self

    def match(self, field, value):
        if value not in (None, ''):
            self.must.append({'match': {field: value}})
        return self

    def term(self, field, value):
        if value not in (None, ''):
            self.filters.append({'term': {field: value}})
        return self

    def terms(self, field, values):
        values = list(values or [])
        if values:
            self.filters.append({'terms': {field: values}})
        return self

    def range(self, field, *, minimum=None, maximum=None):
        bounds = {}
        if minimum is not None:
            bounds['gte'] = minimum
        if maximum is not None:
            bounds['lte'] = maximum
        if bounds:
            self.filters.append({'range': {field: bounds}})
        return self

    def should_match(self, query):
        if query:
            self.should.append(query)
        return self

    def build(self):
        bool_query = {}
        if self.must:
            bool_query['must'] = self.must
        if self.filters:
            bool_query['filter'] = self.filters
        if self.should:
            bool_query['should'] = self.should
            bool_query['minimum_should_match'] = self.minimum_should_match or 1
        return {'query': {'bool': bool_query or {'must': [{'match_all': {}}]}}}