 module "vpc" {
  source   = "./modules/1.vpc"
  vpc_cidr = var.vpc_cidr

}  


module "ecs" {
  source             = "./modules/2.ecs"
  vpc_id             = module.vpc.vpc_id
  alb_public_subnets = [module.vpc.public_subnet_id_1, module.vpc.public_subnet_id_2]
  containerPort     = var.containerPort
  hostPort = var.hostPort
  fargate_memory = var.fargate_memory
  fargate_cpu = var.fargate_cpu
  container_cpu = var.container_cpu
  container_memory = var.container_memory
} 