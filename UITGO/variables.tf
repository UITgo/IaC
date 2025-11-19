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
}

variable "auth_image" {
  description = "Docker image for auth"
  type        = string
}

variable "trip_image" {
  description = "Docker image for trip"
  type        = string
}

variable "user_image" {
  description = "Docker image for user"
  type        = string
}

variable "driver_image" {
  description = "Docker image for driver"
  type        = string
}