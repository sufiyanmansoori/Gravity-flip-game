from rest_framework.routers import DefaultRouter

from .views import LevelViewSet

router = DefaultRouter()
router.register('', LevelViewSet, basename='level')
urlpatterns = router.urls