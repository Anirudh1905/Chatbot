resource "aws_s3_bucket" "model_registry" {
  bucket_prefix = "model-registry-"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.model_registry.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.model_registry.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_ecr_repository" "ecr" {
  name = "chatbot"

  image_scanning_configuration {
    scan_on_push = true
  }
}