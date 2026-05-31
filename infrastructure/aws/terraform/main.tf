terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Fetch latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 2. Security Group for Supabase
resource "aws_security_group" "supabase_sg" {
  name        = "supabase_sg"
  description = "Allow Supabase inbound traffic"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, restrict to specific IPs
  }

  ingress {
    description = "Supabase API Gateway"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. S3 Bucket for File Storage
resource "aws_s3_bucket" "supabase_storage" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_cors_configuration" "supabase_cors" {
  bucket = aws_s3_bucket.supabase_storage.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

# 4. IAM Role for EC2 to access S3
resource "aws_iam_role" "ec2_s3_access_role" {
  name = "supabase-ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_access_policy" {
  name = "supabase-ec2-s3-access-policy"
  role = aws_iam_role.ec2_s3_access_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.supabase_storage.arn,
          "${aws_s3_bucket.supabase_storage.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "supabase_instance_profile" {
  name = "supabase-instance-profile"
  role = aws_iam_role.ec2_s3_access_role.name
}

# 5. Create the EC2 Instance with EBS backing
resource "aws_instance" "supabase_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.supabase_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.supabase_instance_profile.name

  # Persistent EBS Volume for Database
  root_block_device {
    volume_size = 50 # 50 GB
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/user_data.sh", {
    DB_PASSWORD    = var.db_password
    JWT_SECRET     = var.jwt_secret
    SITE_URL       = var.site_url
    S3_BUCKET_NAME = aws_s3_bucket.supabase_storage.id
    AWS_REGION     = var.aws_region
  })

  tags = {
    Name = "Supabase-Self-Hosted"
  }
}
