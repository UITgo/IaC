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

resource "aws_iam_role" "cognito_sms_role" {
  name = "${var.project_name}-sms-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect = "Allow",
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "cognito_sms_policy" {
  name = "${var.project_name}-sms-policy"
  role = aws_iam_role.cognito_sms_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement: [
      {
        Effect   = "Allow"
        Action   = ["sns:Publish"]
        Resource = "*"
      }
    ]
  })
}