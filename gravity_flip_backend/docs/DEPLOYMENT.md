# Deployment

1. Provision PostgreSQL, Redis, object storage, and secrets.
2. Copy `.env.example` to `.env` and replace every development secret.
3. Build with `docker compose -f docker/docker-compose.yml build`.
4. Start with `docker compose -f docker/docker-compose.yml up -d`.
5. Run `scripts/health_check.sh` and inspect `docker compose logs`.

Run workers and beat as separate processes. Put TLS termination and domain routing in a managed load balancer or Nginx.
