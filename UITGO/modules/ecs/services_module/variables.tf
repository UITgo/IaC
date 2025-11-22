variable "cluster_arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "ecs_task_execution_role" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "service_sg_id" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "target_groups" {
  type = map(string)
}

variable "services" {
  description = "List of ECS services"
  type = list(object({
    name                 = string
    cpu                  = number
    memory               = number
    container_port       = number
    image                = string
  }))
}

variable "auth_rule_arn" {
  type = string
}

variable "user_rule_arn" {
  type = string
}

variable "driver_rule_arn" {
  type = string
}

variable "trip_rule_arn" {
  type = string
}

variable "dockerhub_secret_arn" {
  description = "ARN of DockerHub secret for all services"
  type        = string
}
