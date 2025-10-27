resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${var.project_name}"
  retention_in_days = 7
  
}