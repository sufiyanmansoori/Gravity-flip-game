#!/usr/bin/env sh
set -eu

: "${TARGET_URL:=http://127.0.0.1:8000/api/schema/}"
: "${REQUESTS:=100}"
: "${CONCURRENCY:=10}"

if command -v hey >/dev/null 2>&1; then
  hey -n "$REQUESTS" -c "$CONCURRENCY" "$TARGET_URL"
elif command -v curl >/dev/null 2>&1; then
  i=0
  while [ "$i" -lt "$REQUESTS" ]; do curl --fail --silent "$TARGET_URL" >/dev/null & i=$((i + 1)); done
  wait
  printf '%s\n' "Completed $REQUESTS requests against $TARGET_URL"
else
  printf '%s\n' 'Install hey or curl to run performance tests.' >&2
  exit 1
fi
