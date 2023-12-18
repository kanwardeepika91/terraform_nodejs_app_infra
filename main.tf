module "vpc" {
  source   = "./modules/1.vpc"
  vpc_cidr = var.vpc_cidr

}

module "ecr" {
  source = "./modules/4.ecr"

}

module "ecs" {
  source             = "./modules/2.ecs"
  vpc_id             = module.vpc.vpc_id
  alb_public_subnets = [module.vpc.public_subnet_id_1, module.vpc.public_subnet_id_1]
  container_port     = var.container_port
} 