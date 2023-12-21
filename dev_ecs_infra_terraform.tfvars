env      = "dev-ecs"
region   = "us-east-1"
vpc_cidr = "10.0.0.0/16"
/* public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"
private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24" */

# fargate details 
fargate_memory = 512
fargate_cpu = 256

# task Container definition ports
containerPort = 6789
hostPort = 6789
container_memory = 512
container_cpu = 256

# app count -- no. of container replicas
container_app_count = 4




