from apps.game.services.game_service import GameService
from tests.fixtures.game_fixtures import game_level, game_user
from tests.helpers.test_setup import ServiceTestCase


class GameFlowTests(ServiceTestCase):
    def test_player_can_create_and_flip_game(self):
        player = game_user()
        game_level()
        game = GameService.create(owner=player, level_id='test-level', seed=42)
        GameService.apply_action(game, player, 'flip_gravity')
        game.refresh_from_db()
        game.state.refresh_from_db()
        self.assertEqual(game.status, 'running')
        self.assertEqual(game.state.gravity, -1)