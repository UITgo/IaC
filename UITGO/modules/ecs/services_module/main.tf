locals {
  service_definitions = { for s in var.services : s.name => s }
}

resource "aws_ecs_task_definition" "task" {
  for_each = local.service_definitions

  family                   = each.key
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_execution_role
  task_role_arn            = var.ecs_task_execution_role

  container_definitions = jsonencode([
    {
      name      = each.key
      image     = each.value.image
      essential = true
      portMappings = [{
        containerPort = each.value.container_port
        protocol      = "tcp"
      }]
    }
  ])
}

resource "aws_ecs_service" "service" {
  for_each = local.service_definitions

  name            = each.key
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.task[each.key].arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.service_sg_id]
  }

  load_balancer {
    target_group_arn = var.target_groups[each.key]
    container_name   = each.key
    container_port   = each.value.container_port
  }

  depends_on = [
  aws_ecs_task_definition.task,
  var.auth_rule_arn,
  var.user_rule_arn,
  var.driver_rule_arn,
  var.trip_rule_arn,
]

}

resource "aws_appautoscaling_target" "target" {
  for_each = local.service_definitions

  max_capacity       = 5
  min_capacity       = 1
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${each.key}"
  depends_on = [aws_ecs_service.service]
}

resource "aws_appautoscaling_policy" "cpu" {
  for_each = local.service_definitions

  name               = "${each.key}-cpu-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.target[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.target[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 70

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
