resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.project_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  execution_role_arn = var.ecs_task_execution_role_arn
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-container"
      image     = "amazonlinux:2"
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.cloudwatch_log_group_name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.project_name
        }
      }
    }
  ])
}