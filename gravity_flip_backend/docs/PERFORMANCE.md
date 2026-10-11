# Performance

Use Redis-backed cache keys from `cache.keys`, database indexes for high-cardinality filters, `select_related`/`prefetch_related`, and Celery for external or CPU-heavy work. Run `scripts/performance_test.sh` against a staging endpoint and monitor database query count, p95 latency, queue depth, and error rate.
