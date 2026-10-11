"""Optional integrations with external services.

Each provider is lazy-loaded so unused integrations do not affect application startup.
"""


class ExternalServiceError(RuntimeError):
    """Raised when an external provider is unavailable or incorrectly configured."""