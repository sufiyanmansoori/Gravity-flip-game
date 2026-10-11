from __future__ import annotations

from django.urls import path

from . import consumers

websocket_urlpatterns = [
    path('ws/game/<str:room_name>/', consumers.GameRoomConsumer.as_asgi()),
]
