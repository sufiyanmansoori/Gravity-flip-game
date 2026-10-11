from channels.generic.websocket import AsyncJsonWebsocketConsumer

from .game_events import ALLOWED_EVENTS, GAME_CONNECTED, GAME_DISCONNECTED, GAME_ERROR, GAME_STATE


class GameConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        self.game_id = self.scope['url_route']['kwargs']['game_id']
        self.group_name = f'gravity_game_{self.game_id}'
        await self.channel_layer.group_add(self.group_name, self.channel_name)
        await self.accept()
        await self.send_json({'type': GAME_CONNECTED, 'game_id': self.game_id})

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(self.group_name, self.channel_name)
        await self.channel_layer.group_send(self.group_name, {'type': 'broadcast', 'event': GAME_DISCONNECTED, 'payload': {}})

    async def receive_json(self, content, **kwargs):
        event = content.get('type')
        if event not in ALLOWED_EVENTS:
            await self.send_json({'type': GAME_ERROR, 'detail': 'Unsupported game event'})
            return
        await self.channel_layer.group_send(self.group_name, {'type': 'broadcast', 'event': event, 'payload': content.get('payload', {})})

    async def broadcast(self, event):
        await self.send_json({'type': event['event'], 'payload': event['payload']})