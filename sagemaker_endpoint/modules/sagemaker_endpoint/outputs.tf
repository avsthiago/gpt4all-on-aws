output "model_bucket_name" {
  value = aws_s3_bucket.model_bucket.bucket
}

# output "sagemaker_endpoint" {
#   value = aws_sagemaker_endpoint.this.endpoint_name
# }

# output "ec2_instance_public_ip" {
#   value = aws_instance.this.public_ip
# }
