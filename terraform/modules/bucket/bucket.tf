resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = var.bucket_name
  }
}

# Habilitar versionamento (opcional)
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
