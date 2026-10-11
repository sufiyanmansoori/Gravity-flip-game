from rest_framework import serializers


def validate_game_action(action, current_status):
    allowed = {'created': {'resume', 'flip_gravity'}, 'running': {'flip_gravity', 'pause', 'finish'}, 'paused': {'resume', 'finish'}}
    if action not in allowed.get(current_status, set()):
        raise serializers.ValidationError(f'Action {action!r} is not valid while game is {current_status!r}.')
    return action