#!/bin/bash
set -e

echo "Starting AWS Self-Hosted Restore..."

# Usage: ./import_db.sh <EC2_PUBLIC_IP> <DB_PASSWORD> <PREFIX>

if [ -z "$3" ]; then
  echo "Error: Missing arguments."
  echo "Usage: ./import_db.sh <EC2_PUBLIC_IP> <DB_PASSWORD> <FILE_PREFIX_FROM_EXPORT>"
  exit 1
fi

EC2_IP="$1"
DB_PASS="$2"
PREFIX="$3"
TARGET_DB_URL="postgresql://postgres:${DB_PASS}@${EC2_IP}:5432/postgres"

echo "Restoring schema..."
# We disable triggers during data restore to avoid foreign key constraints failing during bulk insert
psql "$TARGET_DB_URL" -f "${PREFIX}_schema.sql"

echo "Restoring data..."
psql "$TARGET_DB_URL" -c "SET session_replication_role = 'replica';" -f "${PREFIX}_data.sql"
psql "$TARGET_DB_URL" -c "SET session_replication_role = 'origin';"

echo "Restore complete to AWS self-hosted database!"
