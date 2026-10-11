from __future__ import annotations

from rest_framework.routers import DefaultRouter

from .views.analytics_viewset import AnalyticsViewSet

router = DefaultRouter()
router.register('', AnalyticsViewSet, basename='analytics')
urlpatterns = router.urls
