resource "aws_ecs_cluster" "primary" {
  name = "${local.prefix}-cluster"
}
