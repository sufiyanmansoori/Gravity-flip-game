"""Reusable application security primitives and policy configuration."""

from external import ExternalServiceError


def _missing_dependency(name):
    return ExternalServiceError(f'Install {name} to use this security feature.')


from .helmet_config import security_headers

__all__ = ['security_headers']
