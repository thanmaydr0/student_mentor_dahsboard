variable "aws_region" {
  description = "The AWS region to deploy into"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance type for self-hosted Supabase"
  default     = "t3.large" # Supabase requires at least 4GB RAM, t3.large has 8GB
}

variable "db_password" {
  description = "The PostgreSQL database password"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "Secret used for generating JWT tokens"
  type        = string
  sensitive   = true
}

variable "site_url" {
  description = "The base URL of the site"
  default     = "http://localhost:3000"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for Supabase Storage"
  type        = string
}
