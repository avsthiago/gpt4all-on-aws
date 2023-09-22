


# resource "aws_sagemaker_model" "this" {
#   name               = var.sagemaker_model_name
#   execution_role_arn = aws_iam_role.sagemaker_execution_role.arn

#   primary_container {
#     image          = aws_ecr_repository.this.repository_url
#     model_data_url = "s3://${var.s3_model_data_bucket}/${var.s3_model_data_key}"
#   }
# }

# resource "aws_sagemaker_endpoint_configuration" "this" {
#   name = "${var.sagemaker_model_name}-config"

#   production_variants {
#     variant_name           = "default"
#     model_name             = aws_sagemaker_model.this.name
#     initial_instance_count = 1
#     instance_type          = "ml.t2.medium"
#   }
# }

# resource "aws_sagemaker_endpoint" "this" {
#   name                 = var.sagemaker_endpoint_name
#   endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name
# }

# resource "aws_ecr_repository" "this" {
#   name = var.ecr_repository_name
# }

# resource "aws_s3_bucket" "model_data_bucket" {
#   bucket = var.s3_model_data_bucket
#   acl    = "private"
# }


# resource "aws_instance" "this" {
#   ami           = "ami-0c94855ba95b798c7" # Amazon Linux 2 AMI
#   instance_type = var.instance_type

#   tags = {
#     Name = "Streamlit-EC2"
#   }

#   # Assumes you have a proper IAM role configured for your EC2 instance
#   iam_instance_profile = "streamlit-ec2-instance-profile"

#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               amazon-linux-extras install docker -y
#               service docker start
#               usermod -a -G docker ec2-user
#               docker run -d -p 80:8501 --restart unless-stopped --name streamlit-container <YOUR_STREAMLIT_DOCKER_IMAGE>
#               EOF
# }
