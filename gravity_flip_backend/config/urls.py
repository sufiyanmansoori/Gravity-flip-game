from __future__ import annotations

from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.http import JsonResponse
from django.urls import include, path
from django.views.generic import TemplateView
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns = [
    path('', TemplateView.as_view(template_name='pages/home.html'), name='home'),
    path('health/', lambda request: JsonResponse({'status': 'ok'}), name='health'),
    path('admin/', admin.site.urls),
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('api/v1/auth/', include('apps.auth.urls')),
    path('api/v1/game/', include('apps.game.urls')),
    path('api/v1/levels/', include('apps.level.urls')),
    path('api/v1/scores/', include('apps.score.urls')),
    path('api/v1/achievements/', include('apps.achievement.urls')),
    path('api/v1/user/', include('apps.user.urls')),
    path('api/v1/payment/', include('apps.payment.urls')),
    path('api/v1/notification/', include('apps.notification.urls')),
    path('api/v1/admin/', include('apps.admin.urls')),
    path('api/v1/shop/', include('apps.shop.urls')),
    path('api/v1/users/', include('apps.users.urls')),
    path('api/v1/games/', include('apps.games.urls')),
    path('api/v1/payments/', include('apps.payments.urls')),
    path('api/v1/notifications/', include('apps.notifications.urls')),
    path('api/v1/leaderboards/', include('apps.leaderboards.urls')),
    path('api/v1/analytics/', include('apps.analytics.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
