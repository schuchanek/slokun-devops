#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

export POSTGRES_DB="${POSTGRES_DB:-slokun}"
export POSTGRES_USER="${POSTGRES_USER:-slokun}"
export BACKUP_DIR="${BACKUP_DIR:-$REPO_ROOT/backups}"

mkdir -p "$BACKUP_DIR"

CONTAINER_ID="$(docker compose -f "$REPO_ROOT/docker-compose.yml" ps -q db || true)"
if [ -z "$CONTAINER_ID" ]; then
  echo "Database container is not running." >&2
  exit 1
fi

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_FILE="${POSTGRES_DB}-${TIMESTAMP}.dump"

docker exec "$CONTAINER_ID" bash -lc "pg_dump -U \"\$POSTGRES_USER\" -d \"\$POSTGRES_DB\" -Fc -f \"/tmp/${BACKUP_FILE}\""
docker cp "$CONTAINER_ID:/tmp/${BACKUP_FILE}" "$BACKUP_DIR/"

echo "Backup stored in $BACKUP_DIR/$BACKUP_FILE"
