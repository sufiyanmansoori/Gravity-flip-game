#!/usr/bin/env sh
set -eu

url="${HEALTHCHECK_URL:-http://127.0.0.1:8000/api/schema/}"
curl --fail --silent --show-error --max-time "${HEALTHCHECK_TIMEOUT:-10}" "$url" >/dev/null
printf '%s\n' "Health check passed: $url"
