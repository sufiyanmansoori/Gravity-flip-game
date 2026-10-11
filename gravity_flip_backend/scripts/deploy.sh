#!/usr/bin/env sh
set -eu

: "${DJANGO_SETTINGS_MODULE:=config.settings.prod}"
export DJANGO_SETTINGS_MODULE

python manage.py check --deploy
python manage.py migrate --noinput
python manage.py collectstatic --noinput
exec gunicorn config.wsgi:application --bind "${GUNICORN_BIND:-0.0.0.0:8000}" --workers "${GUNICORN_WORKERS:-3}" --timeout "${GUNICORN_TIMEOUT:-60}" --access-logfile - --error-logfile -
