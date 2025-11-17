resource "aws_ecr_repository" "static_site" {
  name                 = "iac-for-devops-pipelines-assignment-2-static-site"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    # TODO: Set to false when deploying final version (will slow pipelines)
    scan_on_push = false
  }
}
