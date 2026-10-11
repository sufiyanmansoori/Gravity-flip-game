from __future__ import annotations

from rest_framework import generics, permissions

from .models import Notification
from .serializers import NotificationSerializer


class NotificationListView(generics.ListCreateAPIView):
    queryset = Notification.objects.select_related('user', 'notification_type')
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return self.queryset.filter(user=self.request.user)


class NotificationDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Notification.objects.select_related('user', 'notification_type')
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return self.queryset.filter(user=self.request.user)
