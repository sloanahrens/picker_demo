resource "aws_s3_bucket" "static" {
  bucket = "picker-${var.stack_name}-static-assets"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket" "uploaded" {
  bucket = "picker-${var.stack_name}-uploaded-assets"
  acl    = "public-read"
}
