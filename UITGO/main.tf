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
  source               = "./modules/cognito"
  user_pool_name       = "uitgo-user-pool"
  app_client_name      = "uitgo-app-client"
  cognito_sms_role_arn = module.iam.cognito_sms_role_arn
}

module "sg" {
  source       = "./modules/sg"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "redis" {
  source             = "./modules/redis"
  project_name       = var.project_name
  environment        = var.environment
  private_subnet_ids = module.vpc.private_subnet_ids
  redis_sg_id        = module.sg.redis_sg_id
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project_name = var.project_name
}
module "ecs" {
  source                      = "./modules/ecs"
  project_name                = var.project_name
  cloudwatch_log_group_name   = module.cloudwatch.cloudwatch_log_group_name
  aws_region                  = var.aws_region
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
}