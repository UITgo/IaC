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
  source             = "./modules/sg"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
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

module "msk" {
  source             = "./modules/msk"
  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  msk_sg_id          = module.sg.msk_sg_id
}


module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = var.certificate_arn
  vpc_id            = module.vpc.vpc_id
}


module "ecs" {
  source       = "./modules/ecs"
  project_name = var.project_name
}

module "ecs_services" {
  source = "./modules/ecs/services_module"

  cluster_arn             = module.ecs.ecs_cluster_arn
  cluster_name            = module.ecs.ecs_cluster_name
  ecs_task_execution_role = module.iam.ecs_task_execution_role_arn
  private_subnet_ids      = module.vpc.private_subnet_ids
  service_sg_id           = module.sg.service_sg_id

  alb_listener_arn = module.alb.listener_arn
  target_groups    = module.alb.target_groups

  services = [
    {
      name           = "auth-service"
      cpu            = 256
      memory         = 512
      container_port = 3000
      image          = var.auth_image
    },
    {
      name           = "user-service"
      cpu            = 256
      memory         = 512
      container_port = 3001
      image          = var.user_image
    },
    {
      name           = "trip-service"
      cpu            = 256
      memory         = 512
      container_port = 3002
      image          = var.trip_image
    },
    {
      name           = "driver-service"
      cpu            = 256
      memory         = 512
      container_port = 3003
      image          = var.driver_image
    }
  ]
}