from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAdminUser
from rest_framework.response import Response

from ..models import Level
from ..serializers import CreateLevelSerializer, LevelConfigSerializer, UpdateLevelSerializer
from ..services.level_service import LevelService


class LevelViewSet(viewsets.ModelViewSet):
    queryset = Level.objects.select_related('difficulty', 'configuration', 'progression')
    lookup_field = 'slug'

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return LevelService.public_queryset()

    def get_permissions(self):
        return [IsAdminUser()] if self.action in {'create', 'update', 'partial_update', 'destroy', 'publish', 'archive', 'clone'} else [AllowAny()]

    def get_serializer_class(self):
        if self.action == 'create':
            return CreateLevelSerializer
        return UpdateLevelSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        level = LevelService.create(data=dict(serializer.validated_data), created_by=request.user)
        return Response(self._data(level), status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['post'])
    def publish(self, request, slug=None):
        level = LevelService.publish(self.get_object())
        return Response(self._data(level))

    @action(detail=True, methods=['post'])
    def archive(self, request, slug=None):
        return Response(self._data(LevelService.archive(self.get_object())))

    @action(detail=True, methods=['post'])
    def clone(self, request, slug=None):
        return Response(self._data(LevelService.clone_version(self.get_object(), created_by=request.user)), status=status.HTTP_201_CREATED)

    @staticmethod
    def _data(level):
        return {
            'id': str(level.id), 'slug': level.slug, 'title': level.title, 'description': level.description,
            'difficulty': level.difficulty.code, 'status': level.status, 'version': level.version,
            'seed': level.seed, 'definition': level.definition,
            'configuration': LevelConfigSerializer(level.configuration).data,
        }