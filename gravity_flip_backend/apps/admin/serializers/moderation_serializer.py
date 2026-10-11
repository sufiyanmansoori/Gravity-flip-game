from rest_framework import serializers

from ..models import ModerationCase


class ModerationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ModerationCase
        fields = ['id', 'subject', 'reporter', 'assigned_to', 'reason', 'details', 'status', 'action', 'resolution', 'metadata', 'created_at', 'updated_at']
        read_only_fields = ['id', 'reporter', 'created_at', 'updated_at']


class ModerationDecisionSerializer(serializers.Serializer):
    status = serializers.ChoiceField(choices=[ModerationCase.Status.RESOLVED, ModerationCase.Status.DISMISSED])
    action = serializers.ChoiceField(choices=ModerationCase.Action.values)
    resolution = serializers.CharField(max_length=2000)