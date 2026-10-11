from apps.game.models import Game
from apps.level.models import Difficulty, Level

from .user_fixtures import user


def game_user(**overrides):
    return user(username='game-user', email='game@example.com', **overrides)


def game_level(**overrides):
    difficulty, _ = Difficulty.objects.get_or_create(code='test-easy', defaults={'name': 'Test Easy', 'rank': 1})
    data = {'slug': 'test-level', 'title': 'Test Level', 'difficulty': difficulty, 'status': Level.Status.PUBLISHED}
    data.update(overrides)
    return Level.objects.create(**data)


def game(owner=None, level_id='test-level'):
    owner = owner or game_user()
    return Game.objects.create(owner=owner, level_id=level_id, seed=42)