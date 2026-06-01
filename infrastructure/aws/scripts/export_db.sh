#!/bin/bash
set -e

echo "Starting Supabase Cloud Export..."

# Requires standard PostgreSQL client tools (pg_dump)
# Usage: ./export_db.sh <SUPABASE_DB_URL_WITH_PASSWORD>

if [ -z "$1" ]; then
  echo "Error: Missing source database URL."
  echo "Usage: ./export_db.sh postgresql://postgres.[project-ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres"
  exit 1
fi

SOURCE_DB_URL="$1"
OUTPUT_FILE="supabase_backup_$(date +%Y%m%d).sql"

echo "Dumping roles..."
# Supabase cloud restricts dumping roles easily, so we usually just dump data. 
# We'll dump the schema and data for public and auth schemas.

"/mnt/c/Program Files/PostgreSQL/18/bin/pg_dump.exe" "$SOURCE_DB_URL" \
  --clean \
  --if-exists \
  --quote-all-identifiers \
  --schema-only \
  --schema="public" \
  --schema="auth" \
  -f "${OUTPUT_FILE}_schema.sql"

echo "Dumping data..."
"/mnt/c/Program Files/PostgreSQL/18/bin/pg_dump.exe" "$SOURCE_DB_URL" \
  --data-only \
  --schema="public" \
  --schema="auth" \
  -f "${OUTPUT_FILE}_data.sql"

echo "Export complete! Files generated: ${OUTPUT_FILE}_schema.sql, ${OUTPUT_FILE}_data.sql"
