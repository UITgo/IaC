resource "aws_alb" "grpc" {
  name = "${var.project_name}-alb-grpc"
  internal = false

  load_balancer_type = "application"
  subnets = var.public_subnet_ids
}

resource "aws_lb_listener" "grpc_443" {
  load_balancer_arn = aws_alb.grpc.arn
  port              = "443"
  protocol = "HTTP"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.trip_tg.arn
  }
}

resource "aws_lb_target_group" "auth_tg" {
  name     = "${var.project_name}-auth-tg"
  port     = 8080
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "driver_tg" {
  name     = "${var.project_name}-driver-tg"
  port     = 8082
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "user_tg" {
  name     = "${var.project_name}-user-tg"
  port     = 8081
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
}


resource "aws_lb_target_group" "trip_tg" {
  name     = "${var.project_name}-trip-tg"
  port     = 8083
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
}

