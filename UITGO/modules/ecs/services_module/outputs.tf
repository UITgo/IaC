output "ecs_service_names" {
  value = [for s in var.services : s.name]
}
