# Database

Production uses PostgreSQL with Django migrations. Apply migrations with `scripts/migrate.sh`.

Important boundaries:

- `users.User` is the canonical authentication model.
- Game, level, score, payment, shop, notification, achievement, analytics, and admin apps use explicit foreign keys and transactional services.
- Order and payment records preserve immutable price/status snapshots.
