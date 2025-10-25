module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
}

module "s3" {
  source                  = "./modules/s3"
  project_name            = var.project_name
  user_service_role_arn   = module.iam.user_service_role_arn
  driver_service_role_arn = module.iam.driver_service_role_arn
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "cognito" {
  source = "./modules/cognito"
  user_pool_name = "uitgo-user-pool"
  app_client_name = "uitgo-app-client"
  cognito_sms_role_arn = module.iam.cognito_sms_role_arn
}