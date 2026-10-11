from rest_framework import serializers


def validate_physics_input(delta_time):
    if not 0 < delta_time <= 0.25:
        raise serializers.ValidationError('delta_time must be greater than zero and at most 0.25 seconds.')
    return float(delta_time)