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
