# Gravity Flip Game Backend

Production-ready Django backend architecture for the Gravity Flip Game.

## Features

- Django + DRF API layer
- PostgreSQL-ready configuration
- Redis + Celery task processing
- WebSocket game room support via Channels
- Modular app-based structure with users, games, payments, notifications, leaderboards, analytics
- Docker and production deployment settings

## Quick start

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

## Production mode

```bash
env DJANGO_SETTINGS_MODULE=config.settings.prod python manage.py migrate
```

## Docker

```bash
docker compose up --build
```

For the production service stack:

```bash
docker compose -f docker/docker-compose.yml up --build -d
```

## Tests and quality

```bash
python manage.py check
python manage.py test
pytest --cov
```

## Background workers

```bash
celery -A config.celery.app worker --loglevel=INFO
celery -A config.celery.app beat --loglevel=INFO
```

Operational scripts are in `scripts/`; deployment and security guidance is in `docs/`.

## API docs

- Swagger UI: <http://localhost:8000/api/docs/>
- OpenAPI Schema: <http://localhost:8000/api/schema/>
