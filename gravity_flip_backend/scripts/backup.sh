#!/usr/bin/env sh
set -eu

backup_dir="${BACKUP_DIR:-./backups}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$backup_dir"

if [ "${DATABASE_ENGINE:-postgresql}" = "sqlite" ]; then
  cp "${SQLITE_PATH:-db.sqlite3}" "$backup_dir/gravity_flip_${timestamp}.sqlite3"
else
  : "${PGHOST:?PGHOST is required}"
  : "${PGDATABASE:?PGDATABASE is required}"
  : "${PGUSER:?PGUSER is required}"
  pg_dump --format=custom --file="$backup_dir/gravity_flip_${timestamp}.dump" "$PGDATABASE"
fi

find "$backup_dir" -type f -mtime +"${BACKUP_RETENTION_DAYS:-14}" -delete
