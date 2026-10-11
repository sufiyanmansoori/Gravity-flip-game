#!/usr/bin/env sh
set -eu

python manage.py check --deploy
curl --fail --silent --show-error "${HEALTHCHECK_URL:-http://127.0.0.1:8000/api/schema/}" >/dev/null
printf '%s\n' 'Container health check passed.'
