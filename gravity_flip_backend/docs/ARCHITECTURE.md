# Architecture

The backend is a Django/DRF modular monolith. Domain apps own models, serializers, services, views, URLs, and tests. Shared packages provide cache, security, search, external integrations, logging, and Celery tasks.

PostgreSQL is the production database. Redis provides cache, Channels, and Celery broker/result services. Provider integrations are lazy-loaded so local development can run without optional SDKs.
