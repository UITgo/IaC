output "redis_sg_id" {
  value = aws_security_group.redis_sg.id
}

output "msk_sg_id" {
  value = aws_security_group.msk_sg.id
}
