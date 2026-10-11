from rest_framework import serializers


class GameActionSerializer(serializers.Serializer):
    action = serializers.ChoiceField(choices=['flip_gravity', 'pause', 'resume', 'finish'])
    client_tick = serializers.IntegerField(min_value=0, required=False)