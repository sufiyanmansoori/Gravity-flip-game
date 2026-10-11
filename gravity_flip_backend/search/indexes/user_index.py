class UserIndex:
    name = 'gravity-users'
    mapping = {
        'properties': {
            'id': {'type': 'keyword'}, 'username': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
            'email': {'type': 'keyword'}, 'display_name': {'type': 'text'}, 'country': {'type': 'keyword'},
            'is_premium': {'type': 'boolean'}, 'date_joined': {'type': 'date'},
        },
    }

    @staticmethod
    def document(user):
        return {'id': str(user.pk), 'username': user.username, 'email': user.email, 'display_name': getattr(user, 'first_name', ''), 'country': getattr(user, 'country', ''), 'is_premium': user.is_premium, 'date_joined': user.date_joined.isoformat() if user.date_joined else None}