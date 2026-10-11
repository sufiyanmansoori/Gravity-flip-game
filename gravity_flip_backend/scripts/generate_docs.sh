#!/usr/bin/env sh
set -eu

: "${DJANGO_SETTINGS_MODULE:=config.settings.dev}"
export DJANGO_SETTINGS_MODULE
mkdir -p docs/swagger
python manage.py spectacular --file docs/swagger/swagger.json --validate
printf '%s\n' 'OpenAPI specification generated at docs/swagger/swagger.json'
