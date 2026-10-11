from rest_framework import serializers, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.response import Response

from ..serializers import AnalyticsQuerySerializer, EventSerializer
from ..services.analytics_service import AnalyticsService
from ..services.event_service import EventService
from ..services.metrics_service import MetricsService
from ..services.report_service import ReportService


class AnalyticsViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]

    @action(detail=False, methods=['post'])
    def events(self, request):
        serializer = EventSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            event, created = EventService.record(user=request.user, ip_address=request.META.get('REMOTE_ADDR'), **serializer.validated_data)
        except ValueError as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response(EventSerializer(event).data | {'created': created}, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=False, methods=['get'])
    def overview(self, request):
        return Response(AnalyticsService.overview(user=None if request.user.is_staff and request.query_params.get('all') == 'true' else request.user))

    @action(detail=False, methods=['get'])
    def report(self, request):
        query = AnalyticsQuerySerializer(data=request.query_params)
        query.is_valid(raise_exception=True)
        return Response({'metric': query.validated_data['metric'], 'breakdown': ReportService.event_breakdown(start=query.validated_data['start'], end=query.validated_data['end'], user=None if request.user.is_staff else request.user), 'metrics': list(MetricsService.query(**query.validated_data).values('bucket', 'count', 'total'))})

    @action(detail=False, methods=['post'], permission_classes=[IsAdminUser])
    def aggregate(self, request):
        aggregate = MetricsService.aggregate_day(metric=request.data.get('metric', 'events'), dimension=request.data.get('dimension', ''))
        return Response({'metric': aggregate.metric, 'bucket': aggregate.bucket, 'count': aggregate.count, 'total': aggregate.total})

    @action(detail=False, methods=['get'])
    def funnel(self, request):
        steps = request.query_params.getlist('step')
        if not steps:
            raise serializers.ValidationError({'step': 'At least one step is required.'})
        return Response(AnalyticsService.funnel(steps=steps, user=None if request.user.is_staff else request.user))