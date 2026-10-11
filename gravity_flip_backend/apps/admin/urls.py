from rest_framework.routers import DefaultRouter

from .views import AdminViewSet, ModerationViewSet, SystemViewSet

router = DefaultRouter()
router.register('control', AdminViewSet, basename='admin-control')
router.register('moderation', ModerationViewSet, basename='moderation')
router.register('system', SystemViewSet, basename='system')
urlpatterns = router.urls