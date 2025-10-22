module "vpc" {
  source       = "./module/vpc"
  project_name = var.project_name 
}