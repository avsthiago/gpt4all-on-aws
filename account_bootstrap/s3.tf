
resource "aws_s3_bucket" "model_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "model_bucket_ownership_controls" {
  bucket = aws_s3_bucket.model_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.model_bucket_ownership_controls]

  bucket = aws_s3_bucket.model_bucket.id
  acl    = "private"
}
