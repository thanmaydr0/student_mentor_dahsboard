output "supabase_public_ip" {
  description = "The public IP address of the self-hosted Supabase instance"
  value       = aws_instance.supabase_server.public_ip
}

output "supabase_studio_url" {
  description = "The URL to access the Supabase Studio dashboard"
  value       = "http://${aws_instance.supabase_server.public_ip}:8000"
}

output "supabase_api_url" {
  description = "The API URL for your frontend (.env VITE_SUPABASE_URL)"
  value       = "http://${aws_instance.supabase_server.public_ip}:8000"
}

output "s3_bucket_name" {
  description = "The S3 Bucket used for storage"
  value       = aws_s3_bucket.supabase_storage.id
}
