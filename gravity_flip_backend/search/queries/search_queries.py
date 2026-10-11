from .search_query_builder import SearchQueryBuilder


class SearchQueries:
    @staticmethod
    def text(text, fields):
        return SearchQueryBuilder().multi_match(text, fields).build()

    @staticmethod
    def products(text='', category=None, minimum_price=None, maximum_price=None):
        return SearchQueryBuilder().multi_match(text, ['name^3', 'description', 'sku']).term('category', category).range('price', minimum=minimum_price, maximum=maximum_price).build()

    @staticmethod
    def levels(text='', difficulty=None, status='published'):
        return SearchQueryBuilder().multi_match(text, ['title^3', 'description']).term('difficulty', difficulty).term('status', status).build()

    @staticmethod
    def users(text='', country=None, premium=None):
        builder = SearchQueryBuilder().multi_match(text, ['username^3', 'display_name', 'email']).term('country', country)
        if premium is not None:
            builder.filters.append({'term': {'is_premium': bool(premium)}})
        return builder.build()