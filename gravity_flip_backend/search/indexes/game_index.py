class GameIndex:
    name = 'gravity-games'
    mapping = {'properties': {'id': {'type': 'keyword'}, 'owner_id': {'type': 'keyword'}, 'level_id': {'type': 'keyword'}, 'status': {'type': 'keyword'}, 'score': {'type': 'long'}, 'created_at': {'type': 'date'}}}

    @staticmethod
    def document(game):
        return {'id': str(game.pk), 'owner_id': str(game.owner_id), 'level_id': game.level_id, 'status': game.status, 'score': game.score, 'created_at': game.created_at.isoformat()}