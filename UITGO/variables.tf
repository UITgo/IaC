variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Name for this project"
  default     = "uitgo"
}

variable "environment" {
  description = "Environment for this deployment"
  type        = string
  default     = "dev"
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for the ALB"
  type        = string
  default = "arn:aws:acm:ap-southeast-1:575675584065:certificate/48cd6784-46e6-481e-81f7-15901ca2b8d8"
}

variable "auth_image" {
  description = "Docker image for auth"
  type        = string
  default = "uyenthy/auth-service:latest"
}

variable "trip_image" {
  description = "Docker image for trip"
  type        = string
  default = "uyenthy/trip-service:latest"
}

variable "user_image" {
  description = "Docker image for user"
  type        = string
  default = "uyenthy/user-service:latest"
}

variable "driver_image" {
  description = "Docker image for driver"
  type        = string
  default = "uyenthy/driver-service:latest"
}

variable "dockerhub_secret_arn" {
  description = "ARN of DockerHub secret for all services"
  type        = string
}
