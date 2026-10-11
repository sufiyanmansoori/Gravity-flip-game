from __future__ import annotations

from rest_framework import generics, permissions

from .models import AnalyticsSnapshot, EventLog
from .serializers import AnalyticsSnapshotSerializer, EventLogSerializer


class EventLogListView(generics.ListAPIView):
    queryset = EventLog.objects.select_related('user')
    serializer_class = EventLogSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return self.queryset.filter(user=self.request.user)


class AnalyticsSnapshotListView(generics.ListAPIView):
    queryset = AnalyticsSnapshot.objects.all()
    serializer_class = AnalyticsSnapshotSerializer
    permission_classes = [permissions.IsAuthenticated]
