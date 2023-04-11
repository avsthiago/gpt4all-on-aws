variable "s3_bucket_name" {
    type = string
    description = "Name of the S3 bucket to store the model binaries."
}

variable "ecr_repository_endpoint_name" {
  type = string
  description = "value for the ECR repository name"
}


# variable "ecr_repository_name" {
#   type = string
# }

# variable "sagemaker_model_name" {
#   type = string
# }

# variable "sagemaker_endpoint_name" {
#   type = string
# }

# variable "s3_model_data_bucket" {
#   type = string
# }

# variable "s3_model_data_key" {
#   type = string
# }

# variable "instance_type" {
#   type = string
#   default = "t2.micro"
# }
