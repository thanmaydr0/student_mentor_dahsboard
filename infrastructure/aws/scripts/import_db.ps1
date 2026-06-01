param (
    [Parameter(Mandatory=$true)]
    [string]$Ec2Ip,
    
    [Parameter(Mandatory=$true)]
    [string]$DbPassword,
    
    [Parameter(Mandatory=$true)]
    [string]$FilePrefix
)

$ErrorActionPreference = "Stop"

Write-Host "Starting AWS Self-Hosted Restore..." -ForegroundColor Cyan

$TargetDbUrl = "postgresql://postgres.your-tenant-id:${DbPassword}@${Ec2Ip}:5432/postgres"

Write-Host "Restoring schema..."
psql $TargetDbUrl -f "${FilePrefix}_schema.sql"

Write-Host "Restoring data..."
psql $TargetDbUrl -c "SET session_replication_role = 'replica';" -f "${FilePrefix}_data.sql"
psql $TargetDbUrl -c "SET session_replication_role = 'origin';"

Write-Host "Restore complete to AWS self-hosted database!" -ForegroundColor Green
