#!/bin/bash
set -e

# 1. Update and install Docker
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common git jq
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 2. Clone the Supabase Docker repo
mkdir -p /opt/supabase
cd /opt/supabase
git clone --depth 1 https://github.com/supabase/supabase.git .
cd docker

# 3. Configure the .env file
cp .env.example .env

# Inject secrets from Terraform variables
sed -i "s/POSTGRES_PASSWORD=your-super-secret-and-long-postgres-password/POSTGRES_PASSWORD=${DB_PASSWORD}/g" .env
sed -i "s/JWT_SECRET=your-super-secret-jwt-token-with-at-least-32-characters-long/JWT_SECRET=${JWT_SECRET}/g" .env
sed -i "s|SITE_URL=http://localhost:3000|SITE_URL=${SITE_URL}|g" .env

# Configure Storage to use AWS S3 via EC2 IAM Role
sed -i "s/STORAGE_BACKEND=file/STORAGE_BACKEND=s3/g" .env
# Append S3 variables (the IAM profile handles auth, so no access keys needed)
echo "GLOBAL_S3_BUCKET=${S3_BUCKET_NAME}" >> .env
echo "GLOBAL_S3_REGION=${AWS_REGION}" >> .env
echo "STORAGE_S3_REGION=${AWS_REGION}" >> .env
echo "STORAGE_S3_BUCKET=${S3_BUCKET_NAME}" >> .env
echo "STORAGE_S3_FORCE_PATH_STYLE=false" >> .env

# 4. Start Supabase
docker compose up -d
