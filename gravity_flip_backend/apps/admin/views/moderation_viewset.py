from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from ..models import ModerationCase
from ..serializers.moderation_serializer import ModerationDecisionSerializer, ModerationSerializer
from ..services.moderation_service import ModerationService


class ModerationViewSet(viewsets.ModelViewSet):
    queryset = ModerationCase.objects.select_related('subject', 'reporter', 'assigned_to')
    serializer_class = ModerationSerializer
    permission_classes = [IsAdminUser]
    http_method_names = ['get', 'post', 'patch', 'head', 'options']

    def perform_create(self, serializer):
        serializer.save(reporter=self.request.user)

    @action(detail=True, methods=['post'])
    def decide(self, request, pk=None):
        case = self.get_object()
        serializer = ModerationDecisionSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        case = ModerationService.decide(actor=request.user, case=case, request=request, **serializer.validated_data)
        return Response(ModerationSerializer(case).data)