from rest_framework import serializers

from ..models import GameState, Obstacle, PhysicsData, Player


class PlayerStateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Player
        fields = ['user', 'x', 'y', 'velocity_x', 'velocity_y', 'width', 'height', 'alive']


class ObstacleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Obstacle
        fields = ['id', 'obstacle_type', 'x', 'y', 'width', 'height', 'velocity_x', 'velocity_y', 'active', 'metadata']


class PhysicsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PhysicsData
        exclude = ['id', 'game', 'created_at', 'updated_at']


class GameStateSerializer(serializers.ModelSerializer):
    players = serializers.SerializerMethodField()
    obstacles = serializers.SerializerMethodField()
    physics = serializers.SerializerMethodField()

    class Meta:
        model = GameState
        fields = ['game', 'gravity', 'world_width', 'world_height', 'snapshot', 'checksum', 'players', 'obstacles', 'physics']

    def get_players(self, obj):
        return PlayerStateSerializer(obj.game.players.filter(alive=True), many=True).data

    def get_obstacles(self, obj):
        return ObstacleSerializer(obj.game.obstacles.filter(active=True), many=True).data

    def get_physics(self, obj):
        return PhysicsSerializer(obj.game.physics).data