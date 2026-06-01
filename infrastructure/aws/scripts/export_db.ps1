param (
    [Parameter(Mandatory=$true)]
    [string]$SourceDbUrl
)

$ErrorActionPreference = "Stop"

Write-Host "Starting Supabase Cloud Export..." -ForegroundColor Cyan

$DateStr = Get-Date -Format "yyyyMMdd"
$OutputFilePrefix = "supabase_backup_$DateStr"
$SchemaFile = "${OutputFilePrefix}_schema.sql"
$DataFile = "${OutputFilePrefix}_data.sql"

Write-Host "Dumping schema..."
pg_dump $SourceDbUrl --clean --if-exists --quote-all-identifiers --schema-only --schema="public" --schema="auth" -f $SchemaFile

Write-Host "Dumping data..."
pg_dump $SourceDbUrl --data-only --schema="public" --schema="auth" -f $DataFile

Write-Host "Export complete! Files generated: $SchemaFile, $DataFile" -ForegroundColor Green
