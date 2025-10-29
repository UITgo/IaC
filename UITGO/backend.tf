terraform {
  backend "s3" {
    bucket         = "uitgo-terraform-state"
    key            = "UITGO/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
