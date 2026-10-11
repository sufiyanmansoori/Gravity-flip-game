from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from ..models import Notification
from ..serializers import NotificationSerializer
from ..services.notification_service import NotificationService


class NotificationViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = NotificationSerializer

    def get_queryset(self):
        return Notification.objects.filter(user=self.request.user).select_related('template')

    def list(self, request):
        notifications = self.get_queryset()
        if request.query_params.get('unread') == 'true':
            notifications = notifications.filter(is_read=False)
        return Response(NotificationSerializer(notifications, many=True).data)

    @action(detail=True, methods=['post'])
    def read(self, request, pk=None):
        notification = self.get_queryset().get(pk=pk)
        return Response(NotificationSerializer(NotificationService.mark_read(notification)).data)

    @action(detail=False, methods=['post'])
    def read_all(self, request):
        count = self.get_queryset().filter(is_read=False).update(is_read=True)
        return Response({'marked_read': count})