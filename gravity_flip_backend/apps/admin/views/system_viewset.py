from rest_framework import serializers, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from ..models import SystemConfig
from ..services.system_config_service import SystemConfigService


class SystemViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAdminUser]

    @action(detail=False, methods=['get'])
    def config(self, request):
        configs = SystemConfig.objects.all().order_by('key')
        return Response([{'key': item.key, 'value': item.value, 'description': item.description, 'is_public': item.is_public, 'updated_at': item.updated_at} for item in configs])

    @action(detail=False, methods=['put', 'post'])
    def set_config(self, request):
        key = request.data.get('key')
        if not key or len(key) > 120:
            raise serializers.ValidationError({'key': 'A key of at most 120 characters is required.'})
        config = SystemConfigService.upsert(actor=request.user, key=key, value=request.data.get('value', {}), description=request.data.get('description', ''), is_public=bool(request.data.get('is_public', False)), request=request)
        return Response({'key': config.key, 'value': config.value, 'is_public': config.is_public}, status=status.HTTP_200_OK)