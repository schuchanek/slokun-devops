#!/usr/bin/env bash
set -euo pipefail

POSTGRES_DB="${POSTGRES_DB:-slokun}"
POSTGRES_USER="${POSTGRES_USER:-slokun}"
BACKUP_DIR="${BACKUP_DIR:-/backups}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$BACKUP_DIR"
pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" -Fc -f "$BACKUP_DIR/${POSTGRES_DB}-${TIMESTAMP}.dump"
echo "Backup written to $BACKUP_DIR/${POSTGRES_DB}-${TIMESTAMP}.dump"
