from dataclasses import dataclass

from django.conf import settings


@dataclass(frozen=True)
class SAMLConfig:
    entity_id: str
    sso_url: str
    certificate: str

    @classmethod
    def from_settings(cls):
        return cls(getattr(settings, 'SAML_ENTITY_ID', ''), getattr(settings, 'SAML_SSO_URL', ''), getattr(settings, 'SAML_IDP_CERTIFICATE', ''))

    def validate(self):
        if not all((self.entity_id, self.sso_url, self.certificate)):
            raise ValueError('SAML entity ID, SSO URL, and IdP certificate are required.')
        return self
