output "user_service_role_arn" {
  value = aws_iam_role.user_service_role.arn
}

output "driver_service_role_arn" {
  value = aws_iam_role.driver_service_role.arn
}