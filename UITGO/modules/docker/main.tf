resource "aws_secretsmanager_secret" "dockerhub_secret" {
  name = "dockerhub-secret"
}

resource "aws_secretsmanager_secret_version" "dockerhub_secret_version" {
  secret_id     = aws_secretsmanager_secret.dockerhub_secret.id
  secret_string = jsonencode({
    username = var.docker_username
    password = var.docker_password
  })
}
