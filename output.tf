output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id_1" {
  value = module.vpc.public_subnet_id_1
}

output "public_subnet_id_2" {
  value = module.vpc.public_subnet_id_2
}

output "private_subnet_id_1" {
  value = module.vpc.private_subnet_id_1
}

output "private_subnet_id_2" {
  value = module.vpc.private_subnet_id_2
}


output "ecr_repo_url" {
  value = module.ecr.ecr_repo_url
}

