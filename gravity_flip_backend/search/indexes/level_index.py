class LevelIndex:
    name = 'gravity-levels'
    mapping = {'properties': {'id': {'type': 'keyword'}, 'slug': {'type': 'keyword'}, 'title': {'type': 'text'}, 'description': {'type': 'text'}, 'difficulty': {'type': 'keyword'}, 'status': {'type': 'keyword'}, 'version': {'type': 'integer'}}}

    @staticmethod
    def document(level):
        return {'id': str(level.pk), 'slug': level.slug, 'title': level.title, 'description': level.description, 'difficulty': level.difficulty.code, 'status': level.status, 'version': level.version}