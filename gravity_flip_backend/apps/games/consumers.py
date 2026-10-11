from __future__ import annotations

import json

from channels.generic.websocket import AsyncJsonWebsocketConsumer


class GameRoomConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = f'game_{self.room_name}'

        await self.channel_layer.group_add(self.room_group_name, self.channel_name)
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    async def receive_json(self, content, **kwargs):
        event_type = content.get('type', 'state')
        payload = content.get('payload', {})

        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'game.event',
                'event': event_type,
                'payload': payload,
                'sender': self.channel_name,
            },
        )

    async def game_event(self, event):
        await self.send_json(
            {
                'type': event['event'],
                'payload': event['payload'],
                'sender': event.get('sender'),
            }
        )
