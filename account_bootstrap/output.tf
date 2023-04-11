output "model_bucket_name" {
  value = aws_s3_bucket.model_bucket.bucket
}


output "aws_ecr_repository_arn" {
  value = aws_ecr_repository.ecr_repository_endpoint.arn
}