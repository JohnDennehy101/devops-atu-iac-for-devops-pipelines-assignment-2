resource "aws_iam_policy" "task_execute_role_policy" {
  name        = "${local.prefix}-task-execute-role-policy"
  path        = "/"
  description = "Enable ECS to work with images and send logs"
  policy      = file("./templates/ecs/task-execute-role-policy.json")
}

resource "aws_iam_role" "task_execute_role" {
  name               = "${local.prefix}-task-execute-role"
  assume_role_policy = file("./templates/ecs/task-assume-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "task_execute_role" {
  role       = aws_iam_role.task_execute_role.name
  policy_arn = aws_iam_policy.task_execute_role_policy.arn
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "${local.prefix}-primary"
}

resource "aws_ecs_cluster" "primary" {
  name = "${local.prefix}-cluster"
}
