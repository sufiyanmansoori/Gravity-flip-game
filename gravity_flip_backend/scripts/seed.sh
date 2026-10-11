#!/usr/bin/env sh
set -eu

: "${DJANGO_SETTINGS_MODULE:=config.settings.dev}"
export DJANGO_SETTINGS_MODULE
python manage.py migrate --noinput
python manage.py shell <<'PY'
from apps.level.models import Difficulty
from apps.achievement.models import Achievement
Difficulty.objects.get_or_create(code='easy', defaults={'name': 'Easy', 'rank': 1})
Difficulty.objects.get_or_create(code='normal', defaults={'name': 'Normal', 'rank': 2})
Achievement.objects.get_or_create(code='first-flight', defaults={'name': 'First Flight', 'criteria': {'total_submissions': 1}, 'points': 10})
print('Seed data is ready.')
PY
