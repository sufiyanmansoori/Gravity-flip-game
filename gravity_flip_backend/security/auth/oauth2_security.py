from dataclasses import dataclass

from django.conf import settings


@dataclass(frozen=True)
class OAuth2Config:
    provider: str
    client_id: str
    authorization_url: str
    token_url: str
    scopes: tuple

    @classmethod
    def from_settings(cls, provider='default'):
        prefix = provider.upper()
        return cls(provider, getattr(settings, f'{prefix}_OAUTH_CLIENT_ID', ''), getattr(settings, f'{prefix}_OAUTH_AUTHORIZATION_URL', ''), getattr(settings, f'{prefix}_OAUTH_TOKEN_URL', ''), tuple(getattr(settings, f'{prefix}_OAUTH_SCOPES', [])))

    def validate(self):
        if not self.client_id or not self.authorization_url or not self.token_url:
            raise ValueError(f'OAuth2 configuration for {self.provider} is incomplete.')
        return self
