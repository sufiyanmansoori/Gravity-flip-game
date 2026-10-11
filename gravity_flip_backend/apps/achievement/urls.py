from rest_framework.routers import DefaultRouter

from .views import AchievementViewSet

router = DefaultRouter()
router.register('', AchievementViewSet, basename='achievement')
urlpatterns = router.urls