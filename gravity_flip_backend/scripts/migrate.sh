#!/usr/bin/env sh
set -eu

: "${DJANGO_SETTINGS_MODULE:=config.settings.dev}"
export DJANGO_SETTINGS_MODULE
python manage.py check
python manage.py migrate --plan
python manage.py migrate --noinput
python manage.py showmigrations --plan
