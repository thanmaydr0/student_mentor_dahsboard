# AWS Self-Hosted Supabase Migration Guide

This directory contains the Infrastructure-as-Code (Terraform) and database migration scripts needed to move your Supabase project out of the free tier and into a massively scalable AWS environment.

## 1. Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed.
- AWS CLI installed and configured (`aws configure` with an IAM user having Admin access).
- Postgres client (`psql` and `pg_dump`) installed locally.

## 2. Deploy Infrastructure
1. Navigate to the terraform directory:
   ```bash
   cd terraform
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan and apply the deployment:
   ```bash
   terraform apply -var="db_password=YOUR_SUPER_SECRET_DB_PASS" -var="jwt_secret=YOUR_32_CHAR_LONG_JWT_SECRET" -var="s3_bucket_name=edupredict-supabase-storage-bucket"
   ```
4. Wait 5-10 minutes for the EC2 instance to boot, install Docker, and download the Supabase images.
5. Take note of the `supabase_public_ip` and `supabase_api_url` outputs printed to your terminal.

## 3. Migrate the Database
1. Navigate to the scripts directory:
   ```bash
   cd ../scripts
   ```
2. Export your free-tier database (replace with your actual Supabase cloud DB URL):
   ```bash
   ./export_db.sh "postgresql://postgres.[project]:[password]@aws-0-eu-central-1.pooler.supabase.com:6543/postgres"
   ```
   *This creates `supabase_backup_[date]_schema.sql` and `supabase_backup_[date]_data.sql`.*
3. Import the data into your new AWS instance:
   ```bash
   ./import_db.sh <EC2_PUBLIC_IP_FROM_TERRAFORM> YOUR_SUPER_SECRET_DB_PASS supabase_backup_[date]
   ```

## 4. Update Frontend
In your `apps/web/.env` and `apps/api/.env`, update the following variables:
```env
VITE_SUPABASE_URL=http://<EC2_PUBLIC_IP>:8000
# VITE_SUPABASE_ANON_KEY remains the same as long as you used the same JWT_SECRET in Terraform.
```
*Note: For production, you should place the EC2 instance behind an AWS Application Load Balancer with an ACM SSL Certificate so you can use `https://`.*

## 5. File Storage (AWS S3)
The Terraform scripts automatically configured an S3 bucket and attached an IAM Instance Profile to the EC2 server. When you use `supabase.storage.from('bucket').upload()`, the files will seamlessly stream into your AWS S3 bucket instead of the EC2 local disk.
