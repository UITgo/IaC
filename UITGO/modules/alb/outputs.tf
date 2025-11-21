output "trip_tg_arn" {
  value = aws_lb_target_group.trip_tg.arn
}

output "auth_tg_arn" {
  value = aws_lb_target_group.auth_tg.arn
}

output "user_tg_arn" {
  value = aws_lb_target_group.user_tg.arn
}

output "driver_tg_arn" {
  value = aws_lb_target_group.driver_tg.arn
}

output "target_groups" {
  value = {
    "auth-service"   = aws_lb_target_group.auth_tg.arn
    "user-service"   = aws_lb_target_group.user_tg.arn
    "trip-service"   = aws_lb_target_group.trip_tg.arn
    "driver-service" = aws_lb_target_group.driver_tg.arn
  }
}
output "alb_arn" {
  value = aws_alb.grpc.arn
}

output "listener_arn" {
  value = aws_lb_listener.grpc_443.arn
}