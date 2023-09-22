resource "aws_ecr_repository" "ecr_repository_endpoint" {
  name = var.ecr_repository_endpoint_name

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
