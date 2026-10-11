from .audit_log_service import AuditLogService
from .user_management_service import UserManagementService


class AdminService:
    @staticmethod
    def dashboard():
        from apps.achievement.models import UserAchievement
        from apps.analytics.models.event import Event
        from apps.users.models import User
        return {'users': User.objects.count(), 'active_users': User.objects.filter(is_active=True).count(), 'events': Event.objects.count(), 'achievements_unlocked': UserAchievement.objects.count()}

    @staticmethod
    def user_snapshot(user):
        return {'id': user.pk, 'username': user.username, 'email': user.email, 'is_active': user.is_active, 'is_staff': user.is_staff}