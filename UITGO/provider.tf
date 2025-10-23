terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  /*backend "s3" {
    bucket = "UITGO-state-bucket"
    key = "UITGO/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = true
  } */
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = "UITGO"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}