from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from apps.users.models import User

from ..serializers import UserManagementSerializer
from ..services.admin_service import AdminService
from ..services.user_management_service import UserManagementService


class AdminViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAdminUser]

    @action(detail=False, methods=['get'])
    def dashboard(self, request):
        return Response(AdminService.dashboard())

    @action(detail=False, methods=['get'])
    def users(self, request):
        queryset = UserManagementService.queryset()
        search = request.query_params.get('search', '').strip()
        if search:
            queryset = queryset.filter(username__icontains=search) | queryset.filter(email__icontains=search)
        return Response(UserManagementSerializer(queryset[:100], many=True).data)

    @action(detail=True, methods=['post'], url_path='activate')
    def activate(self, request, pk=None):
        user = User.objects.get(pk=pk)
        result = UserManagementService.set_active(actor=request.user, user=user, is_active=True, reason=request.data.get('reason', ''), request=request)
        return Response(UserManagementSerializer(result).data)

    @action(detail=True, methods=['post'], url_path='deactivate')
    def deactivate(self, request, pk=None):
        user = User.objects.get(pk=pk)
        result = UserManagementService.set_active(actor=request.user, user=user, is_active=False, reason=request.data.get('reason', ''), request=request)
        return Response(UserManagementSerializer(result).data)