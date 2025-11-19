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

resource "aws_iam_role" "static_task_role" {
  name               = "${local.prefix}-static-task-role"
  assume_role_policy = file("./templates/ecs/task-assume-role-policy.json")
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "${local.prefix}-primary"
}

resource "aws_ecs_cluster" "primary" {
  name = "${local.prefix}-cluster"
}

resource "aws_ecs_task_definition" "primary" {
  family                   = "${local.prefix}-primary"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.static_task_role.arn
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execute_role.arn
  container_definitions = jsonencode([
    {
      name              = "static_site"
      image             = var.ecr_static_site_image
      essential         = true
      memoryReservation = 512
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "static"
        }
      }
    },
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_security_group" "ecs_service" {
  description = "Access for ecs service"
  name        = "${local.prefix}-ecs-service"
  vpc_id      = aws_vpc.primary.id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "primary" {
  name                   = "${local.prefix}-static"
  cluster                = aws_ecs_cluster.primary.name
  task_definition        = aws_ecs_task_definition.primary.arn
  desired_count          = 2
  launch_type            = "FARGATE"
  platform_version       = "1.4.0"
  enable_execute_command = true
  network_configuration {
    # TODO: Remove once load balancer in place
    assign_public_ip = true
    # TODO: make these private subnets once load balancer in place
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_service.id]
  }
}
