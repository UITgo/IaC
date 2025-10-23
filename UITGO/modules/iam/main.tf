resource "aws_iam_role" "user_service_role" {
  name = "${var.project_name}-user-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect = "Allow"
        Principal = {Service = "ecs-tasks.amazonaws.com"}
        Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "driver_service_role" {
  name = "${var.project_name}-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action = "sts:AssumeRole"
    }]
  })
}