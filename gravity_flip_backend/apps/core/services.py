from __future__ import annotations

import logging
from typing import Any

logger = logging.getLogger(__name__)


class BaseService:
    """Base service class providing shared operational helpers."""

    @staticmethod
    def safe_log(message: str, **context: Any) -> None:
        logger.info(message, extra=context)

    @staticmethod
    def normalize_pagination(page: int, page_size: int) -> tuple[int, int]:
        page = max(1, int(page))
        page_size = max(1, min(int(page_size), 100))
        return page, page_size
