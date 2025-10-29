output "user_service_role_arn" {
  value = aws_iam_role.user_service_role.arn
}

output "driver_service_role_arn" {
  value = aws_iam_role.driver_service_role.arn
}

output "cognito_sms_role_arn" {
  value = aws_iam_role.cognito_sms_role.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}