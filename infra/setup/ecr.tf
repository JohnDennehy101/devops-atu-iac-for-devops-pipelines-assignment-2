resource "aws_ecr_repository" "static_site" {
  name                 = "iac-for-devops-pipelines-assignment-2-static-site"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}
