import os

from channels.routing import ProtocolTypeRouter, URLRouter
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.dev')

django_asgi_app = get_asgi_application()

from apps.games.routing import websocket_urlpatterns  # noqa: E402
from apps.game.routing import websocket_urlpatterns as gravity_websocket_urlpatterns  # noqa: E402

application = ProtocolTypeRouter(
    {
        'http': django_asgi_app,
        'websocket': URLRouter(websocket_urlpatterns + gravity_websocket_urlpatterns),
    }
)
