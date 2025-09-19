output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "Nome do bucket S3 criado"
}
