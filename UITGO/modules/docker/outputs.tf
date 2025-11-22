output "dockerhub_secret_arn" {
  value = aws_secretsmanager_secret.dockerhub_secret.arn
}