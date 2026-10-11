from rest_framework import serializers

from apps.users.models import User


class UserManagementSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'is_active', 'is_staff', 'is_superuser', 'is_verified', 'is_premium', 'date_joined', 'last_login']
        read_only_fields = ['id', 'username', 'date_joined', 'last_login']