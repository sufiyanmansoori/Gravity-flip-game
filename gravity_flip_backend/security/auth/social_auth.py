from dataclasses import dataclass

from django.conf import settings


@dataclass(frozen=True)
class SocialAuthConfig:
    provider: str
    client_id: str
    client_secret: str

    @classmethod
    def from_settings(cls, provider):
        prefix = provider.upper()
        return cls(provider, getattr(settings, f'{prefix}_CLIENT_ID', ''), getattr(settings, f'{prefix}_CLIENT_SECRET', ''))

    def validate(self):
        if not self.client_id or not self.client_secret:
            raise ValueError(f'Social auth credentials for {self.provider} are incomplete.')
        return self
