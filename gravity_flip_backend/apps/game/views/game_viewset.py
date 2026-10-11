from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from ..models import Game
from ..serializers import CreateGameSerializer, GameActionSerializer, GameStateSerializer, UpdateGameSerializer
from ..services.game_service import GameService
from ..services.game_state_service import GameStateService
from ..validators.game_validator import validate_game_action


class GameViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]
    queryset = Game.objects.all()

    def get_queryset(self):
        return self.queryset.filter(owner=self.request.user).select_related('state', 'physics').prefetch_related('players', 'obstacles')

    def create(self, request):
        serializer = CreateGameSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        game = GameService.create(owner=request.user, **serializer.validated_data)
        return Response(GameStateSerializer(game.state).data, status=status.HTTP_201_CREATED)

    def retrieve(self, request, pk=None):
        game = self.get_object()
        return Response(GameStateSerializer(game.state).data)

    def partial_update(self, request, pk=None):
        game = self.get_object()
        serializer = UpdateGameSerializer(game, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    @action(detail=True, methods=['post'])
    def game_action(self, request, pk=None):
        game = self.get_object()
        serializer = GameActionSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        action_name = validate_game_action(serializer.validated_data['action'], game.status)
        game = GameService.apply_action(game, request.user, action_name)
        return Response({'id': str(game.pk), 'status': game.status, 'tick': game.tick})

    @action(detail=True, methods=['post'])
    def snapshot(self, request, pk=None):
        game = self.get_object()
        state = GameStateService.save_snapshot(game, request.data.get('snapshot', {}), request.data.get('tick', game.tick))
        return Response(GameStateSerializer(state).data)