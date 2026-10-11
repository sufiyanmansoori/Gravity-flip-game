from django.test import TestCase

from apps.game.models import Game
from apps.game.services.game_service import GameService
from apps.users.models import User


class GameServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')

    def test_create_initializes_game_state_and_player(self):
        game = GameService.create(self.user, 'training')
        self.assertEqual(game.status, Game.Status.CREATED)
        self.assertTrue(game.players.filter(user=self.user).exists())
        self.assertEqual(game.state.gravity, 1)

    def test_owner_can_flip_gravity(self):
        game = GameService.create(self.user, 'training')
        GameService.apply_action(game, self.user, 'flip_gravity')
        game.state.refresh_from_db()
        self.assertEqual(game.state.gravity, -1)